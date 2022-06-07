#!/bin/bash

#    themis themis bash text bank's shell - themis
#    Copyright (C) 2022  lazypwny751
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.

. delphi "bashtextbank"

__init:btb:shell() {
    while [[ "${input}" != "exit" ]] ; do
        read -p "BashTextBank:[${bashtextbank_version}]> " input
        case "${input}" in
            [eE][xX][iI][tT])
                echo ""
                exit 0
            ;;
            *)
                echo ""
            ;;
        esac
    done
}

case "${1}" in
    --create-bank)
        shift
        btb:create:bank ${@} || return "$?"
    ;;
    --create-table)
        shift
        btb:create:table ${@} || return "$?"
    ;;
    --create-file)
        shift
        btb:create:file ${@} || return "$?"
    ;;
    --remove-table)
        shift
        btb:remove:table ${@} || return "$?"
    ;;
    --remove-file)
        shift
        btb:remove:file ${@} || return "$?"
    ;;
    --check-table)
        shift
        btb:check:table ${@} || return "$?"
    ;;
    --check-file)
        shift
        btb:check:file ${@} || return "$?"
    ;;
    --list-table)
        shift
        btb:list:table ${@} || return "$?"
    ;;
    --list-file)
        shift
        btb:list:file ${@} || return "$?"
    ;;
    --write-file)
        shift
        btb:btb:write:file ${@} || return "$?"
    ;;
    --print-file)
        shift
        btb:btb:print:file ${@} || return "$?"
    ;;
    --help|-h)
        echo -e "there are 13 flags for ${0##*/};
--create-bank:
\tCreate compressed banks in gzip format,
maximum one parameter can be entered, 
a gzip file with .btb extension is
given with the entered parameter name.

--create-table:
\t

--create-file:

--remove-table:

--remove-file:

--check-table:

--check-file:

--list-table:

--list-file:

--write-file:

--print-file:

--help:

*:
"
    ;;
    *)
        __init:btb:shell
    ;;
esac