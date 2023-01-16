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

######################
### Otel Collector ###
######################
helm upgrade "otelcollector" \
  --install \
  --wait \
  --debug \
  --create-namespace \
  --namespace "test" \
  --set newRelicLicenseKey=$NEWRELIC_LICENSE_KEY \
  --set name="otelcollector" \
  --set grpcPort=4317 \
  --set httpPort=4318 \
  --set fluentPort=8006 \
  --set newRelicOtlpGrpcEndpoint="https://otlp.eu01.nr-data.net:4317" \
  "../charts/otelcollector"
#########

##############
### Server ###
##############

# ARM deployment
if [[ $arm == "true" ]]; then
  helm upgrade "server" \
    --install \
    --wait \
    --debug \
    --create-namespace \
    --namespace "test" \
    --set server.image.repository="uturkarslan/test-go-server-arm" \
    --set server.image.tag="1.0.0" \
    "../charts/server"

# AMD deployment
else
  helm upgrade "server" \
    --install \
    --wait \
    --debug \
    --create-namespace \
    --namespace "test" \
    --set server.image.repository="uturkarslan/test-go-server-amd" \
    --set server.image.tag="1.0.0" \
    "../charts/server"
fi
#########
