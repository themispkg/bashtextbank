#!/bin/bash

#    Create encodeced data in bash and use it like sql - Bash Text Bank
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

# delphiver: 1

# Major(1).Minor(0).Patch(0) and the delphi version is 1.
export bashtextbank_version="1.0.0"

__env:tmpdir() {
    command -v mkdir &> /dev/null || return 1 
    command -v rm &> /dev/null || return 1
    case "${1}" in
        start)
            if [[ -n "${1}" ]] ; then
                export tmpdir="${PWD}/.tmp.${2##*/}"
                if [[ ! -d "${tmpdir}" ]] ; then
                    mkdir -p "${tmpdir}"
                fi
            fi
        ;;
        stop)
            if [[ -d "${tmpdir}" ]] ; then
                rm -rf "${tmpdir}"
                unset tmpdir
            fi
        ;;
        *)
            if [[ -d "${tmpdir}" ]] ; then
                rm -rf "${tmpdir}"
                unset tmpdir
            else
                if [[ -n "${1}" ]] ; then
                    export tmpdir="${PWD}/.tmp.${2##*/}"
                    mkdir -p "${tmpdir}"
                fi
            fi
        ;;
    esac
}

__env:bank() {
    command -v gzip &> /dev/null || return 1
    command -v file &> /dev/null || return 1
    command -v tar &> /dev/null || return 1
    command -v cp &> /dev/null || return 1
    case "${1}" in
        open)
            local bank="${2}"
            if file "${bank}" | grep -w "gzip compressed data" &> /dev/null; then
                export realpath="$(realpath "${bank}")"
                local gzipfile="${bank##*/}"
                __env:tmpdir start "${bank}"
                cp "${bank}" "${tmpdir}"
                (
                    cd "${tmpdir}"
                    tar -xf "${gzipfile}" &> /dev/null
                    rm -f "${gzipfile}"
                ) || return "$?"
            fi
        ;;
        close)
            if [[ -n "${realpath}" ]] && [[ -d "${tmpdir}" ]] ; then
                (
                    cd "${tmpdir}"
                    tar -czf "${realpath}" . &> /dev/null
                    __env:tmpdir close
                ) || return "$?"
            fi
        ;;
        *)
            if [[ -n "${realpath}" ]] && [[ -d "${tmpdir}" ]] ; then
                (
                    cd "${tmpdir}"
                    tar -czf "${realpath}" . &> /dev/null
                    __env:tmpdir close
                ) || return "$?"
            else
                local bank="${1}"
                if file "${bank}" | grep -w "gzip compressed data" ; then
                    export realpath="$(realpath "${bank}"})"
                    local gzipfile="${bank##*/}"
                    __env:tmpdir start "${bank}"
                    cp "${bank}" "${tmpdir}"
                    (
                        cd "${tmpdir}"
                        tar -xf "${gzipfile}" &> /dev/null
                        rm -f "${gzipfile}"
                    ) || return "$?"
                fi  
            fi
        ;;
    esac
}

btb:create:bank() {
    if [[ -n "${1}" ]] ; then
        __env:tmpdir start "${1}"
        if [[ -d "${1%/*}" ]] ; then
            local create_dir="$(realpath ${1%/*})"
        else
            local create_dir="${PWD}"
        fi

        (
            cd "${tmpdir}"
            tar -czf "${create_dir}/${1##*/}.btb" ./ &> /dev/null
        )
        __env:tmpdir stop
        return 0
    else
        return 1
    fi
}

btb:create:table() {
    local bank="" tables=()
    while [[ "${#}" -gt 0  ]] ; do
        case "${1}" in
            --bank|-b)
                shift
                local bank="${1}"
                shift
            ;;
            *)
                local tables+=("${1}")
                shift
            ;;
        esac
    done 
    if file "${bank}" | grep -w "gzip compressed data" &> /dev/null ; then
        __env:bank open "${bank}" || return "$?"
        (
            cd "${tmpdir}" 
            for i in ${tables[@]} ; do
                if [[ ! -d "${i}" ]] ; then
                    mkdir "${i}"
                fi
            done
        )
        __env:bank close
    else
        return 1
    fi
}

btb:create:file() {
    local bank="" tables=()
    while [[ "${#}" -gt 0 ]] ; do
        case "${1}" in
            --bank|-b)
                shift
                local bank="${1}"
                shift
            ;;
            --table|-t)
                shift
                local table="${1}"
                shift
                while [[ "${#}" -gt 0 ]] ; do
                    case "${1}" in
                        --bank|--table|-b|-t)
                            break
                        ;;
                        --file|-f)
                            shift
                            local files=""
                            while [[ "${#}" -gt 0 ]] ; do
                                case "${1}" in
                                    --bank|--table|-b|-t)
                                        break
                                    ;;
                                    *)
                                        local files+="${1}:" 
                                        shift
                                    ;;
                                esac
                            done
                        tables+=("${files[@]}@${table}")
                        ;;
                        *)
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

    if file "${bank}" | grep -w "gzip compressed data" &> /dev/null ; then
       __env:bank open "${bank}" || return "$?"
        (
            cd "${tmpdir}"
            for i in ${tables[@]} ; do
                read files table <<< "${i//@/ }"
                if [[ -d "${table}" ]] ; then
                    (
                        IFS=":"
                        cd "${table}"
                        for x in ${files} ; do
                            if [[ ! -f "${x}" ]] ; then
                                touch "${x}"
                            fi
                        done
                    )
                fi
            done
        )
        __env:bank close
    else
        return 1 
    fi
}

btb:remove:table() {
    local bank="" tables=()
    while [[ "${#}" -gt 0  ]] ; do
        case "${1}" in
            --bank|-b)
                shift
                local bank="${1}"
                shift
            ;;
            *)
                local tables+=("${1}")
                shift
            ;;
        esac
    done 
    if file "${bank}" | grep -w "gzip compressed data" &> /dev/null ; then
        __env:bank open "${bank}" || return "$?"
        (
            cd "${tmpdir}" 
            for i in ${tables[@]} ; do
                if [[ -d "${i}" ]] ; then
                    rm -rf "${i}"
                fi
            done
        )
        __env:bank close
    else
        return 1
    fi
}

btb:remove:file() {
    local bank="" tables=()
    while [[ "${#}" -gt 0 ]] ; do
        case "${1}" in
            --bank|-b)
                shift
                local bank="${1}"
                shift
            ;;
            --table|-t)
                shift
                local table="${1}"
                shift
                while [[ "${#}" -gt 0 ]] ; do
                    case "${1}" in
                        --bank|--table|-b|-t)
                            break
                        ;;
                        --file|-f)
                            shift
                            local files=""
                            while [[ "${#}" -gt 0 ]] ; do
                                case "${1}" in
                                    --bank|--table|-b|-t)
                                        break
                                    ;;
                                    *)
                                        local files+="${1}:" 
                                        shift
                                    ;;
                                esac
                            done
                        tables+=("${files[@]}@${table}")
                        ;;
                        *)
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

    if file "${bank}" | grep -w "gzip compressed data" &> /dev/null ; then
       __env:bank open "${bank}" || return "$?"
        (
            cd "${tmpdir}"
            for i in ${tables[@]} ; do
                read files table <<< "${i//@/ }"
                if [[ -d "${table}" ]] ; then
                    (
                        IFS=":"
                        cd "${table}"
                        for x in ${files} ; do
                            if [[ -f "${x}" ]] ; then
                                rm -f "${x}"
                            fi
                        done
                    )
                fi
            done
        )
        __env:bank close
    else
        return 1 
    fi
}

btb:check:table() {
    local bank="" tables=()
    while [[ "${#}" -gt 0  ]] ; do
        case "${1}" in
            --bank|-b)
                shift
                local bank="${1}"
                shift
            ;;
            *)
                local tables+=("${1}")
                shift
            ;;
        esac
    done

    if file "${bank}" | grep -w "gzip compressed data" &> /dev/null ; then
        __env:bank open "${bank}" || return "$?"
        (
            cd "${tmpdir}" 
            for i in ${tables[@]} ; do
                if [[ ! -d "${i}" ]] ; then
                    __env:bank close
                    return 2
                fi
            done
        ) || return "$?"
        __env:bank close
    else
        return 1
    fi
}

btb:check:file() {
    local bank="" tables=()
    while [[ "${#}" -gt 0 ]] ; do
        case "${1}" in
            --bank|-b)
                shift
                local bank="${1}"
                shift
            ;;
            --table|-t)
                shift
                local table="${1}"
                shift
                while [[ "${#}" -gt 0 ]] ; do
                    case "${1}" in
                        --bank|--table|-b|-t)
                            break
                        ;;
                        --file|-f)
                            shift
                            local files=""
                            while [[ "${#}" -gt 0 ]] ; do
                                case "${1}" in
                                    --bank|--table|-b|-t)
                                        break
                                    ;;
                                    *)
                                        local files+="${1}:" 
                                        shift
                                    ;;
                                esac
                            done
                        tables+=("${files[@]}@${table}")
                        ;;
                        *)
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

    if file "${bank}" | grep -w "gzip compressed data" &> /dev/null ; then
       __env:bank open "${bank}" || return "$?"
        (
            cd "${tmpdir}"
            for i in ${tables[@]} ; do
                read files table <<< "${i//@/ }"
                if [[ -d "${table}" ]] ; then
                    (
                        IFS=":"
                        cd "${table}"
                        for x in ${files} ; do
                            if [[ ! -f "${x}" ]] ; then
                                __env:bank close
                                return 2
                            fi
                        done
                    )
                fi
            done
        ) || return "$?"
        __env:bank close
    else
        return 1 
    fi

}

btb:list:table() {
    local bank=""
    case "${1}" in
        --bank|-b)
            shift
            local bank="${1}"
        ;;
    esac
    if file "${bank}" | grep -w "gzip compressed data" &> /dev/null ; then
        __env:bank "open" "${bank}" || return "$?"
        (
            cd "${tmpdir}"
            ls -d *
        )
        __env:tmpdir close
    fi
}

btb:list:file() {
    command -v ls &> /dev/null || return 1
    local bank="" tables=()
    while [[ "${#}" -gt 0 ]] ; do
        case "${1}" in
            --bank|-b)
                shift
                local bank="${1}"
                shift
            ;;
            *)
                local tables+=("${1}")
                shift
            ;;
        esac
    done
    if file "${bank}" | grep -w "gzip compressed data" &> /dev/null ; then
        __env:bank open "${bank}" || return "$?"
        (
            cd "${tmpdir}"
            for i in ${tables[@]} ; do
                if [[ -d "${i}" ]] ; then
                    (
                        cd "${i}"
                        ls -p
                    )
                fi
            done
        )
        __env:bank close
    fi
}

btb:write:file() {
    local bank="" table="" file="" data=""
    while [[ "${#}" -gt 0 ]] ; do
        case "${1}" in
            --bank|-b)
                shift
                local bank="${1}"
                shift 
            ;;
            --table)
                shift
                local table="${1}"
                shift
            ;;
            --file|-f)
                shift
                local file="${1}"
                shift
            ;;
            --data|-d)
                shift
                local data="${1}"
            ;;
            *)
                shift
            ;;
        esac
    done
    if file "${bank}" | grep -w "gzip compressed data" &> /dev/null ; then
        __env:bank open "${bank}" || return "$?"
        (
            cd "${tmpdir}"
            if [[ -d "${table}" ]] && [[ -n "${file}" ]] ; then
                cd "${table}"
                echo "${data}" > "${file}"
            else
                __env:bank close
                return 2
            fi
        ) || return "$?"
        __env:bank close
    fi
}

btb:print:file() {
    command -v cat &> /dev/null || return 1
    local bank="" table="" file=""
    while [[ "${#}" -gt 0 ]] ; do
        case "${1}" in
            --bank|-b)
                shift
                local bank="${1}"
                shift
            ;;
            --table|-t)
                shift
                local table="${1}"
                shift
            ;;
            --file|-f)
                shift
                local file="${1}"
                shift
            ;;
            *)
                shift
            ;;
        esac
    done
    if file "${bank}" | grep -w "gzip compressed data" &> /dev/null ; then
        __env:bank open "${bank}" || return "$?"
        (
            cd "${tmpdir}"
            if [[ -d "${table}" ]] ; then
                cd "${table}"
                if [[ -f "${file}" ]] ; then
                    cat "${file}"
                else
                    __env:bank close
                    return 2
                fi
            fi
        ) || return "$?"
        __env:bank close
    fi
}