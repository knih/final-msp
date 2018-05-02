open Option
open Repeater
open CpsErrorHandlingStaged

include CpsErrorHandlingStaged

let fix f = { ko = fun k ->
    k @@ to_option .<let rec self n =
                 .~((repeat 1 f {ko=fun k -> k (Some .<self>.)}).ko (fun k1 ->
                      from_option (fun x -> x) k1)) n
         in self>.
  }
