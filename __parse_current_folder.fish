function __parse_current_folder -d "Replace '$HOME' with '~', truncate directories"
  pwd | sed -E -e "s|$HOME|~|" -e "s|(\.?[^\.\/])[^\/]*\/|\1\/|g"
end
