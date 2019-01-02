# Pure
# by Rafael Rinaldi
# modified by Griffin Yourick
# https://github.com/tough-griff/pure
# MIT License

function fish_prompt
    # Save previous exit code
    set --local exit_code $status
    # Prepare line for prompt
    echo -e -n (_pure_prompt_beginning)
    # Print first line
    echo -e (_pure_prompt_first_line)
    # Print prompt
    echo -e -n (_pure_prompt $exit_code)
    # Reset colors and end prompt
    echo -e (_pure_prompt_ending)

    set _pure_fresh_session 0
end
