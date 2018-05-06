open Lint
open Printf
open Format

module EX(S:Symantics) = struct
  open S

  let fact () = fix (fun f -> lam (fun n ->
      ifz n (fun () -> int 1) (fun () ->
        mul n (app f (sub n (int 1))))))
  let fact10 () = observe @@ fun () -> app (fact ()) (int 10)
end

module Eval1 = EX(Simple)
module Eval2 = EX(SimpleStaged)
module Eval3 = EX(ErrorHandling)
module Eval4 = EX(ErrorHandlingStaged)
module Eval5 = EX(CpsErrorHandling)
module Eval6 = EX(CpsErrorHandlingStaged)
module Eval7 = EX(InliningStaged)
module Eval8 = EX(InliningNoDupStaged)
module Eval9 = EX(InliningCPSErrorHandlingStaged)

let print_simple obs =
  try printf "%d\n" (obs ())
  with Division_by_zero -> print_string "Exception: Division_by_zero\n"

let print_code obs = Print_code.print_code std_formatter (obs ())

let print_option obs =
  print_endline ([%derive.show: int option] (obs ()))

let _ = print_flush @@ print_string "Eval1: "; print_simple Eval1.fact10
let _ = print_flush @@ print_string "Eval2: "; print_code   Eval2.fact10
let _ = print_flush @@ print_string "Eval3: "; print_option Eval3.fact10
let _ = print_flush @@ print_string "Eval4: "; print_code   Eval4.fact10
let _ = print_flush @@ print_string "Eval5: "; print_option Eval5.fact10
let _ = print_flush @@ print_string "Eval6: "; print_code   Eval6.fact10
let _ = print_flush @@ print_string "Eval7: "; print_code   Eval7.fact10
let _ = print_flush @@ print_string "Eval8: "; print_code   Eval8.fact10
let _ = print_flush @@ print_string "Eval9: "; print_code   Eval9.fact10

