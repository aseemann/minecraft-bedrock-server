#!/bin/bash

cd $(dirname "${BASH_SOURCE[0]}")

source .env

scp -r ./docker-compose.yml "${SSH_COMMAND}:${DEPLOY_TARGET}"

ssh ${SSH_COMMAND} -t "cd ${DEPLOY_TARGET} && docker compose pull && docker compose down -v && docker compose up -d"
