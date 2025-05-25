function scratch
    set scratch_dir (mktemp -d)
    echo "Spawning subshell in scratch directory:"
    echo "  $scratch_dir"
    pushd $scratch_dir
    fish
    popd
    echo "Removing scratch directory"
    rm -rf "$scratch_dir"
end
