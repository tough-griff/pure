function __find_up -d "Search for a file above any given directory"
  set -l search $argv[1]
  set -q $argv[2]; and set -l dir $PWD; or set -l dir (realpath $argv[2])

  while test $dir != '/'
    if test -e "$dir/$search"
      echo "$dir/$search"
      return 0
    end

    set -l dir (string replace -r '[^/]*/?$' '' $dir)
  end

  return 1
end
