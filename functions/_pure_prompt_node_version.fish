function _pure_prompt_node_version
    set -l package_json (_pure_find_up package.json)
    if test -n "$package_json"
        set -l node_version (node --version)
        echo "$pure_color_green$pure_symbol_node$pure_color_normal $node_version"
    end
end
