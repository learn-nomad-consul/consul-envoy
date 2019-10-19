kind = "service-splitter"
name = "echo"

splits = [
  {
    weight = 90
  },
  {
    weight  = 10
    service = "chaos"
  },
]
