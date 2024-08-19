#!/usr/bin/bash

cat "${GITHUB_WORKSPACE}/${INPUT_FILENAME}" | tr -d '\r' | ${GITHUB_WORKSPACE}/${ZIP_NAME}/"${EXECUTABLE_NAME}"
