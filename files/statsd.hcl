service {
  name = "statsd"
  port = 9102

  connect {
    sidecar_service {
      port = 19102

      checks {
        name = "Connect Sidecar Listening"
        alias_service = "statsd"
      }
    }
  }
}
