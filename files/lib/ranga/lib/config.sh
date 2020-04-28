#!/bin/sh

ckbool() {
	case "$1" in
	0|1) return 0 ;;
	esac
	return 1
}

ckint() {
	case "$1" in
	''|*[!0-9]*) return 1 ;;
	esac
	return 0
}

ckstrlen() {
	logger -t nswa "ckstrlen('$1', $2): stub"
	return 0
}

ucimapper() {
	local action="$1"
	local key="$2"
	local value="$3"
	local type="$4"
	shift 4
	while [ -n "${1}" ]; do
		case "$1" in
		set-blank-reset)
			[ "$action" = 'set' -a "$value" = '' ] && action='reset'
			;;
		esac

		shift
	done

	case "$action" in
	get)
		uci get "$key" 2>/dev/null
		[ "$?" = '0' ] && return 0 || return 1
		;;
	set)
		case "$type" in
		int)
			ckint "$value" || return 1
			;;
		bool)
			ckbool "$value" || return 1
			;;
		esac
		uci set "${key}=${value}"
		[ "$?" = '0' ] && uci commit || return 1
		return 0
		;;
	reset)
		uci delete "${key}" 2>/dev/null
		uci commit
		return 0
		;;
	esac
}
