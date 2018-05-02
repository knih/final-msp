open Repeater
open SimpleStaged

include SimpleStaged

let app e1 e2 = .<let x = .~e2 in .~e1 x>.

let fix f = .<let rec self n = .~(repeat 1 f .<self>.) n in self>.
