#!/bin/bash

export status="true" exist=() trigger=() 

alternatives() {
    local status="true"
    while [[ "${#}" -gt 0 ]] ; do
        case "${1}" in
            delphi)
                local project="https://github.com/themispkg/bash-utils"
                command -v "git" &> /dev/null || return 1
                command -v "make" &> /dev/null || return 1
                git clone "${project}" && cd "${project##*/}"
                sudo make install || local status="false"                        
                shift
            ;;
            *)
                echo -e "\t\talternatives do not support '${1}'."
                local status="false"
                shift
            ;;
        esac
    done

    if [[ "${status}" = "false" ]] ; then
        export status="false"
        return 1
    fi
}

check() {
    while [[ "${#}" -gt 0 ]] ; do
        case "${1}" in
            --exist|-e)
                shift
                while [[ "${#}" -gt 0 ]] ; do
                    case "${1}" in
                        --trigger|-t)
                            break
                        ;;
                        *)
                            export exist+=("${1}") 
                            shift
                        ;;
                    esac
                done
            ;;
            --trigger|-t)
                shift
                while [[ "${#}" -gt 0 ]] ; do
                    case "${1}" in
                        --exist|-e)
                            break
                        ;;
                        *)
                            export trigger+=("${1}") 
                            shift
                        ;;
                    esac
                done
            ;;
            *)
                shift
            ;;
        esac
    done

    if [[ -n "${exist}" ]] ; then
        for i in ${exist[@]} ; do
            if [[ ! -e "${i}" ]] ; then
                echo -e "\t'${i}' doesn't exist!"
                export status="false"
            fi
        done
    fi

    if [[ -n "${trigger}" ]] ; then
        for i in ${trigger[@]} ; do
            if ! command -v "${i}" &> /dev/null ; then
                echo -e "\t'${i}' not found, trying to get it with using alternatives.."
                alternatives "${i}" || export status="false"
            fi
        done
    fi

    if [[ "${status}" = "false" ]] ; then
        echo "Some requirements were not met."
        return 1
    fi
}

check -e "src/btbshell.sh" "lib/bashtextbank.sh" -t "make" "gzip" "tar" "mkdir" "rm" "cp" "file" "grep" "delphi"

if [[ "${status}" = "true" ]] ; then
    tabs 8
    t="$(printf '\t')"

    cat - > Makefile <<EOF
PREFIX	:= ""
BINDIR	:= \$(PREFIX)/usr/bin
LIBDIR	:= "/usr/local/lib/bash"

define setup
${t}install -m 755 ./src/btbshell.sh \${BINDIR}/btbshell
${t}install -m 755 ./lib/bashtextbank.sh \${LIBDIR}
endef

define remove
${t}rm -f \${LIBDIR}/bashtextbank.sh \${BINDIR}/btbshell
endef

install:
${t}\$(setup)

uninstall:
${t}\$(remove)

reinstall:
${t}\$(remove)
${t}\$(setup)
EOF
    echo "All good, now you can type 'sudo make install'"
else
    echo "Cannot create file 'Makefile' because requirements are not met."
    exit 1
fi