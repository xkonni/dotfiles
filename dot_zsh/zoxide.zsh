if type -f zoxide &> /dev/null; then
  _zoxide_cache="${XDG_CACHE_HOME:-$HOME/.cache}/zoxide_init.zsh"
  if [[ ! -f "$_zoxide_cache" ]]; then
    zoxide init zsh >! "$_zoxide_cache" 2>/dev/null
  fi
  [[ -f "$_zoxide_cache" ]] && source "$_zoxide_cache"
  unset _zoxide_cache
fi
