function _pure_prompt_git_branch
    set --local git_prefix git:
    set --local git_branch (_pure_parse_git_branch) # current git branch
    set --local git_branch_color "$pure_color_gray"

    echo "$git_branch_color$git_prefix$git_branch"
end
