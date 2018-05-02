exception NonValue

let rec from_option f = function
    Some x -> f x
  | None   -> raise NonValue

let to_option x = try Some x with NonValue -> None

