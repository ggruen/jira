# JIRA REST API in Bash

## Getting Started

```sh
git clone https://github.com/cloudily/jira.git
cd jira
. bootstrap.sh
# Enter JIRA Username & Password when prompted.
```

**To get your username**: log into JIRA in a browser, click your
profile picture, and select Profile.  Your username is on the left side.
The API username is *not* the same username you use to log into the web site.

### Add to the end of your .bashrc or .bash_profile

```sh
[ -f /path/to/jira/bootstrap.sh ] && . /path/to/jira/bootstrap.sh
```


### Methods

* `jira.flush` Fresh start

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
