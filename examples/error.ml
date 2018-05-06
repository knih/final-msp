open Lint
open Lint_print
open Format

module EX(S:Symantics) = struct
  include S

  let ex () = observe @@ fun () -> div (int 1) (int 0)
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

let _ = print_flush @@ print_string "Eval1: "; print_simple Eval1.ex
let _ = print_flush @@ print_string "Eval2: "; print_code   Eval2.ex
let _ = print_flush @@ print_string "Eval3: "; print_option Eval3.ex
let _ = print_flush @@ print_string "Eval4: "; print_code   Eval4.ex
let _ = print_flush @@ print_string "Eval5: "; print_option Eval5.ex
let _ = print_flush @@ print_string "Eval6: "; print_code   Eval6.ex
let _ = print_flush @@ print_string "Eval7: "; print_code   Eval7.ex
let _ = print_flush @@ print_string "Eval8: "; print_code   Eval8.ex
let _ = print_flush @@ print_string "Eval9: "; print_code   Eval9.ex

