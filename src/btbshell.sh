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
    while true ; do
        read -p "BashTextBank:[${bashtextbank_version}]> " input
        case "${input}" in
            [cC][rR][eE][aA][tT][eE]" "[bB][aA][nN][kK])
                while true ; do
                    read -p "BashTextBank/CreateBank:[${bashtextbank_version}]> " subinput
                    case "${subinput}" in
                        [eE][xX][iI][tT])
                            echo "See yea later (^-^)"
                            exit 0
                        ;;
                        *)
                            btb:create:bank ${subinput} && echo -e "\033[0;32mSuccess\033[0m." || echo -e "\033[0;31mFail\033[0m."
                        ;;
                    esac
                done 
            ;;
            [cC][rR][eE][aA][tT][eE]" "[tT][aA][bB][lL][eE])
                while true ; do
                    read -p "BashTextBank/CreateTable:[${bashtextbank_version}]:> " subinput
                    case "${subinput}" in
                        [bB][aA][cC][kK])
                            break
                        ;;
                        [eE][xX][iI][tT])
                            echo "See yea later (^-^)"
                            exit 0
                        ;;
                        *)
                            local args="${subinput//BANK/--bank}"
                            btb:create:table ${args} && echo -e "\033[0;32mSuccess\033[0m." || echo -e "\033[0;31mFail\033[0m."
                        ;;
                    esac                    
                done
            ;;
            [cC][rR][eE][aA][tT][eE]" "[fF][iI][lL][eE])
                while true ; do
                    read -p "BashTextBank/CreateFile:[${bashtextbank_version}]:> " subinput
                    case "${subinput}" in
                        [bB][aA][cC][kK])
                            break
                        ;;
                        [eE][xX][iI][tT])
                            echo "See yea later (^-^)"
                            exit 0
                        ;;
                        *)
                            local args="${subinput//BANK/--bank}"
                            local args="${args//TABLE/--table}"
                            local args="${args//FILE/--file}"
                            btb:create:file ${args}  && echo -e "\033[0;32mSuccess\033[0m." || echo -e "\033[0;31mFail\033[0m."
                        ;;
                    esac
                done
            ;;
            [rR][eE][mM][oO][vV][eE]" "[tT][aA][bB][lL][eE])
                  while true ; do
                    read -p "BashTextBank/RemoveTable:[${bashtextbank_version}]:> " subinput
                    case "${subinput}" in
                        [bB][aA][cC][kK])
                            break
                        ;;
                        [eE][xX][iI][tT])
                            echo "See yea later (^-^)"
                            exit 0
                        ;;
                        *)
                            local args="${subinput//BANK/--bank}"
                            btb:remove:table ${args} && echo -e "\033[0;32mSuccess\033[0m." || echo -e "\033[0;31mFail\033[0m."
                        ;;
                    esac                    
                done
            ;;
            [rR][eE][mM][oO][vV][eE]" "[fF][iI][lL][eE])
                while true ; do
                    read -p "BashTextBank/CreateFile:[${bashtextbank_version}]:> " subinput
                    case "${subinput}" in
                        [bB][aA][cC][kK])
                            break
                        ;;
                        [eE][xX][iI][tT])
                            echo "See yea later (^-^)"
                            exit 0
                        ;;
                        *)
                            local args="${subinput//BANK/--bank}"
                            local args="${args//TABLE/--table}"
                            local args="${args//FILE/--file}"
                            btb:remove:file ${args}  && echo -e "\033[0;32mSuccess\033[0m." || echo -e "\033[0;31mFail\033[0m."
                        ;;
                    esac
                done
            ;;
            [cC][hH][eE][cC][kK]" "[tT][aA][bB][lL][eE])
                  while true ; do
                    read -p "BashTextBank/CheckTable:[${bashtextbank_version}]:> " subinput
                    case "${subinput}" in
                        [bB][aA][cC][kK])
                            break
                        ;;
                        [eE][xX][iI][tT])
                            echo "See yea later (^-^)"
                            exit 0
                        ;;
                        *)
                            local args="${subinput//BANK/--bank}"
                            btb:check:table ${args} && echo -e "\033[0;32mSuccess\033[0m." || echo -e "\033[0;31mFail\033[0m."
                        ;;
                    esac                    
                done
            ;;
            [cC][hH][eE][cC][kK]" "[fF][iI][lL][eE])
                while true ; do
                    read -p "BashTextBank/CheckFile:[${bashtextbank_version}]:> " subinput
                    case "${subinput}" in
                        [bB][aA][cC][kK])
                            break
                        ;;
                        [eE][xX][iI][tT])
                            echo "See yea later (^-^)"
                            exit 0
                        ;;
                        *)
                            local args="${subinput//BANK/--bank}"
                            local args="${args//TABLE/--table}"
                            local args="${args//FILE/--file}"
                            btb:check:file ${args}  && echo -e "\033[0;32mSuccess\033[0m." || echo -e "\033[0;31mFail\033[0m."
                        ;;
                    esac
                done
            ;;
            [lL][iI][sS][tT]" "[tT][aA][bB][lL][eE])
                  while true ; do
                    read -p "BashTextBank/ListTable:[${bashtextbank_version}]:> " subinput
                    case "${subinput}" in
                        [bB][aA][cC][kK])
                            break
                        ;;
                        [eE][xX][iI][tT])
                            echo "See yea later (^-^)"
                            exit 0
                        ;;
                        *)
                            local args="${subinput//BANK/--bank}"
                            btb:list:table ${args} && echo -e "\033[0;32mSuccess\033[0m." || echo -e "\033[0;31mFail\033[0m."
                        ;;
                    esac                    
                done
            ;;
            [lL][iI][sS][tT]" "[fF][iI][lL][eE])
                while true ; do
                    read -p "BashTextBank/ListFile:[${bashtextbank_version}]:> " subinput
                    case "${subinput}" in
                        [bB][aA][cC][kK])
                            break
                        ;;
                        [eE][xX][iI][tT])
                            echo "See yea later (^-^)"
                            exit 0
                        ;;
                        *)
                            local args="${subinput//BANK/--bank}"
                            local args="${args//TABLE/--table}"
                            btb:list:file ${args}  && echo -e "\033[0;32mSuccess\033[0m." || echo -e "\033[0;31mFail\033[0m."
                        ;;
                    esac
                done
            ;;
            [wW][rR][iI][tT][eE]" "[fF][iI][lL][eE])
                while true ; do
                    read -p "BashTextBank/WriteFile:[${bashtextbank_version}]:> " subinput
                    case "${subinput}" in
                        [bB][aA][cC][kK])
                            break
                        ;;
                        [eE][xX][iI][tT])
                            echo "See yea later (^-^)"
                            exit 0
                        ;;
                        *)
                            local args="${subinput//BANK/--bank}"
                            local args="${args//TABLE/--table}"
                            local args="${args//FILE/--file}"
                            local args="${args//DATA/--data}"
                            btb:write:file ${args}  && echo -e "\033[0;32mSuccess\033[0m." || echo -e "\033[0;31mFail\033[0m."
                        ;;
                    esac
                done
            ;;
            [pP][rR][iI][nN][tT]" "[fF][iI][lL][eE])
                while true ; do
                    read -p "BashTextBank/PrintFile:[${bashtextbank_version}]:> " subinput
                    case "${subinput}" in
                        [bB][aA][cC][kK])
                            break
                        ;;
                        [eE][xX][iI][tT])
                            echo "See yea later (^-^)"
                            exit 0
                        ;;
                        *)
                            local args="${subinput//BANK/--bank}"
                            local args="${args//TABLE/--table}"
                            local args="${args//FILE/--file}"
                            btb:print:file ${args}  && echo -e "\033[0;32mSuccess\033[0m." || echo -e "\033[0;31mFail\033[0m."
                        ;;
                    esac
                done
            ;;
            [hH][eE][lL][pP])
                echo "There are 13 commands:

create bank: <str>
create table: BANK <str>.btb <str> <str>
create file: BANK <str>.btb TABLE <str> FILE <str>

remove table: BANK <str>.btb <str> <str> 
remove file: BANK <str>.btb TABLE <str> FILE <str>

check table: BANK <str>.btb <str> <str>
check file: BANK <str>.btb TABLE <str> FILE <str>

list table: BANK <str>.btb
list file: BANK <str>.btb TABLE <str>

write file: BANK <str>.btb TABLE <str> FILE <str> DATA <str>
print file: BANK <str>.btb TABLE <str> FILE <str>

exit - quit's directly.
back - turn main menu.
"
            ;;
            [eE][xX][iI][tT])
                echo "See yea later (^-^)"
                exit 0
            ;;
            *)
                echo -e "\tUnknown command, type 'help' for more options
\tbtbshell - bash text bank version: ${bashtextbank_version}"
            ;;
        esac
    done
}

case "${1}" in
    --create-bank)
        shift
        btb:create:bank ${@} || exit "$?"
    ;;
    --create-table)
        shift
        btb:create:table ${@} || exit "$?"
    ;;
    --create-file)
        shift
        btb:create:file ${@} || exit "$?"
    ;;
    --remove-table)
        shift
        btb:remove:table ${@} || exit "$?"
    ;;
    --remove-file)
        shift
        btb:remove:file ${@} || exit "$?"
    ;;
    --check-table)
        shift
        btb:check:table ${@} || exit "$?"
    ;;
    --check-file)
        shift
        btb:check:file ${@} || exit "$?"
    ;;
    --list-table)
        shift
        btb:list:table ${@} || exit "$?"
    ;;
    --list-file)
        shift
        btb:list:file ${@} || exit "$?"
    ;;
    --write-file)
        shift
        btb:write:file ${@} || exit "$?"
    ;;
    --print-file)
        shift
        btb:print:file ${@} || exit "$?"
    ;;
    --version|-v)
        echo "${bashtextbank_version}"
        exit 0
    ;;
    --help|-h)
        echo -e "there are 13 flags for ${0##*/};

--create-bank:
\tCreate compressed banks in gzip format,
maximum one parameter can be entered, 
a gzip file with .btb extension is
given with the entered parameter name.
\t\t${0##*/} --create-bank test
--create-table:
\tcreate tables inside the text bank.
\t\t${0##*/} --create-table --bank test.btb table1 table2
--create-file:
\tcreate files inside tables from text bank.
\t\t${0##*/} --create-file --bank test.btb --table table1 --file test1 test2 --table table2 --file foss

--remove-table:
\tdelete tables from text bank.
\t\t${0##*/} --remove-table --bank test.btb table1 table2
--remove-file:
\tremove files inside tables.
\t\t${0##*/} --remove-file --bank test.btb --table table1 --file test1 test2 --table table2 --file foss

--check-table:
\tcheck if exist tables form text bank.
\t\t${0##*/} --check-table --bank test.btb table1 table2
--check-file:
\tcheck if exist files inside of tables from text bank.
\t\t${0##*/} --check-file --bank test.btb --table table1 --file test1 test2 --table table2 --file foss

--list-table:
\tlist tables of a text bank.
\t\t${0##*/} --list-table --bank test.btb
--list-file:
\tlist files insade of tables in text bank.
\t\t${0##*/} --list-file --bank test.btb --table table1 table2 

--write-file:
\twrite string data in any file of any table.
\t\t${0##*/} --write-file --bank test.btb --table table1 --file test1 --data \"hello world\"
--print-file:
\tprint the data inside of file in table.
\t\t${0##*/} --print-file --bank test.btb --table table1 --file test1

--help:
\tShow's this screen.
\t\t${0##*/} --help

*:
\tOpens a shell for you to create and manage text banks.
\t\t${0##*/}
"
    ;;
    *)
        __init:btb:shell
    ;;
esac