#!/bin/sh

"${STEAMCMD_DIR}/steamcmd.sh" +runscript "${STEAMCMD_SCRIPT}"

cd "${INSTALL_DIR}"

EXECUTABLE="${INSTALL_DIR}/${SRCDS_RUN}"

if [ "${USE_DOTENV:-0}" -ne "0" ] && [ -f "${INSTALL_DIR}/.env" ]; then
    eval "$(shdotenv --overload --grep "^SRCDS" --env "${INSTALL_DIR}/.env")"
fi

if [ "${SRCDS_SECURED:-1}" -ne "0" ]; then
    SRCDS_SECURITY_FLAG="-secure"
else
    SRCDS_SECURITY_FLAG="-insecure"
fi

exec "${EXECUTABLE}" \
    -console \
    -autoupdate \
    -steam_dir "${STEAMCMD_DIR}" \
    -steamcmd_script "${STEAMCMD_SCRIPT}" \
    -pidfile "${SRCDS_PID_FILE}" \
    -usercon \
    ${SRCDS_GAME:+-game "${SRCDS_GAME}"} \
    ${SRCDS_IP:+-ip "${SRCDS_IP}"} \
    ${SRCDS_PORT:+-port "${SRCDS_PORT}"} \
    ${SRCDS_SECURITY_FLAG} \
    ${SRCDS_CLIENTPORT:++clientport "${SRCDS_CLIENTPORT}"} \
    ${SRCDS_FPSMAX:++fps_max "${SRCDS_FPSMAX}"} \
    ${SRCDS_HOSTPORT:++hostport "${SRCDS_HOSTPORT}"} \
    ${SRCDS_MAXPLAYERS:++maxplayers "${SRCDS_MAXPLAYERS}"} \
    ${SRCDS_PW:++sv_password "${SRCDS_PW}"} \
    ${SRCDS_RCONPW:++rcon_password "${SRCDS_RCONPW}"} \
    ${SRCDS_STARTMAP:++map "${SRCDS_STARTMAP}"} \
    ${SRCDS_TICKRATE:+-tickrate "${SRCDS_TICKRATE}"} \
    ${SRCDS_TOKEN:++sv_setsteamaccount "${SRCDS_TOKEN}"} \
    ${SRCDS_TV_PORT:++tv_port "${SRCDS_TV_PORT}"} \
    ${SRCDS_ADDITIONAL_ARGS}
