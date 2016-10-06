function jira.flush() {
  # Confirm
  _jira.log "Flushing..."
  rm -f "$_JIRA_AUTH"

  _jira.init
}

# Check to see if credentials file exists
# If it does not, then prompt for username and password
function _jira.init() {
  local jira_user=
  local jira_pass=

  if [ ! -f "${_JIRA_AUTH}" ]; then
    read -p "Username: " jira_user
    read -s -p "Password: " jira_pass

    echo "{ \"username\": \"${jira_user}\", \"password\": \"${jira_pass}\" }" > $_JIRA_AUTH
    unset jira_user
    unset jira_pass
  fi

  chmod 600 "$_JIRA_AUTH"
}

alias _jira.date='date -u +"%Y-%m-%dT%H:%M:%SZ"'
function _jira.log() {
  local msg="$@"
  echo; echo; printf "$msg"; echo
  echo "[`_jira.date`] $msg" | sed "s,$(printf '\\\\033')\\[[0-9;]*[a-zA-Z],,g" >> "$_JIRA_LOG"
}
function _jira.info() {
  local msg="\033[0;32mINFO\033[0m - $@"
  _jira.log "$msg"
}
function _jira.error() {
  local msg="\033[0;31mERROR\033[0m - $@"
  _jira.log "$msg"
}
function _jira.warn() {
  local msg="\033[0;33mWARN\033[0m - $@"
  _jira.log "$msg"
}

function _jira.to_seconds() {
  local time_spent="$1"

  # If the string contains a colon, assume the format is hh:mm
  if [[ $time_spent == *":"* ]]; then
    time_spent=`_jira.formatted_time_to_seconds "$time_spent"`
    echo $time_spent
    return
  fi

  # Convert to seconds based on last character in arg
  case "${time_spent: -1}" in 
    "w")
      # 1 Week = 5 x 8 hour days
      time_spent=`echo "(${time_spent%?} * 60 * 60 * 8 * 5)/1" | bc`
      ;;
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
      return
      ;;
  esac

  echo $time_spent
}

function _jira.formatted_time_to_seconds() {
  # Expects the format hh:mm

  local IFS=":"
  read -ra TIME <<< "$1"

  local minutes="${TIME[1]}"
  local hours="${TIME[0]}"

  local seconds=`echo "($minutes * 60) + ($hours * 60 * 60)" | bc`
  echo $seconds
}

function _jira.quote() {
  local text="$@"
  echo ${text//\"/\\\"}
}

function _jira.to_iso8601_date() {
  local datetime="$1"
  if [ -z "${datetime}" ]; then
    datetime="`date`"
  fi

  # datetime="`date -Is --date "$1"`"
  datetime="`date -u +"%Y-%m-%dT%H:%M:%SZ" --date "$datetime"`"
  echo "$datetime"
}
