#!/bin/sh

ckmac() {
	echo "$1" | grep -E '^([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}$' > /dev/null
	[ "$?" != "0" ] && return 1
	return 0
}

ckinet4() {
	echo "$1" | grep -E "^([0-9]{1,3}\.){3}[0-9]{1,3}$" > /dev/null
	[ "$?" != "0" ] && return 1
	return 0
}

ckinet4cidr() {
	ckinet4 "$1" && return 0
	logger -t nswa "ckinet4cidr('$1'): stub"
	return 0
}

ckiface() {
	case "$1" in
	''|*[!a-zA-Z0-9]*) return 1 ;;
	esac
	return 0
}
