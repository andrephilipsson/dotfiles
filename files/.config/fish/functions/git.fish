# `git` wrapper:
#
#     - `git` with no arguments = `git status`; run `git help` to show what
#       vanilla `git` without arguments would normally show.
#     - `git root` = `cd` to repo root.
#     - `ROOT=$(git root)` = no args and stdout is not a tty; prints the root.
#     - `git root ARG...` = evals `ARG...` from the root (eg. `git root ls`).
#     - `git ARG...` = behaves just like normal `git` command.
#
function git --wraps git --description 'git wrapper with extra features'
    if test (count $argv) -eq 0
        command git status
    else if test "$argv[1]" = "root"
        set -l args $argv[2..-1]
        set -l root

        if test (command git rev-parse --is-inside-git-dir 2>/dev/null) = "true"
            if test (command git rev-parse --is-bare-repository) = "true"
                set root (command git rev-parse --absolute-git-dir)
            else
                # Note: This is a good-enough, rough heuristic, which ignores
                # the possibility that GIT_DIR might be outside of the worktree
                set root (command git rev-parse --git-dir)"//.."
            end
        else
            # Git 2.13.0 and above:
            set root (command git rev-parse --show-superproject-working-tree 2>/dev/null)
            if test -z "$root"
                set root (command git rev-parse --show-toplevel 2>/dev/null)
            end
        end

        if test -z "$root"
            set root $PWD
        end

        if test (count $args) -eq 0
            if isatty stdout
                cd $root
            else
                echo $root
            end
        else
            pushd $root
            eval $args
            popd
        end
    else
        command git $argv
    end
end
