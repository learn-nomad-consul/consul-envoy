FROM consul:1.6
FROM envoyproxy/envoy:v1.11.2
COPY --from=0 /bin/consul /bin/consul
ENTRYPOINT ["consul", "connect", "envoy"]