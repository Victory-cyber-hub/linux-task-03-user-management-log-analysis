# Linux Task 03 — User Management, Log Analysis & File Permissions

A beginner-friendly, step-by-step workflow for completing **Linux Task 03** and documenting the results in a GitHub portfolio.

> **Safety note:** Run the Linux commands in your assigned lab VM, not in Git Bash on Windows. Git Bash is used at the end to upload your completed project to GitHub. User-management commands require `sudo` and may change accounts on the VM.

## Objectives

- Create and manage Linux users.
- Generate and filter mock system-event logs with `cat`, `echo`, `grep`, `less`, `head`, and `tail`.
- Redirect filtered output to a report.
- Apply file permissions with `chmod` and change ownership with `chown`.
- Explain the results and capture terminal screenshots.

## Repository structure

```text
linux-task-03/
├── README.md
├── commands_used.txt
├── explanations.md
├── .gitignore
├── logs/
│   └── sys_events.log
├── reports/
│   └── .gitkeep
├── evidence/
│   ├── README.md
│   └── screenshots/
│       └── .gitkeep
└── scripts/
    └── generate_sample_logs.sh
```

`logs/sys_events.log` is a mock sample to show the expected format. In your lab, create the required file at `/home/forensic01/logs/sys_events.log`. Replace or supplement the repository sample with your own lab output only if your instructor permits it. Do not present sample data as real system logs.

## Part 1 — Create a user and prepare logs

Run these in a Linux terminal using an account authorized to use `sudo`.

### 1. Create `forensic01`

```bash
sudo useradd -m -s /bin/bash forensic01
sudo usermod -aG sudo forensic01
sudo passwd forensic01
```

- `-m` creates the home directory.
- `-s /bin/bash` sets the login shell.
- `-aG sudo` appends the user to the `sudo` group.
- Set a password when prompted.

**Distribution note:** The task specifically asks for the `sudo` group. On some distributions, the administrative group is `wheel` instead. Follow your instructor's VM setup and do not substitute groups without checking.

Verify:

```bash
id forensic01
getent passwd forensic01
ls -ld /home/forensic01
```

### 2. Log in as `forensic01`

```bash
su - forensic01
```

Enter the password you just set. Then create the required directory:

```bash
mkdir -p /home/forensic01/logs
cd /home/forensic01/logs
```

### 3. Create at least 20 mock log lines

Use the provided script from the repository if you have copied the repository into the Linux VM, or create the file manually with the following commands. The script writes mock data only; it does not read actual system logs.

```bash
cat > /home/forensic01/logs/sys_events.log <<'EOF'
2026-10-20 08:00:01 INFO user01 logged in
2026-10-20 08:02:14 INFO root started scheduled maintenance
2026-10-20 08:05:32 WARNING user01 entered an incorrect password
2026-10-20 08:06:10 ERROR authentication service returned failure
2026-10-20 08:10:44 INFO user01 opened the dashboard
2026-10-20 08:12:03 WARNING disk usage reached 75 percent
2026-10-20 08:15:28 ERROR failed login attempt for root
2026-10-20 08:18:52 INFO backup job started by root
2026-10-20 08:20:17 INFO user01 viewed report
2026-10-20 08:22:09 WARNING network latency detected
2026-10-20 08:25:41 ERROR backup job failed
2026-10-20 08:27:33 INFO root reviewed service status
2026-10-20 08:30:05 INFO user01 signed out
2026-10-20 08:32:16 WARNING repeated login failures detected
2026-10-20 08:35:49 ERROR permission check failed for user01
2026-10-20 08:38:22 INFO root updated a test configuration
2026-10-20 08:40:11 INFO service health check passed
2026-10-20 08:42:37 WARNING temporary storage is nearly full
2026-10-20 08:45:02 ERROR test process exited unexpectedly
2026-10-20 08:48:56 INFO user01 completed a practice task
2026-10-20 08:50:18 INFO root closed the maintenance session
2026-10-20 08:53:44 WARNING test alert requires review
EOF
```

Confirm the line count and file:

```bash
wc -l /home/forensic01/logs/sys_events.log
ls -l /home/forensic01/logs/sys_events.log
```

Expected: at least 20 lines.

## Part 2 — Filter and inspect logs

From the log directory:

```bash
cd /home/forensic01/logs
grep "ERROR" sys_events.log
grep -E "root|user01" sys_events.log
```

View results one screen at a time:

```bash
grep "ERROR" sys_events.log | less
grep -E "root|user01" sys_events.log | less
```

Press `q` to exit `less`.

Save the ERROR results to a report:

```bash
grep "ERROR" sys_events.log > error_report.txt
cat error_report.txt
```

The report is created in the current directory. If you want a separate reports directory in your home folder, use:

```bash
mkdir -p /home/forensic01/logs/reports
grep "ERROR" sys_events.log > /home/forensic01/logs/reports/error_report.txt
```

Inspect the beginning and end of the log:

```bash
head -n 5 sys_events.log
tail -n 5 sys_events.log
cat sys_events.log
```

## Part 3 — Permissions and ownership

Create the confidential file and set owner-only read/write access:

```bash
cd /home/forensic01/logs
touch confidential.txt
chmod 600 confidential.txt
printf 'Practice confidential note for the permissions exercise.\n' > confidential.txt
ls -l confidential.txt
```

`600` means the owner can read and write; group and others have no permissions. **Because you are logged in as `forensic01`, write the sample content before changing ownership.**

Now change ownership to root:

```bash
sudo chown root:root confidential.txt
ls -l confidential.txt
```

Observe access as `forensic01`:

```bash
cat confidential.txt
echo "test edit" >> confidential.txt
```

With mode `600` and ownership `root:root`, the unprivileged `forensic01` account should receive a permission-denied error for both operations. Record the actual output in your notes. An administrator can inspect it with:

```bash
sudo cat /home/forensic01/logs/confidential.txt
```

Do not use `sudo` for the two test commands intended to demonstrate the access restriction.

## Part 4 — Temporary user management

Run these commands from an account with administrative privileges:

```bash
sudo useradd -m -s /bin/bash guest1
sudo useradd -m -s /bin/bash guest2
sudo usermod -aG sudo guest1
id guest1
getent passwd guest2
```

The task asks to remove `guest2`, including its home directory:

```bash
sudo userdel -r guest2
```

Verify that the account entry is gone:

```bash
getent passwd guest2
```

No output is expected if the user was successfully removed. Do not delete `forensic01`; it is the main account for this exercise.

## Submission checklist

- [ ] `forensic01` created with home directory and `/bin/bash`.
- [ ] `forensic01` added to the `sudo` group and password set.
- [ ] `/home/forensic01/logs/sys_events.log` contains 20+ mock lines.
- [ ] ERROR and `root|user01` grep commands demonstrated.
- [ ] `less`, redirection, `head`, `tail`, and `cat` demonstrated.
- [ ] `confidential.txt` set to mode `600`, then changed to `root:root`.
- [ ] Access attempt as `forensic01` documented.
- [ ] `guest1` and `guest2` created; `guest1` added to sudo; `guest2` removed.
- [ ] `commands_used.txt` updated with the commands actually run.
- [ ] Screenshots saved under `evidence/screenshots/`.
- [ ] `explanations.md` completed.
- [ ] No passwords, private keys, or real sensitive logs committed.

## Suggested screenshot sequence

See [`evidence/README.md`](evidence/README.md) for the screenshot checklist. Use your own terminal output; placeholder files are not evidence.

## Push this repository to GitHub using Git Bash

1. Create an **empty** repository on GitHub, for example `linux-task-03-user-log-permissions`. Do not initialize it with a README if you plan to push this local README.
2. Extract this ZIP on Windows.
3. Open Git Bash in the extracted `linux-task-03-github-workflow` folder.
4. Run:

```bash
git init
git add .
git status
git commit -m "Add Linux Task 03 lab workflow and evidence structure"
git branch -M main
git remote add origin https://github.com/YOUR-GITHUB-USERNAME/linux-task-03-user-log-permissions.git
git push -u origin main
```

Replace `YOUR-GITHUB-USERNAME` with your GitHub username and update the repository name if you chose a different one. If Git says `remote origin already exists`, run `git remote -v` to inspect it, then use `git remote set-url origin https://github.com/YOUR-GITHUB-USERNAME/REPOSITORY-NAME.git`.

After you capture screenshots and edit the documentation, upload the additions:

```bash
git add .
git status
git commit -m "Add Linux Task 03 screenshots and results"
git push
```

Git Bash is for Git operations. Run the Linux exercise commands inside your Linux VM.
