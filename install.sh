#!/usr/bin/env bash
# make-better · explore-reference 스킬을 설치한다.
#   bash install.sh              → ~/.claude/skills/ (모든 프로젝트에서 쓰기)
#   bash install.sh <저장소 경로>  → <저장소>/.claude/skills/ (그 저장소에서만, 팀과 공유)
# 다시 실행하면 새 것으로 덮어쓴다.
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${1:-}"

if [[ -z "$TARGET" ]]; then
  DEST="$HOME/.claude/skills"
else
  cd "$TARGET" || { echo "폴더가 없습니다: $TARGET" >&2; exit 1; }
  ROOT="$(git rev-parse --show-toplevel 2>/dev/null)" || { echo "git 저장소가 아닙니다: $TARGET" >&2; exit 1; }
  DEST="$ROOT/.claude/skills"
fi

for skill in make-better explore-reference; do
  mkdir -p "$DEST/$skill"
  cp "$HERE/files/$skill/SKILL.md" "$DEST/$skill/SKILL.md"
  echo "[install] 복사  $DEST/$skill/SKILL.md"
done

echo
echo "Claude Code 를 다시 열면 스킬 목록에 make-better · explore-reference 가 보인다."
