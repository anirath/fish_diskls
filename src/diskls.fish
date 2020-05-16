#!/usr/bin/env fish
# title        : List Disks Fish Commands
# author       : anirath
# created      : 2020.05.15
# modified     : 2020.05.15
# file         : `./diskls.fish`
# usage        : COMMAND [-OPTIONS] [-o FILENAME]
# dependencies : `lsblk`, `fish`
# description  : autoloaded by `fish` to create a command, `diskls`, for listing block devices with formatted output.
# ===================================================================================================================
# Error Handling for List Disks Command
# =====================================
function diskls_err -d "Handles errors for the 'diskls' command."
    set -l err_now $argv[1]
    set -l err_msg_3 "An invalid argument was provided with 'diskls'. Try again with a valid option, or none for defaults."
    set -l err_msg_4 "An error occurred while creating tmp files. Please try again, or contact the developer if issue persists."
    set -l err_msg_5 "Too many arguments were provided with `diskls`. Use `diskls -h` or `diskls --help` to view help."
    set -l err_msg "err_msg_$err_now"; set_color -o red; printf "Error!!! "; set_color brred; printf "[Code:"$err_now"] ";
    set_color red; printf ""$$err_msg"\n"; set_color normal;
    if test "$err_now" -eq 3; or test "$err_now" -eq 5
        set_color -d 999999 grey; printf "\nYour Command Input: "$user_ran"\n"; set_color normal
    end
    return "$err_now"
end
# ===========================
# Autoloaded Command Function
# ===========================
function diskls -d "Autoloaded by `fish` to add the 'diskls' command to the shell."
    # ------------------------
    # Handle Commandline Input
    # ------------------------
    # Initialize command execution by storing the commandline input for later use.
    set -lx user_ran 'diskls'
    if test -n "$argv[1]"
        set user_ran "diskls $argv"
    else
        # If no arguments were provided set the local variable `argv` with 'null' and export it.
        set -lx argv 'null'
    end
    # --------------------------------
    # Parse Arguments & Toggle Options
    # --------------------------------
    # If the `$argv` variable wasn't set to 'null' during intializing then parse arguments.
    if not test "$argv" = 'null'
        # Create an `$option` variable with value 'null'.
        set -l option 'null'
        # Parse arguments for the help option, toggle the option if enabled, and handle any errors.
        argparse -n=diskls -x h,a,d,f,k,p,u 'h/help' 'a/all' 'd/disk' 'f/filesystem' 'k/kernel' 'p/partition' 'u/unique' 'o=' -- $argv
        # Check for any invalid arguments after parsing for options toggles, and throw the corresponding error if needed.
        if test "$status" -eq 1
            diskls_err 5
        else if test (count "$argv") -gt 0
            diskls_err 3
        end

        if set -q _flag_h; or set -q _flag_help
        else if not set -q _flag_a; or not set -q _flag_all;
            set -l option 'all'
        else if not set -q _flag_d; or not set -q _flag_disk
            set -l option 'disk'
        else if not set -q _flag_f; or not set -q _flag_filesystem
            set -l option 'filesystem'
        else if not set -q _flag_k; or not set -q _flag_kernel
            set -l option 'kernel'
        else if not set -q _flag_d; or not set -q _flag_disk
            set -l option 'disk'
        else if not set -q _flag_d; or not set -q _flag_disk
            set -l option 'disk'
        end
        # Parse the remaining arguments for the output option.
        argparse -n=diskls_output  -- $argv
        if set -q _flag_o
            # If the output option was enabled export a variable with the filepath.
            set -lx diskls_output "$_flag_o"
            if test -d "$diskls_output"
                # If the provided filepath points to a directory then handle the error.
                diskls_err 1
            else if test -e "$diskls_output"
                # If the file already exists then handle the error.
                diskls_err 1
            else
                # Create the output file now, and handle an error if it occurs.
                touch "$diskls_output"; or diskls_err 1
            end
        end
    end
    # ---------------------
    # Output Temporary Data
    # ---------------------
    # Create the tmp file and assign a variable to point to it, or handle the error and return the status.
    set -l tmp_file (mktemp /tmp/dls.XXXXXXXXX) or dls_err 4; and return "$status"
end
