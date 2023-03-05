#!/usr/bin/env bash
marco(){
    current_dir=$(pwd)
    echo "Current working directory '$current_dir' saved in current_dir variable. Use polo to get back here."
    export current_dir
}

marco

polo(){
    echo "returning to '$current_dir'"
    cd "$current_dir"
}
