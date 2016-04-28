# jira
JIRA REST API in Bash

## Getting Started

```
# Clone the repo
cd jira
. bootstrap.sh
```

### Add to the end of your .bashrc or .bash_profile

`[ -f /path/to/jira/bootstrap.sh ] && . /path/to/jira/bootstrap.sh`

### Methods

* `jira.flush` Start over

#### Issue Worklog

* `jira.issue_worklog.list` List all worklogs for a ticket.
  * `jira.issue_worklog.list PSLP-001`
* `jira.issue_worklog.get` Get specific worklog from ticket.
  * `jira.issue_worklog.get PSLP-001 1000`
* `jira.issue_worklog.create`
  * `jira.issue_worklog.create PSLP-001 1.5h "Writing code."`
  * Prompt for time and comment:
  * `jira.issue_worklog.create PSLP-001`
* `jira.issue_worklog.update`
* `jira.issue_worklog.delete`
