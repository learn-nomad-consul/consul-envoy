service {
  name = "caller-canary"
  port = 9000

  connect {
    sidecar_service {
      proxy {
        upstreams = [
          {
            destination_name = "echo-virtual"
            local_bind_port = 12345
          }
        ]
      }
    }
  }
}
