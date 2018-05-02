type 'a repr = 'a code

let int x = .<x>.

let lam f = .<fun x -> .~(f .<x>.)>.
let app e1 e2 = .< .~e1 .~e2 >.
let fix f = .<let rec self n = .~(f .<self>.) n in self>.

let add e1 e2 = .<.~e1 + .~e2>.
let sub e1 e2 = .<.~e1 - .~e2>.
let mul e1 e2 = .<.~e1 * .~e2>.
let div e1 e2 = .<.~e1 / .~e2>.

let ifz e1 e2 e3 = .<if .~e1=0 then .~(e2 ()) else .~(e3 ())>.

let eval e = Runcode.run e

type 'a obs  = 'a code
let observe e = e ()
