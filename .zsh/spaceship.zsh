SPACESHIP_VI_MODE_SHOW=false
SPACESHIP_EXEC_TIME_SHOW=false
SPACESHIP_HOST_SHOW=false
SPACESHIP_USER_SHOW=false

SPACESHIP_CHAR_SYMBOL="\n > "
SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_DIR_PREFIX="\n"

SPACESHIP_GCLOUD_PREFIX=""
SPACESHIP_GCLOUD_SYMBOL=" "
SPACESHIP_GCLOUD_COLOR="51"
SPACESHIP_GCLOUD_SHOW=false

SPACESHIP_HG_SYMBOL="שׂ"

SPACESHIP_PROMPT_ORDER=(
  git           # Git section (git_branch + git_status)
  package       # Package version
  gradle        # Gradle section
  maven         # Maven section
  node          # Node.js section
  ruby          # Ruby section
  elixir        # Elixir section
  xcode         # Xcode section
  swift         # Swift section
  golang        # Go section
  php           # PHP section
  rust          # Rust section
  haskell       # Haskell Stack section
  julia         # Julia section
  docker        # Docker section
  aws           # Amazon Web Services section
  gcloud        # Google Cloud Platform section
  venv          # virtualenv section
  conda         # conda virtualenv section
  pyenv         # Pyenv section
  dotnet        # .NET section
  ember         # Ember.js section
  kubectl       # Kubectl context section
  terraform     # Terraform workspace section
  exec_time     # Execution time
  line_sep      # Line break
  battery       # Battery level and status
  user          # Username section
  dir           # Current directory section
  hg            # Mercurial section (hg_branch  + hg_status)
  host          # Hostname section
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
  time          # Time stamps section
)
