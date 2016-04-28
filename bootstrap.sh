echo

_JIRA_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
chmod 700 "$_JIRA_DIR"

endpoint="https://elcjira.atlassian.net/rest"

log="${_JIRA_DIR}/jira.log"
touch "$log"
chmod 600 "$log"

cookie_jar="${_JIRA_DIR}/.jira_cookies"
touch "$cookie_jar"
chmod 600 "$cookie_jar"

# Check to see if credentials file exists
# If it does not, then prompt for username and password

credentials="${_JIRA_DIR}/.jira_credentials"
if [ ! -f "${credentials}" ]; then
  read -p "Username: " jira_user
  read -s -p "Password: " jira_pass

  echo "{ \"username\": \"${jira_user}\", \"password\": \"${jira_pass}\" }" > $credentials
fi
chmod 600 "$credentials"

# Load Utility Methods
[ -f "${_JIRA_DIR}/util.sh" ] && . ${_JIRA_DIR}/util.sh

# Load API endpoints
# https://docs.atlassian.com/jira/REST/latest/

[ -f "${_JIRA_DIR}/resource/auth.sh" ] && . ${_JIRA_DIR}/resource/auth.sh
[ -f "${_JIRA_DIR}/resource/issue_worklog.sh" ] && . ${_JIRA_DIR}/resource/issue_worklog.sh
