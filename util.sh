function jira.flush() {
  # Confirm
  _jira.log "Flushing..."
  rm -f "$credentials"
}

alias _jira.date='date -u +"%Y-%m-%dT%H:%M:%SZ"'
function _jira.log() {
  local msg="$@"
  echo; echo; echo $msg; echo
  echo "[`_jira.date`] $msg" >> "$log"
}
function _jira.info() {
  local msg="INFO - $@"
  _jira.log "$msg"
}
function _jira.error() {
  local msg="ERROR - $@"
  _jira.log "$msg"
}
function _jira.warn() {
  local msg="WARN - $@"
  _jira.log "$msg"
}

function _jira.to_seconds() {
  local time_spent="$1"

  # Convert to seconds based on last character in arg
  case "${time_spent: -1}" in 
    "d")
      # 1 Day = 8 hours
      time_spent=`echo "(${time_spent%?} * 60 * 60 * 8)/1" | bc`
      ;;
    "h")
      time_spent=`echo "(${time_spent%?} * 60 * 60)/1" | bc`
      ;;
    "m")
      time_spent=`echo "(${time_spent%?} * 60)/1" | bc`
      ;;
    "s")
      time_spent=${time_spent%?}
      ;;
    [0-9])
      # Already in seconds
      ;;
    *)
      # Throw Error
      _jira.error "jira.issue_worklog.create - Invalid time spent: ${time_spent}"
      return
      ;;
  esac

  echo $time_spent
}

function quote_esc() {
  local text="$@"
  echo ${text//\"/\\\"}
}
