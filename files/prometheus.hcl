service {
  name = "prometheus"
  port = 9090

  connect {
    sidecar_service {
      proxy {
        upstreams = [
          {
            destination_name = "statsd"
            local_bind_port = 2345
          }
        ]
      }
    }
  }
}
