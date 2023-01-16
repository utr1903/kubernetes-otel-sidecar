#!/bin/bash

# Get commandline arguments
while (( "$#" )); do
  case "$1" in
    --arm)
      arm="true"
      shift
      ;;
    *)
      shift
      ;;
  esac
done

# ARM deployment
if [[ $arm == "true" ]]; then
  helm upgrade "server" \
    --install \
    --wait \
    --debug \
    --create-namespace \
    --namespace "test" \
    --set image.repository="uturkarslan/test-go-server-arm" \
    --set image.tag="1.0.0" \
    "../charts/server"

# AMD deployment
else
  helm upgrade "server" \
    --install \
    --wait \
    --debug \
    --create-namespace \
    --namespace "test" \
    --set image.repository="uturkarslan/test-go-server-amd" \
    --set image.tag="1.0.0" \
    "../charts/server"
fi
