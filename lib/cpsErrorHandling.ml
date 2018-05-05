open Option

type 'a repr = { ko : 'w. ('a option -> 'w) -> 'w }

let int (i:int) = { ko = fun k -> k (Some i) }

let lam f = { ko = fun k ->
    k @@ to_option (fun v ->
        from_option (fun x -> x) @@
        (f {ko=fun k -> k (Some v)}).ko (fun k -> k)
      )
  }

let app e1 e2 = { ko = fun k ->
    e1.ko (fun f ->
    e2.ko (fun v ->
            match (f, v) with
              (Some f', Some v') -> k @@ Some (f' v')
            | _                  -> k None
          ))
  }

let fix f =
  let rec fx f n = app (f (lam (fx f))) n
  in lam (fx f)

let add e1 e2 = { ko = fun k ->
    e1.ko @@ fun v1 ->
    e2.ko @@ fun v2 ->
    match (v1, v2) with
      (Some x, Some y) -> k @@ Some (x + y)
    | _                -> k None
  }
let sub e1 e2 = { ko = fun k ->
    e1.ko @@ fun v1 ->
    e2.ko @@ fun v2 ->
    match (v1, v2) with
      (Some x, Some y) -> k @@ Some (x - y)
    | _                -> k None
  }
let mul e1 e2 = { ko = fun k ->
    e1.ko @@ fun v1 ->
    e2.ko @@ fun v2 ->
    match (v1, v2) with
      (Some x, Some y) -> k @@ Some (x * y)
    | _                -> k None
  }
let div e1 e2 = { ko = fun k ->
    e1.ko @@ fun v1 ->
    e2.ko @@ fun v2 ->
    match (v1, v2) with
      (Some x, Some y) -> if y=0 then k None else k @@ Some (x / y)
    | _                -> k None
  }
let ifz e1 e2 e3 = { ko = fun k ->
    e1.ko @@ fun v1 ->
    match v1 with
      Some x -> if x=0 then (e2 ()).ko k else (e3 ()).ko k
    | _      -> k None
  }

let eval e = e.ko (function Some x -> x
                          | None   -> raise Division_by_zero)

type 'a obs = 'a option
let observe e = (e ()).ko (fun k -> k)
