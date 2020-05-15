#!/usr/bin/env fish
# title        : FishCrypt
# author       : anirath
# created      : 2020.05.14
# modified     : 2020.05.14
# file         : `./encrypt.fish`
# usage        : COMMAND [-OPTIONS] [FILE]
# dependencies : `gpg`, `fish`
# description  : autoloaded by `fish` to create a command, `encrypt`, for quickly encrypting files with `gpg`.
# ============================================================================================================
function encrypt -d "Adds a command, 'encrypt', to 'fish' in order to quickly encrypt files with 'gpg'."
    # Handle Arguments
    argparse 'h/help' 'a/ascii-armor' 't/twofish' 'c/camellia' 'k/keys' -- $argv
end
