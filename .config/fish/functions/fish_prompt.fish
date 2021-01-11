function fish_prompt

    set -l last_status $status

    # If current dir is not writable display it in red
    if not [ -w (pwd) ]
        set_color red
    else
        set_color green
    end

    printf '%s' (prompt_pwd)

    set_color normal
    printf '%s' (__fish_git_prompt)

    if not test $last_status -eq 0
        set_color $fish_color_error
    end

    printf '  '
    set_color normal

end