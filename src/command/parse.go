package command

import "fmt"

// parse command
func Parse(args []string) {
  
  fmt.Printf("%v\n", args)

  for x, s := range args {
    for y, c := range s {
      print(c)
    }
    println();
  }

}

// parse headers
// parse body
// parse parametes
//



// curl --post discord.com/api/v10/channels/chn/messages --f request.json
