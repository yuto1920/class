(* ex5-answer.ml *)

(*
 * tail recursion for list-sum
 *)

let rec f1sub ll acc =
  match ll with
  | [] -> acc
  | h::t -> f1sub t (acc + h)
;;
let f1 ll = f1sub ll 0
;;
let _ = assert (f1 [] = 0);;
let _ = assert (f1 [1] = 1) ;;
let _ = assert (f1 [1;2] = 3) ;;
let _ = assert (f1 [1;2;3] = 6) ;;
let rec gen_list n acc =
  if n = 0 then acc
  else gen_list (n-1) (1::acc)
;;
let long_list = gen_list 10000 [] ;;
let _ = f1 long_list ;;

(*
 * tail recursion for pair-sum 
 *)

let rec revappend l1 acc =
  match l1 with
  | [] -> acc
  | h::t -> revappend t (h::acc)
;;
let rec f2sub l1 l2 acc =
  match l1,l2 with
  | [],[] -> acc
  | [],h2::t2 -> revappend l2 acc
  | h1::t1,[] -> revappend l1 acc
  | h1::t1,h2::t2 -> f2sub t1 t2 ((h1+h2)::acc)
;;
let f2 l1 l2 = f2sub l1 l2 []
;;
let _ = assert (f2 [] [] = []) ;;
let _ = assert (f2 [1;2;3] [4;5;6] = [9;7;5]) ;;
let _ = assert (f2 [1;2;3;10] [4;5;6] = [10;9;7;5]) ;;
let _ = assert (f2 [1;2;3] [4;5;6;10] = [10;9;7;5]) ;;
let _ = f2 long_list long_list ;;

(*
 *  tail recursion for map
 *)
let rec f3sub f l1 acc =
  match l1 with
  | [] -> revappend acc []
  | h::t -> f3sub f t ((f h)::acc)
;;
let f3 f l1 = f3sub f l1 []
;;
let _ = assert (f3 (fun x -> x + 1) [] = []) ;;
let _ = assert (f3 (fun x -> x + 1) [1;2;3;4;5] = [2;3;4;5;6]) ;;
let _ = assert (f3 (fun x -> x * 2 + 1) [1;2;3;4;5] = [3;5;7;9;11]) ;;
let _ = assert (f3 (fun x -> x +. 0.5) [3.14] = [3.64]) ;;
let _ = assert (f3 (fun x -> x +. 0.5) [1.5;2.5;3.5] = [2.0;3.0;4.0]) ;;
let _ = f3 (fun x -> x + 1) long_list ;;


(*
 * CPS version of fact
 *)

let rec fact n =
  if n = 0 then 1
  else n * (fact (n - 1))
;;
let rec fact_cps n k =
  if n = 0 then k 1
  else fact_cps (n - 1) (fun x -> k (n * x))
;;
let _ = assert (fact_cps 5 (fun x -> x) = fact 5) ;;

let rec fib n =
  if n <= 1 then 1
  else fib (n - 2) + fib (n - 1)
;;
let rec fib_cps n k =
  if n <= 1 then k 1
  else fib_cps (n - 2) (fun x -> 
       fib_cps (n - 1) (fun y -> 
       k (x + y)))
;;
let _ = assert (fib_cps 5 (fun x -> x) = fib 5) ;;
