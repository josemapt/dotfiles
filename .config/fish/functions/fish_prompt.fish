function fish_prompt
    set -l last_pipestatus $pipestatus
    set -l last_status $status
    set -l normal (set_color normal)

    set -l color_cwd blue
    set -l prefix
    set -l suffix ' >'

    # Write pipestatus
    set -l prompt_status (__fish_print_pipestatus " [" "]" "|" (set_color $fish_color_status) (set_color --bold $fish_color_status) $last_pipestatus)

    echo -n -s (set_color $color_cwd) (prompt_pwd) $normal (fish_vcs_prompt) $normal $prompt_status $suffix " "
end
