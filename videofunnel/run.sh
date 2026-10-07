#!/usr/bin/with-contenv bashio
# shellcheck shell=bash
set -e
CFG=/config/videofunnel.json
PORT=$(bashio::config 'port' 8080)
HOST=$(bashio::config 'host' '0.0.0.0')
mkdir -p /config
if [ ! -s "$CFG" ]; then
  if [ -s /share/videofunnel/videofunnel.json ]; then
    bashio::log.info "Seeding config from /share/videofunnel/videofunnel.json"
    cp /share/videofunnel/videofunnel.json "$CFG"
  else
    bashio::log.info "No config yet; VideoFunnel will create defaults at $CFG"
  fi
fi
ARGS=(-H "$HOST" -P "$PORT" -C "$CFG")
bashio::config.true 'update_check' || ARGS+=(--no-update-check)
bashio::log.info "Starting VideoFunnel $(/usr/bin/vf --version 2>/dev/null || true) on ${HOST}:${PORT}"
exec /usr/bin/vf "${ARGS[@]}"
