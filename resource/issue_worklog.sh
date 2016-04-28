function jira.issue_worklog.list() {
  local ticket="$1"
  if [ -z "${ticket}" ]; then
    read -p "Ticket: " ticket
  fi
  curl -H "Content-Type: application/json" -b "$cookie_jar" ${endpoint}/api/2/issue/${ticket}/worklog
}

function jira.issue_worklog.get() {
  local ticket="$1"
  if [ -z "${ticket}" ]; then
    read -p "Ticket: " ticket
  fi
  curl -H "Content-Type: application/json" -b "$cookie_jar" ${endpoint}/api/2/issue/${ticket}/worklog/${worklog_id}
}

# @method jira.issue_worklog.create
# @args $1 = ticket
#       $2 = time_spent
# @example jira.issue_worklog.create PSLP-115 1.5h "Writing code."
function jira.issue_worklog.create() {
  local ticket="$1"
  local time_spent="$2"
  local comment="$3"
  if [ -z "${ticket}" ]; then
    read -p "Ticket: " ticket
  fi
  if [ -z "${time_spent}" ]; then
    read -p "Time Spent (seconds): " time_spent
  fi
  if [ -z "${comment}" ]; then
    read -p "Comment: " comment
  fi

  # Convert to seconds based on last character in arg
  time_spent="`_jira.to_seconds ${time_spent}`"

  if [ -z "$time_spent" ]; then
    _jira.error "jira.issue_worklog.create - Invalid time spent: ${time_spent}"
    return
  fi

  if [ "$time_spent" -lt "60" ]; then
    _jira.error "jira.issue_worklog.create - Time spent does not exceed minimum of 60s: ${time_spent}"
    return
  fi

  curl -H "Content-Type: application/json" -b "$cookie_jar" -X POST -d "{ \"comment\": \"`quote_esc ${comment}`\", \"timeSpentSeconds\": ${time_spent} }" ${endpoint}/api/2/issue/${ticket}/worklog
}

function jira.issue_worklog.update() {
  local ticket="$1"
  local worklog_id="$1"
  if [ -z "${ticket}" ]; then
    read -p "Ticket: " ticket
  fi
  if [ -z "${worklog_id}" ]; then
    read -p "Worklog: " worklog_id
  fi
  curl -H "Content-Type: application/json" -b "$cookie_jar" -X PUT -d '{ "comment": "Testing", "timeSpentSeconds": 60 }' ${endpoint}/api/2/issue/${ticket}/worklog/${worklog_id}
}

function jira.issue_worklog.delete() {
  local ticket="$1"
  local worklog_id="$1"
  if [ -z "${ticket}" ]; then
    read -p "Ticket: " ticket
  fi
  if [ -z "${worklog_id}" ]; then
    read -p "Worklog: " worklog_id
  fi
  curl -H "Content-Type: application/json" -b "$cookie_jar" -X DELETE ${endpoint}/api/2/issue/${ticket}/worklog/${worklog_id}
}
