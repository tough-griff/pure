function __parse_current_folder -d "Replace '$HOME' with '~', truncate directories"
  string replace $HOME '~' $PWD | string replace '(\.?[^\.\/])[^\/]*\/' '$1/'
end
