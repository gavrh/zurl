package main

import (
  "os"
  "fmt"
)

func main() {
  args := os.Args[1:]
  if len(args) == 0 {
    fmt.Printf("babylon: try 'baby --help' for more information\n")
  } else {
    switch args[0] {


    default:
      fmt.Printf("babylon: '%s' is not a recognizable command, use help (-h)\n", args[0])
    }
  }
}
