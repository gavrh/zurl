package main

import (
	"fmt"
	"os"
	"gurl/src/command"
)

func main() {
  args := os.Args[1:]
  if len(args) == 0 {
    fmt.Printf("gurl: try 'gurl --help' for more information\n")
  } else {
    command.Parse(args); 
  }
}
