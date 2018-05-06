open Printf
open Format

let print_simple obs =
  try printf "%d\n" (obs ())
  with Division_by_zero -> print_string "Exception: Division_by_zero\n"

let print_code obs = Print_code.print_code std_formatter (obs ())

let print_option obs =
  print_endline ([%derive.show: int option] (obs ()))

