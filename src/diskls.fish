#!/usr/bin/env fish
# title        : List Disks Fish Commands
# author       : anirath
# created      : 2020.05.15
# modified     : 2020.05.20
# file         : `./diskls.fish`
# usage        : COMMAND [-OPTIONS] [-o FILENAME]
# dependencies : `lsblk`, `fish`
# description  : autoloaded by `fish` to create a command, `diskls`, for listing block devices with formatted output.
# ===================================================================================================================
# Error Handling for List Disks Command
# =====================================
function diskls_err -d "Handles errors for the 'diskls' command."
    # Collect the current error into a variable, and set all of the error messages.
    set -l err_now $argv[1]
    set -l err_msg_3 "Invalid arguments! The command was executed with invalid arguments. Run with '-h' to view a help page."
    set -l err_msg_4 "An error occurred writing temporary files. Please try again, or contact the developer if issue persists."
    set -l err_msg_5 "Unable to write file to disk. Please double check your output target, and try again."
    # Display the message for the current error.
    set -l err_msg "err_msg_$err_now"; set_color -o red; printf "Error!!! "; set_color brred; printf "[Code:"$err_now"] ";
    set_color red; printf ""$$err_msg"\n"; set_color normal;
    if test "$err_now" -eq 3
        # If the error is a code 3 show the user their input.
        set_color -d 999999 grey; printf "Your Command Input: "$user_ran"\n"; set_color normal
    end
    # Return the function with the corresponding error code.
    return "$err_now"
end
# ================================
# Help Page for List Disks Command
# ================================
function diskls_help -d "Prints a help message for the 'diskls' command."
    echo "Help me!"; and return 0
end
# ==========================================
# Autoloaded Function for List Disks Command
# ==========================================
function diskls -d "Autoloaded by 'fish' to create the disk list command 'diskls'."
    # --------------------------------
    # Parse Arguments & Toggle Options
    # --------------------------------
    # Export variables for the commandline input, and the available options.
    set -lx user_ran "diskls $argv"; set -lx option ''; set -lx output_target ''; set -lx diskls_columns '';
    set -lx options 'h/help' 'a/all' 'd/disk' 'f/filesystem' 'k/kernel' 'u/unique' 'o='
    # Check for any arguments.
    if set -q argv[1]
        # Parse the arguments to toggle option flags.
        argparse -x h,a,d,f,k,u -x h,o $options -- $argv
        if test "$status" -gt 0; or set -q argv[1]; diskls_err 3; return $status; end
        # Check the `argparse` output and set the toggled option.
        if set -q _flag_h
            #If the help option was enabled just run diskls_help() and return 0.
            diskls_help; and return 0
        else if set -q _flag_a
            set option 'all'
        else if set -q _flag_d
            set option 'disk'
        else if set -q _flag_f
            set option 'filesystem'
        else if set -q _flag_k
            set option 'kernel'
        else if set -q _flag_u
            set option 'unique'
        else
            set option 'default'
        end
        # Set the $output_target if provided with the option.
        if set -q _flag_o
            set output_target "$_flag_o"
        else
            set output_target 'null'
        end
    else
        # If there are no arguments then set the option to default, and a null target.
        set option 'default'; set output_target 'null'
    end
    # ----------------------
    # Validate Output Target
    # ----------------------
    if test "$output_target" != 'null'
        # If the output to file option was enabled then verify the ability to write.
        if test -f "$output_target"; and test -w "$output_target"
            # Prompt the user to confirm if they want to overwrite an existing file at that location.
            printf "Target: $output_target \n"
            printf "The output target you provided is already an existing file. Would you like to overwrite it? [Y/n]\n"
        else if test -f "$output_target"
            # Let the user know the target is not writable, and return from the command.
            printf "Unfortunately the output target you provided points to an existing file that isn't writable. Please try again\n"
            printf "with a valid target.\n"
            return
        end
        # Create the output target file or process an error.
        touch "$output_target"
            or diskls_err 5 and return $status
    end
    # --------------
    # Handle Options
    # --------------
    switch "$option"
        case 'default'
            set diskls_columns 'NAME,TYPE,PTTYPE,MOUNTPOINT,PATH,PARTLABEL,FSTYPE,FSUSE%,SIZE,FSUSED'
        case 'disk'
            set diskls_columns 'NAME,TYPE,MOUNTPOINT,PATH,MAJ:MIN,MODEL,SUBSYSTEMS,PHY-SEC,VENDOR,HOTPLUG'
        case 'filesystem'
            set diskls_columns 'NAME,TYPE,LABEL,MOUNTPOINT,PATH,FSTYPE,FSUSE%,FSSIZE,FSAVAIL,FSUSED'
        case 'kernel'
            set diskls_columns 'NAME,KNAME,TYPE,MOUNTPOINT,PATH,SUBSYSTEMS,STATE,RQ-SIZE'
        case 'unique'
            set diskls_columns 'NAME,PATH,MODEL,SERIAL,UUID,WWN'
        case '*'
            return 1
    end
    # ------------
    # Print Output
    # ------------
    if test "$output_target" != 'null'
        # If the output target is set then write to it.
        lsblk -e7,252 -o "$diskls_columns" >> "$output_target"
    end
    # Print the output to the terminal.
    lsblk -e7,252 -o "$diskls_columns"
end
