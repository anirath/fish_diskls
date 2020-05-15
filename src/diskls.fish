#!/usr/bin/env fish
# title        : List Disks Fish Commands
# author       : anirath
# created      : 2020.05.15
# modified     : 2020.05.15
# file         : `./diskls.fish`
# usage        : COMMAND [-OPTIONS] [-o/--output FILENAME]
# dependencies : `lsblk`, `fish`
# description  : autoloaded by `fish` to create a command, `diskls`, for listing block devices with formatted output.
# ===================================================================================================================
# Error Handling for List Disks Command
# =====================================
function dls_err -d "Handles errors for the 'diskls' command."
    set -l err_now $argv[1]
    set -l err_msg_3 "An invalid argument was provided with 'diskls'. Try again with a valid option, or none for defaults."
    set -l err_msg_4 "An error occurred while creating tmp files. Please try again, or contact the developer if issue persists."
    set -l err_msg "err_msg_$err_now"; set_color red; printf "Error!!! "; set_color -o; printf "[Code:"$err_now"] ";
    set_color -d printf ""$err_msg"\n" set_color normal;
    if test "$err_now" -eq 3
        set_color -d 999999 grey; printf "\nYour Command Input: "$user_ran"\n"; set_color normal
    end
    exit "$err_now"
end
# ===========================
# Autoloaded Command Function
# ===========================
function diskls -d "Autoloaded by `fish` to add the 'diskls' command to the shell."
    # ------------
    # Handle Input
    # ------------
    set -lx user_ran 'diskls'
    if test (count $argv) -gt 0
        set user_ran "diskls $argv"
    end
    # ---------------
    # Command Options
    # ---------------
    set -l options (fish_opt -s h -l help); set options $options (fish_opt -s a -l all); set options $options (fish_opt -s d -l disk)
    set options $options (fish_opt -s f -l filesystem); set options $options (fish_opt -s k -l kernel);
    set options $options (fish_opt -s p -l partition); set options $options (fish_opt -s u -l unique);
    set options $options (fish_opt -s o -l output --multiple-vals); argparse $options -- $argv
    if test (count $argv) -gt 0
        # If there are any arguments remaining after parsing options then fail with an error.
        dls_err 3
    end
    # -----------
    # Create Temp
    # -----------
    set -l tmp_file (mktemp /tmp/dls.XXXXXXXXX) or dls_err 4;
end
