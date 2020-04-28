#!/bin/sh

auth() {
	[ -z "$GATEWAY_INTERFACE" ] && return 0

	local token=""
	local token2=""

	token="${HTTP_COOKIE}"
	token="${token#*USER_TOKEN=}"
	token="${token%% *}"

	if [ -n "${token}" ] && [ "${token}" = "`cat /tmp/ranga_utoken 2>/dev/null`" ]; then
		return 0
	fi

	if [ "${HTTP_COOKIE:0:5}" = "RETM=" ]; then
		token="${HTTP_COOKIE#RETM=}"
		if [ "${token}" = "`cat /tmp/ranga_etoken 2>/dev/null`" ]; then
			return 0
		fi
	fi

	return 1
}

auth_dial() {
	perm=`uci get nswa.flags.permit_anonymous_dial`
	[ "${perm}" = '1' ] && return 0
	
	auth
	return $?
}
