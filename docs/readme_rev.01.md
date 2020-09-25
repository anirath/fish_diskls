[\\]: # ============================================================================{METADATA}============================================================================
[\\]: # Title       : DiskLS Readme
[\\]: # Author      : Anirath
[\\]: # Created     : 2020.09.25
[\\]: # Revised     : 2020.09.25
[\\]: # Revision    : 01
[\\]: # Description : The primary readme document for the DiskLS project formatted with the Maarekhet Network's custom Markdown Spec (MNMD). A version formatted for use
[\\]: # ----------- : with GitHub exists in the project docs at `readme-github.md`. For project metadata open and view `metadata.md` in the project docs.
[\\]: # ============================================================================{DOCUMENT}============================================================================
# DiskLS (Fish Shell Command) #
*Autoloaded functions creating commands, for the [Fish Shell][1], to print a neatly formatted list of requested block device information.*

## About ##
Creates the command `diskls` for command-line use with the [Fish Shell][1]. The command can be used by itself, or with parameters passed as arguments to enable various
alternative functionality and/or options. By default, i.e. without any arguments, it will print a neatly formatted list of block devices (HDDs, SDDs, and External Media.)
including some pertinent information for each. The included details will likely be sufficient in most use cases, but if more specifics are required one can use the
relevant options.

Besides printing out a list to standard output, there are also options for displaying a help message, exporting the list to alternative formats, writing exported lists to
file, and displaying current version information. The built-in help message (run `diskls -h`, `diskls --help`, or `diskls help`) contains a section titled 'Usage' that
shows how to use the command and its parameters. Also, it has a section titled 'Options' with a detailed list of possible options and how to use them. For more help and
support please either visit the [Network Topic Webpage][2] or contact [Network Support][e1] with the email: `maarekhet-support@protonmail.ch`.

## Usage ##
Using [DiskLS][3] is fairly simple. From the command-line, with a [Fish Shell][1], enter the command according to the following guideline:
```cmd
diskls [-f] [--flag] [subcommand]
```

## Options & Functions ##
The following options/functions can be used by providing the proper short/long flag argument or subcommand depending on the case. Each of the options will contain an
ordered list with this information, a description of the option and how to use it, and examples where useful.

- **Help Message** --
    1. Short Flag  : `-h`
    2. Long Flag   : `--help`
    3. Subcommand  : `help`
    4. Description : This function can be called using all three types of arguments (short/long flags & subcommand), but it can only be used by itself without any other
                     functions or options. When called it prints a help message to standard output. The support contained is brief compared to the full documentation and
                     manpages, but should answer most simple questions regarding how to use `diskls` from the command-line.
    5. Examples    : `diskls --help`

- **Default List** --
    1. Short Flag  : *N/A*
    2. Long Flag   : *N/A*
    3. Subcommand  : *N/A*
    4. Description : To print the default list out just use the command without any arguments.
    5. Examples    : `diskls`

[\\]: # =(Web-Addresses:)=========================================================={REFERENCES}===========================================================================
[1]: https://fishshell.com
[2]: https://anirath.github.io/maarekhet/topics/fish/diskls.html
[3]: https://github.com/anirath/fish_diskls/
[\\]: # -(Email-Addresses:)-----------------------------------------------------------------------------------------------------------------------------------------------
[e1]: mailto:maarekhet-support@protonmail.ch
[\\]: # =============================================================================={TEMP}==============================================================================
[\\]: # - **OPT/FUNC** --
[\\]: #     1. Short Flag  :
[\\]: #     2. Long Flag   :
[\\]: #     3. Subcommand  :
[\\]: #     4. Description :
[\\]: #     5. Examples    :
