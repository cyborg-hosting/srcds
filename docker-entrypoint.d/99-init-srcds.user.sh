#!/bin/sh

if [ ! -r "${STEAMCMD_INSTALL_DIR}" ] || [ ! -w "${STEAMCMD_INSTALL_DIR}" ] || [ ! -x "${STEAMCMD_INSTALL_DIR}" ]; then
    >&2 echo "unprivileged user can not access to directory \"${STEAMCMD_INSTALL_DIR}\""
    exit 1
fi

