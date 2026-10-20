#!/bin/bash
# Prépare Flutter + SDK Android au démarrage d'une session Claude Code cloud.
set -euo pipefail
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi
PROJECT_DIR="$CLAUDE_PROJECT_DIR" bash "$CLAUDE_PROJECT_DIR/tools/setup_cloud.sh"
if [ -n "${CLAUDE_ENV_FILE:-}" ]; then
  {
    echo 'export ANDROID_HOME=/opt/android-sdk'
    echo 'export PATH="/opt/flutter/bin:/opt/android-sdk/cmdline-tools/latest/bin:/opt/android-sdk/platform-tools:$PATH"'
  } >> "$CLAUDE_ENV_FILE"
fi
