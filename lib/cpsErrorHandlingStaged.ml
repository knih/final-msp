open Option

type 'a repr = { ko : 'w. ('a code option -> 'w code) -> 'w code}

let int (i:int) = { ko = fun k -> k (Some .<i>.) }

let lam (f: ('a repr -> 'b repr)) : ('a -> 'b) repr = {ko=fun k ->
    k @@ to_option .<fun v ->
        .~((f {ko=fun k -> k (Some .<v>.)}).ko (fun k1 ->
            from_option (fun x -> x) k1))
      >.
  }

let app e1 e2 = { ko = fun k ->
    e1.ko (fun f ->
        e2.ko (fun v ->
            match (f, v) with
              (Some f', Some v') -> k @@ Some .<(.~f' .~v')>.
            | _      -> k None))
  }

let fix (f: ('a -> 'b) repr -> ('a -> 'b) repr) = { ko = fun k ->
    k @@ to_option .<let rec self n =
                 .~((f {ko=fun k -> k (Some .<self>.)}).ko (fun k1 ->
                      from_option (fun x -> x) k1)) n
         in self>.
  }


let add e1 e2 = { ko = fun k ->
    e1.ko @@ fun v1 ->
    e2.ko @@ fun v2 ->
    match (v1,v2) with
      (Some x, Some y) -> k @@ Some (.<.~x + .~y>.)
    | _                -> k None
  }
let sub e1 e2 = { ko = fun k ->
    e1.ko @@ fun v1 ->
    e2.ko @@ fun v2 ->
    match (v1,v2) with
      (Some x, Some y) -> k @@ Some (.<.~x - .~y>.)
    | _                -> k None
  }
let mul e1 e2 = { ko = fun k ->
    e1.ko @@ fun v1 ->
    e2.ko @@ fun v2 ->
    match (v1,v2) with
      (Some x, Some y) -> k @@ Some (.<.~x * .~y>.)
    | _                -> k None
  }
let div e1 e2 = { ko = fun k ->
    e1.ko @@ fun v1 ->
    e2.ko @@ fun v2 ->
    match (v1,v2) with
      (Some x, Some y) -> .<if .~y=0
                            then .~(k None)
                            else .~(k @@ Some .<.~x / .~y>.)>.
    | _ -> k None
  }

let ifz e1 e2 e3 = { ko = fun k ->
    e1.ko @@ fun v1 ->
    match v1 with
      Some x -> .<if .~x=0 then .~((e2 ()).ko k) else .~((e3 ()).ko k)>.
    | _      -> k None
  }

let eval (e: 'a repr) = Runcode.run @@ e.ko (fun k ->
    match k with
      Some x -> x
    | None   -> .<raise Division_by_zero>.)

type 'a obs = 'a code
let observe e = (e ()).ko (function Some x -> x
                                  | None   -> .<raise Division_by_zero>.)
