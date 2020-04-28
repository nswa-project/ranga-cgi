#!/bin/sh

mwan_is_enabled() {
	[ -f /etc/rc.d/S19mwan3 ]
}
