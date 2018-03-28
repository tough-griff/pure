# Set title to current folder and shell name
function fish_title
  set -l current_folder (prompt_pwd)
  set -l command $argv[1]
  set -l title "$current_folder $pure_symbol_horizontal_bar"

  if test -z "$command"
    set title "$title $_"
  else
    set title "$title $command"
  end

  echo $title
end
