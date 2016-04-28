function jira.auth() {
  # Authenticate
  curl -H "Content-Type: application/json" -c "$cookie_jar" -X POST -d "`cat ${credentials}`" ${endpoint}/auth/1/session

  # Get Session
  curl -b "$cookie_jar" ${endpoint}/auth/1/session
  echo
  echo
}

jira.auth
