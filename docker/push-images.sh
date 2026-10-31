#!/bin/bash

set -euo pipefail

REGISTRY="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"

SERVICES=(
  auth-service
  flag-service
  targeting-service
  evaluation-service
  analytics-service
)

for SERVICE in "${SERVICES[@]}"; do

  echo "=================================="
  echo "Construindo: ${SERVICE}"
  echo "=================================="

  docker build \
    -t "${SERVICE}:latest" \
    "./${SERVICE}"

  docker tag \
    "${SERVICE}:latest" \
    "${REGISTRY}/${SERVICE}:latest"

  docker push \
    "${REGISTRY}/${SERVICE}:latest"

done

echo "Todas as imagens foram publicadas!"
