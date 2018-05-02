module type Symantics = sig
  type 'a repr

  val int : int -> int repr
  val lam : ('a repr -> 'b repr) -> ('a -> 'b) repr
  val app : ('a -> 'b) repr -> 'a repr -> 'b repr
  val fix : (('a -> 'b) repr -> ('a -> 'b) repr) -> ('a -> 'b) repr
  val add : int repr -> int repr -> int repr
  val sub : int repr -> int repr -> int repr
  val mul : int repr -> int repr -> int repr
  val div : int repr -> int repr -> int repr
  val ifz : int repr -> (unit -> 'a repr) -> (unit -> 'a repr) -> 'a repr

  val eval : 'a repr -> 'a
  type 'a obs
  val observe : (unit -> 'a repr) -> 'a obs
end
