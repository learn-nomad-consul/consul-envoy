kind = "service-router"
name = "echo-virtual"

routes = [
  {
    match {
      http {
        path_prefix = "/v2"
      }
    }

    destination {
      service = "echo2"
      num_retries = 3
      retry_on_status_codes = [500, 501]
    }
  },
  {
    match {
      http {
        path_prefix = "/"
      }
    }

    destination {
      service = "echo"
    }
  },
]
