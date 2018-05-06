(* This signature represents the syntax and types of `lint` language,
   whose implementations will be its semantics *)
module type Symantics = sig
  type 'a repr (* representation type *)

  val int : int -> int repr
  (* We use HOAS instead of Var construct *)
  val lam : ('a repr -> 'b repr) -> ('a -> 'b) repr
  val app : ('a -> 'b) repr -> 'a repr -> 'b repr
  (* To encode recursion in the typed-final style, we introduce the fix operator *)
  val fix : (('a -> 'b) repr -> ('a -> 'b) repr) -> ('a -> 'b) repr
  val add : int repr -> int repr -> int repr
  val sub : int repr -> int repr -> int repr
  val mul : int repr -> int repr -> int repr
  val div : int repr -> int repr -> int repr
  val ifz : int repr -> (unit -> 'a repr) -> (unit -> 'a repr) -> 'a repr

  (* Evaluate an object term *)
  val eval : 'a repr -> 'a
  (* Constructs for observing object terms of repr type from outside *)
  type 'a obs
  val observe : (unit -> 'a repr) -> 'a obs
end
