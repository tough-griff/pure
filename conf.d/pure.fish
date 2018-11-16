# Pure
# by Rafael Rinaldi
# modified by Griffin Yourick
# https://github.com/tough-griff/pure-fish
# MIT License

# Whether or not we're in a fresh session
set -g __pure_fresh_session 1

# Deactivate the default virtualenv prompt so that we can add our own
set -gx VIRTUAL_ENV_DISABLE_PROMPT 1

# Symbols
__pure_set_default pure_symbol_horizontal_bar "—"
__pure_set_default pure_symbol_node "⬡"
__pure_set_default pure_symbol_prompt "❯"
__pure_set_default pure_symbol_vcs_dirty "*"
__pure_set_default pure_symbol_vcs_down_arrow "⇣"
__pure_set_default pure_symbol_vcs_up_arrow "⇡"

# Colors
__pure_set_default pure_color_normal (set_color normal)
__pure_set_default pure_color_red (set_color red)
__pure_set_default pure_color_yellow (set_color yellow)
__pure_set_default pure_color_green (set_color green)
__pure_set_default pure_color_cyan (set_color cyan)
__pure_set_default pure_color_blue (set_color blue)
__pure_set_default pure_color_magenta (set_color magenta)
__pure_set_default pure_color_gray (set_color brblack)

__pure_set_default pure_color_symbol $pure_color_magenta
__pure_set_default pure_username_color $pure_color_gray
__pure_set_default pure_host_color $pure_color_gray
__pure_set_default pure_root_color $pure_color_normal

# Determines whether the username and host are shown at the begining or end
# 0 - end of prompt, default
# 1 - start of prompt
# Any other value defaults to the default behaviour
__pure_set_default pure_user_host_location 1

# Show exit code of last command as a separate prompt character. As described here: https://github.com/sindresorhus/pure/wiki#show-exit-code-of-last-command-as-a-separate-prompt-character
# 0 - single prompt character, default
# 1 - separate prompt character
# Any other value defaults to the default behaviour
__pure_set_default pure_separate_prompt_on_error 0

# Max execution time of a process before its run time is shown when it exits
__pure_set_default pure_command_max_exec_time 5

function pre_prompt --on-event fish_prompt
  # Template
  set -l user_and_host ""
  set -l current_folder (prompt_pwd)
  set -l vcs_branch_name ""
  set -l vcs_dirty ""
  set -l vcs_arrows ""
  set -l command_duration ""
  set -l pre_prompt ""

  # Do not add a line break to a brand new session
  if test $__pure_fresh_session -eq 0
    set pre_prompt $pre_prompt "\n"
  end

  # Check if user is in an SSH session
  if [ "$SSH_CONNECTION" != "" ]
    set -l host (hostname -s)
    set -l user (whoami)

    if [ "$user" = "root" ]
      set user "$pure_root_color$user"
    else
      set user "$pure_username_color$user"
    end

    # Format user and host part of prompt
    set user_and_host "$user$pure_color_gray@$pure_host_color$host$pure_color_normal "
  end

  # Add user@host
  set pre_prompt $pre_prompt $user_and_host

  # Format current folder on prompt output
  set pre_prompt $pre_prompt "$pure_color_blue$current_folder$pure_color_normal "

  # Exit with code 1 if git is not available
  if not type -fq git
    return 1
  end

  # Check if is on a Git repository
  set -l is_git_repository (command git rev-parse --is-inside-work-tree ^/dev/null);
  or set -l hg_root (__find_up '.hg')

  if test -n "$is_git_repository"
    set vcs_branch_name git:(__parse_git_branch)

    # Check if there are files to commit
    set -l is_vcs_dirty (command git status --porcelain --ignore-submodules ^/dev/null)

    if test -n "$is_vcs_dirty"
      set vcs_dirty $pure_symbol_vcs_dirty
    end

    # Check if there is an upstream configured
    command git rev-parse --abbrev-ref '@{upstream}' >/dev/null ^&1; and set -l has_upstream
    if set -q has_upstream
      set -l git_status (string split ' ' (string replace -ar '\s+' ' ' (command git rev-list --left-right --count 'HEAD...@{upstream}')))
      set -l git_arrow_left $git_status[1]
      set -l git_arrow_right $git_status[2]

      # If arrow is not "0", it means it's dirty
      if test $git_arrow_left != 0
        set vcs_arrows " $pure_symbol_vcs_up_arrow"
      end

      if test $git_arrow_right != 0
        set vcs_arrows " $vcs_arrows$pure_symbol_vcs_down_arrow"
      end
    end

    # Format Git prompt output
    set pre_prompt $pre_prompt "$pure_color_gray$vcs_branch_name$vcs_dirty$pure_color_normal$pure_color_cyan$vcs_arrows$pure_color_normal "
  else if test -n "$hg_root"
    set vcs_branch_name hg:(cat "$hg_root/branch" ^/dev/null; or echo 'default')

    set pre_prompt $pre_prompt "$pure_color_gray$vcs_branch_name$pure_color_normal "
  end

  # If there's a package.json in any parent directories, show node version
  set -l package_json (__find_up 'package.json')
  if test -n "$package_json"
    set -l node_version (node --version)
    set pre_prompt $pre_prompt "$pure_color_green$pure_symbol_node$pure_color_normal $node_version "
  end

  # Prompt command execution duration
  if test -n "$CMD_DURATION"
    set command_duration (__format_time $CMD_DURATION $pure_command_max_exec_time)
  end

  set pre_prompt $pre_prompt "$pure_color_yellow$command_duration$pure_color_normal"

  echo -e -s $pre_prompt
end

function pure_uninstall --on-event pure_uninstall
  functions -e pre_prompt
end