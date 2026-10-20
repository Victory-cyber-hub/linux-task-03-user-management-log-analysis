# Command Explanations and Observations

Complete the observation section based on what happened in your own VM.

## What `grep` does
`grep` searches input text for lines matching a specified pattern. In this lab, `grep "ERROR" sys_events.log` displays lines containing `ERROR`, while `grep -E "root|user01" sys_events.log` uses extended regular expressions to match either `root` or `user01`.

## What `chown` does
`chown` changes the owner and optionally the group associated with a file or directory. In this lab, `sudo chown root:root confidential.txt` changes both the file owner and group to `root`.

## What `usermod` does
`usermod` modifies an existing Linux user account. The option `-aG sudo` adds the user to the `sudo` supplementary group while preserving existing supplementary group memberships.

## What I observed after changing ownership

Fill in using your actual terminal output:

- File mode shown by `ls -l` before/after `chown`:
- Owner/group shown after `sudo chown root:root confidential.txt`:
- Result of `cat confidential.txt` as `forensic01`:
- Result of attempting to append text as `forensic01`:
- Why did access change?

Expected concept: with permissions `600`, only the file owner has read/write access. After ownership changes to `root:root`, `forensic01` is no longer the owner and has no group/other permissions, so normal read/write attempts should be denied. `root` can still access the file with appropriate privileges. Report what your VM actually displayed.
