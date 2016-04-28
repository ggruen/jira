function jira.auth() {
  # Authenticate
  curl -H "Content-Type: application/json" -c "$_JIRA_COOKIE" -X POST -d "`cat ${_JIRA_AUTH}`" ${_JIRA_API}/auth/1/session

  # Get Session
  curl -b "$_JIRA_COOKIE" ${_JIRA_API}/auth/1/session
  echo
  echo
}

jira.auth
