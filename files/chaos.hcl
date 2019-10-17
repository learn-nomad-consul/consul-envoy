service {
  name = "chaos"
  port = 8080

  connect {
    sidecar_service {
      port = 20002

      check {
        name = "Connect Sidecar Listening"
        alias_service = "chaos"
      }
    }
  }
}
