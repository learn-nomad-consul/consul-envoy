service {
  name = "echo2"
  port = 5678

  connect {
    sidecar_service {
      port = 20001

      check {
        name = "Connect Sidecar Listening"
        alias_service = "echo2"
      }
    }
  }
}
