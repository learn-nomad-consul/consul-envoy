service {
  name = "echo"
  port = 5678

  connect {
    sidecar_service {
      port = 20000

      checks {
        name = "Connect Sidecar Listening"
        alias_service = "echo"
      }
    }
  }
}
