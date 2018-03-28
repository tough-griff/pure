function __find_up -d "Search for a file above any given directory"
  set -l search $argv[1]
  set -q $argv[2]; and set -l path (realpath -s .); or set -l path (realpath -s $argv[2])

  while test $path != '/'
    test -e "$path/$search"; and return 0
    set path (realpath -s $path/..)
  end

  return 1
end
