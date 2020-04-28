#!/bin/sh

parseQS() {
	local a="$QUERY_STRING"
	a="${a#*${1}=}"

	if [ "$a" = "$QUERY_STRING" ]; then
		echo -n ""
		return 0
	fi

	a="${a%%&*}"

	a="${a//+/ }"
	local url_encoded="${1//+/ }"
	#printf '%b' "${url_encoded//%/\\x}"
	echo -e "${a//%/\\x}"
}

cgi_errquit() {
	echo "code: $1"
	echo ''
	exit 0
}

cgi_content() {
	echo 'code: 0'
	[ -n "$1" ] && echo "content-type: $1"
	echo
}
