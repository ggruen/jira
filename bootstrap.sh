echo

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
chmod 700 "$DIR"

endpoint="https://elcjira.atlassian.net/rest"
credentials="${DIR}/.jira_credentials"

log="${DIR}/jira.log"
touch "$log"
chmod 600 "$log"

cookie_jar="${DIR}/.jira_cookies"
touch "$cookie_jar"
chmod 600 "$cookie_jar"

# Check to see if credentials file exists
# If it does not, then prompt for username and password

if [ ! -f "${credentials}" ]; then
  read -p "Username: " jira_user
  read -s -p "Password: " jira_pass

  echo "{ \"username\": \"${jira_user}\", \"password\": \"${jira_pass}\" }" > $credentials
fi
chmod 600 "$credentials"

function jira.flush() {
  # Confirm
  _jira.log "Flushing..."
  rm -f "$credentials"
}

alias _jira.date='date -u +"%Y-%m-%dT%H:%M:%SZ"'
function _jira.log() {
  echo "[`_jira.date`] $@" >> "$log"
}
function _jira.info() {
  echo "[`_jira.date`] INFO - $@" >> "$log"
}
function _jira.error() {
  echo "[`_jira.date`] ERROR - $@" >> "$log"
}
function _jira.warn() {
  echo "[`_jira.date`] WARN - $@" >> "$log"
}

# Authenticate
curl -H "Content-Type: application/json" -c "$cookie_jar" -X POST -d "`cat ${credentials}`" ${endpoint}/auth/1/session

# Get Session
curl -b "$cookie_jar" ${endpoint}/auth/1/session
echo
echo

# Load API endpoints
# https://docs.atlassian.com/jira/REST/latest/

[ -f "${DIR}/resource/issue_worklog.sh" ] && . ${DIR}/resource/issue_worklog.sh
