let rec repeat n f =
  if n=0 then f else fun x -> f (repeat (n-1) f x)
