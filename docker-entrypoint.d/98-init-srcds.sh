#!/bin/sh

if [ -f "${STEAMCMD_INSTALL_DIR}" ]; then
    >&2 echo "\"${STEAMCMD_INSTALL_DIR}\" is not directory"
    exit 1
elif [ ! -d "${STEAMCMD_INSTALL_DIR}" ]; then
    mkdir -p "${STEAMCMD_INSTALL_DIR}" 
    chown "${PUID}:${PGID}" "${STEAMCMD_INSTALL_DIR}"
    chmod "u+rwx" "${STEAMCMD_INSTALL_DIR}"
fi

if [ ! -f "${STEAMCMD_SCRIPT}" ]; then
    {
        echo "@ShutdownOnFailedCommand 1";
        echo "@NoPromptForPassword 1";
        echo "force_install_dir ${STEAMCMD_INSTALL_DIR}";
        echo "login anonymous";
        echo "app_update ${STEAMCMD_APP_ID:?NO APP ID SPECIFIED}${STEAMCMD_APP_BETA:+ -beta ${STEAMCMD_APP_BETA}}";
        echo "quit";
    } > "${STEAMCMD_SCRIPT}"
fi
