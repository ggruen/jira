echo

_JIRA_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
chmod 700 "$_JIRA_DIR"

_JIRA_API="https://elcjira.atlassian.net/rest"

_JIRA_LOG="${_JIRA_DIR}/jira.log"
touch "$_JIRA_LOG"
chmod 600 "$_JIRA_LOG"

_JIRA_COOKIE="${_JIRA_DIR}/.jira_cookies"
touch "$_JIRA_COOKIE"
chmod 600 "$_JIRA_COOKIE"

# Check to see if credentials file exists
# If it does not, then prompt for username and password

_JIRA_AUTH="${_JIRA_DIR}/.jira_credentials"
if [ ! -f "${_JIRA_AUTH}" ]; then
  read -p "Username: " jira_user
  read -s -p "Password: " jira_pass

  echo "{ \"username\": \"${jira_user}\", \"password\": \"${jira_pass}\" }" > $_JIRA_AUTH
  unset jira_user
  unset jira_pass
fi
chmod 600 "$_JIRA_AUTH"

# Load Utility Methods
[ -f "${_JIRA_DIR}/util.sh" ] && . ${_JIRA_DIR}/util.sh

# Load API endpoints
# https://docs.atlassian.com/jira/REST/latest/

[ -f "${_JIRA_DIR}/resource/auth.sh" ] && . ${_JIRA_DIR}/resource/auth.sh
[ -f "${_JIRA_DIR}/resource/issue_worklog.sh" ] && . ${_JIRA_DIR}/resource/issue_worklog.sh
