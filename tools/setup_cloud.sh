#!/bin/bash
# Installe Flutter et le SDK Android dans un conteneur Linux (session Claude Code cloud).
# Idempotent : ne retélécharge rien de déjà présent.
set -euo pipefail

FLUTTER_VERSION="3.47.7"
FLUTTER_SHA256="af7455f540df951184c7953fbe3cf884766e7541dacf8571f9f582db03dd6230"
FLUTTER_DIR="/opt/flutter"
ANDROID_HOME="${ANDROID_HOME:-/opt/android-sdk}"
CMDLINE_TOOLS_ZIP="commandlinetools-linux-16111833_latest.zip"
ANDROID_PACKAGES=(
  "platform-tools"
  "platforms;android-36"
  "platforms;android-35"
  "build-tools;36.0.0"
  "ndk;28.2.13676358"
  "cmake;3.22.1"
)

log() { echo "[setup] $*" >&2; }

# 1. Flutter (archive officielle Google, empreinte vérifiée)
if [ ! -x "$FLUTTER_DIR/bin/flutter" ]; then
  log "Installation de Flutter $FLUTTER_VERSION"
  tmp="$(mktemp -d)"
  archive="flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"
  curl -sSfL -o "$tmp/$archive" \
    "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/$archive"
  echo "$FLUTTER_SHA256  $tmp/$archive" | sha256sum -c - >&2
  tar -xf "$tmp/$archive" -C "$(dirname "$FLUTTER_DIR")"
  rm -rf "$tmp"
fi
git config --global --get-all safe.directory | grep -qx "$FLUTTER_DIR" \
  || git config --global --add safe.directory "$FLUTTER_DIR"

# 2. Outils en ligne de commande Android
if [ ! -x "$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager" ]; then
  log "Installation des outils Android"
  tmp="$(mktemp -d)"
  curl -sSfL -o "$tmp/ct.zip" "https://dl.google.com/android/repository/$CMDLINE_TOOLS_ZIP"
  unzip -q "$tmp/ct.zip" -d "$tmp"
  mkdir -p "$ANDROID_HOME/cmdline-tools"
  mv "$tmp/cmdline-tools" "$ANDROID_HOME/cmdline-tools/latest"
  rm -rf "$tmp"
fi

# 3. Paquets du SDK Android
missing=()
for p in "${ANDROID_PACKAGES[@]}"; do
  [ -d "$ANDROID_HOME/${p//;//}" ] || missing+=("$p")
done
if [ "${#missing[@]}" -gt 0 ]; then
  log "Installation des paquets Android : ${missing[*]}"
  yes | "$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager" "${missing[@]}" >/dev/null 2>&1 || true
  for p in "${missing[@]}"; do
    [ -d "$ANDROID_HOME/${p//;//}" ] || { log "ÉCHEC : $p"; exit 1; }
  done
fi

# 4. Gradle : un seul téléchargement à la fois (Maven Central renvoie 429 sinon)
mkdir -p "$HOME/.gradle"
grep -q '^org.gradle.workers.max=' "$HOME/.gradle/gradle.properties" 2>/dev/null || cat >> "$HOME/.gradle/gradle.properties" <<'P'
org.gradle.workers.max=1
org.gradle.parallel=false
org.gradle.internal.repository.max.retries=8
org.gradle.internal.repository.initial.backoff=2000
P

export PATH="$FLUTTER_DIR/bin:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH"
export ANDROID_HOME
flutter --disable-analytics >/dev/null 2>&1 || true
flutter config --android-sdk "$ANDROID_HOME" >/dev/null 2>&1 || true

# 5. Dépendances Dart du projet
if [ -n "${PROJECT_DIR:-}" ] && [ -f "$PROJECT_DIR/pubspec.yaml" ]; then
  (cd "$PROJECT_DIR" && flutter pub get >/dev/null)
fi

log "Prêt : $(flutter --version 2>/dev/null | head -1)"
