open Repeater
open SimpleStaged

include SimpleStaged

let fix f = .<let rec self n = .~(repeat 1 f .<self>.) n in self>.
