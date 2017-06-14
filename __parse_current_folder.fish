function __parse_current_folder -d "Replace '$HOME' with '~', truncate directories"
  pwd | sed "s|$HOME|~|" | sed -E "s|(\.?[^\.])[^\/]*\/|\1\/|g"
end
