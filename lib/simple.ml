type 'a repr = 'a

let int (x:int) = x

let lam f = f
let app e1 e2 = e1 e2
let rec fix f x = f (fix f) x

let add e1 e2 = e1 + e2
let sub e1 e2 = e1 - e2
let mul e1 e2 = e1 * e2
let div e1 e2 = e1 / e2

let ifz e1 e2 e3 = if e1=0 then e2 () else e3 ()

let eval e = e

type 'a obs  = 'a repr
let observe e = e ()
