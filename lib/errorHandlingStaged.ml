open Option

type 'a repr = 'a option code

let int (i:int) = .<Some i>.

let lam f = .<to_option @@ fun x ->
      from_option (fun x -> x) .~(f .<Some x>.)>.

let app e1 e2 =
  .<match (.~e1, .~e2) with
    (Some f, Some x) -> Some (f x)
  | _                -> None>.

let fix f =
  .<let rec self = fun n ->
      from_option (fun f -> f n) .~(f .<Some self>.)
  in to_option @@ self>.

let add e1 e2 = .<match (.~e1,.~e2) with
    (Some x, Some y) -> Some (x + y)
  | _                -> None>.
let sub e1 e2 = .<match (.~e1,.~e2) with
    (Some x, Some y) -> Some (x - y)
  | _                -> None>.
let mul e1 e2 = .<match (.~e1,.~e2) with
    (Some x, Some y) -> Some (x * y)
  | _                -> None>.
let div e1 e2 = .<match (.~e1,.~e2) with
    (Some x, Some y) -> if y=0 then None else Some (x/y)
  | _                -> None>.

let ifz e1 e2 e3 = .<match .~e1 with
    Some x -> if x=0 then .~(e2 ()) else .~(e3 ())
| _      -> None>.

let eval e =
  match Runcode.run e with
    Some x -> x
  | None   -> raise Division_by_zero

type 'a obs  = 'a repr
let observe e = e ()
