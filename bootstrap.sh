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

_JIRA_AUTH="${_JIRA_DIR}/.jira_credentials"

# Load Utility Methods
[ -f "${_JIRA_DIR}/util.sh" ] && . ${_JIRA_DIR}/util.sh

_jira.init

# Load API endpoints
# https://docs.atlassian.com/jira/REST/latest/

[ -f "${_JIRA_DIR}/resource/auth.sh" ] && . ${_JIRA_DIR}/resource/auth.sh
[ -f "${_JIRA_DIR}/resource/issue_worklog.sh" ] && . ${_JIRA_DIR}/resource/issue_worklog.sh
