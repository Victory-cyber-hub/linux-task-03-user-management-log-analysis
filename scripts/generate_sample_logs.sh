#!/usr/bin/env bash
# Creates mock practice logs only. Does not access real system logs.
set -euo pipefail

DEST="${1:-$HOME/logs/sys_events.log}"
mkdir -p "$(dirname "$DEST")"
cat > "$DEST" <<'EOF'
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
printf 'Created mock log file: %s\n' "$DEST"
wc -l "$DEST"
