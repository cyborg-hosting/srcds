#!/bin/sh

set -o errexit
set -o nounset

if [ -f "${INSTALL_DIR}" ]; then
	>&2 echo "\"${INSTALL_DIR}\" is not directory"
	exit 1
elif [ ! -d "${INSTALL_DIR}" ]; then
	mkdir --parents "${INSTALL_DIR}" 
	chown "${PUID}:${PGID}" "${INSTALL_DIR}"
	chmod "u+rwx" "${INSTALL_DIR}"
fi

if ! gosu "user" test -r "${INSTALL_DIR}"; then
	>&2 echo user can not read from directory "\"${INSTALL_DIR}\""
	exit 1
elif ! gosu "user" test -w "${INSTALL_DIR}"; then
	>&2 echo user can not write to directory"\"${INSTALL_DIR}\""
	exit 1
elif ! gosu "user" test -x "${INSTALL_DIR}"; then
	>&2 echo user an not change directory into directory "\"${INSTALL_DIR}\""
	exit 1
fi

if [ ! -f "${STEAMCMD_SCRIPT}" ]; then
	{
		echo "@ShutdownOnFailedCommand 1";
		echo "@NoPromptForPassword 1";
		echo "force_install_dir ${INSTALL_DIR}";
		echo "login anonymous";
		echo "app_update ${STEAMCMD_APP_ID:?NO APP ID SPECIFIED}${STEAMCMD_APP_BETA:+ -beta ${STEAMCMD_APP_BETA}}";
		echo "quit";
	} > "${STEAMCMD_SCRIPT}"
fi
