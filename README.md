# jira
JIRA REST API in Bash

## Getting Started

```
# Clone the repo
cd jira
. bootstrap.sh
```

### Add to the end of your .bashrc or .bash_profile

[ -f /path/to/jira/bootstrap.sh ] && . /path/to/jira/bootstrap.sh

### Methods

* `jira.flush` Start over

#### Issue Worklog

* `jira.issue_worklog.list`
* `jira.issue_worklog.get`
* `jira.issue_worklog.create` - Example: jira.issue_worklog.create PSLP-115 1.5h "Writing code."
* `jira.issue_worklog.update`
* `jira.issue_worklog.delete`
