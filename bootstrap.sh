# https://github.com/cloudily/jira

_JIRA_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
chmod 700 "$_JIRA_DIR"

# Load external configuration
unset _JIRA_API
_JIRA_CONFIG="${_JIRA_DIR}/.jirarc"
touch "$_JIRA_CONFIG"
chmod 600 "$_JIRA_CONFIG"
[ -f "${_JIRA_CONFIG}" ] && . ${_JIRA_CONFIG}

# Set the API host
[ -z "$_JIRA_API" ] && _JIRA_API="https://elcjira.atlassian.net/rest"

_JIRA_LOG="${_JIRA_DIR}/jira.log"
touch "$_JIRA_LOG"
chmod 600 "$_JIRA_LOG"

_JIRA_COOKIE="${_JIRA_DIR}/.jira_cookies"
touch "$_JIRA_COOKIE"
chmod 600 "$_JIRA_COOKIE"

_JIRA_AUTH="${_JIRA_DIR}/.jira_credentials"

# Load Utility Methods
[ -f "${_JIRA_DIR}/util.sh" ] && . ${_JIRA_DIR}/util.sh

_jira.init

# Load API endpoints
# https://docs.atlassian.com/jira/REST/latest/

_JIRA_RESOURCES=(
  "auth.sh"
  "issue_worklog.sh"
)

for file in "${_JIRA_RESOURCES[@]}"; do
  [ -f "${_JIRA_DIR}/resource/$file" ] && . "${_JIRA_DIR}/resource/$file"
done
unset file
