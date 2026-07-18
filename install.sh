#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
TS="$(date +%Y%m%d-%H%M%S)"
DRY_RUN=0

run() {
  if [ "$DRY_RUN" -eq 1 ]; then
    printf '+ '
    printf '%q ' "$@"
    printf '\n'
  else
    "$@"
  fi
}

backup_if_exists() {
  local path="$1"
  if [ -e "$path" ] || [ -L "$path" ]; then
    run mv "$path" "${path}.bak.${TS}"
    if [ "$DRY_RUN" -eq 1 ]; then
      echo "would back up: $path -> ${path}.bak.${TS}"
    else
      echo "backup: $path -> ${path}.bak.${TS}"
    fi
  fi
}

ensure_dir() {
  run mkdir -p "$1"
}

link_dir() {
  local target="$1"
  local linkname="$2"

  # linkname の親は必要
  ensure_dir "$(dirname "$linkname")"

  # もし linkname が「実体ディレクトリ」なら退避（ln が中に作ってしまう事故を防ぐ）
  if [ -d "$linkname" ] && [ ! -L "$linkname" ]; then
    backup_if_exists "$linkname"
  fi

  # もし誤って linkname の中に同名リンクが作られていたら消す（今回の事故対策）
  # 例: ~/.config/wezterm/wezterm -> ...
  if [ -L "${linkname}/$(basename "$linkname")" ]; then
    run rm "${linkname}/$(basename "$linkname")"
  fi

  run ln -sfn "$target" "$linkname"
  if [ "$DRY_RUN" -eq 1 ]; then
    echo "would link directory: $linkname -> $target"
  else
    echo "linked(dir): $linkname -> $target"
  fi
}

link_file() {
  local target="$1"
  local linkname="$2"

  ensure_dir "$(dirname "$linkname")"

  # 既存が「リンクでない」場合だけ退避（上書き事故防止）
  if [ -e "$linkname" ] && [ ! -L "$linkname" ]; then
    backup_if_exists "$linkname"
  fi

  run ln -sfn "$target" "$linkname"
  if [ "$DRY_RUN" -eq 1 ]; then
    echo "would link file: $linkname -> $target"
  else
    echo "linked(file): $linkname -> $target"
  fi
}

usage() {
  echo "Usage: $0 [--dry-run]"
}

main() {
  case "${1:-}" in
    "") ;;
    --dry-run) DRY_RUN=1 ;;
    -h|--help) usage; exit 0 ;;
    *) usage; exit 1 ;;
  esac

  # 事前チェック（実体が存在するか）
  if [ ! -e "$DOTFILES_DIR/config/wezterm" ]; then
    echo "ERROR: missing $DOTFILES_DIR/config/wezterm"
    exit 1
  fi
  if [ ! -e "$DOTFILES_DIR/config/aerospace/aerospace.toml" ]; then
    echo "ERROR: missing $DOTFILES_DIR/config/aerospace/aerospace.toml"
    exit 1
  fi
  if [ ! -e "$DOTFILES_DIR/config/zsh/.zshrc" ] || [ ! -e "$DOTFILES_DIR/config/zsh/.zprofile" ]; then
    echo "ERROR: missing zsh configuration under $DOTFILES_DIR/config/zsh"
    exit 1
  fi

  # WezTerm: ディレクトリ単位
  link_dir "$DOTFILES_DIR/config/wezterm" "$HOME/.config/wezterm"

  # AeroSpace: ファイル単位
  link_file "$DOTFILES_DIR/config/aerospace/aerospace.toml" "$HOME/.config/aerospace/aerospace.toml"

  link_file "$DOTFILES_DIR/config/zsh/.zshrc" "$HOME/.zshrc"
  link_file "$DOTFILES_DIR/config/zsh/.zprofile" "$HOME/.zprofile"

  if [ "$DRY_RUN" -eq 1 ]; then
    echo "Dry run complete."
  else
    echo "Done."
  fi
}

main "$@"
