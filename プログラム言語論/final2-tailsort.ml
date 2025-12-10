(* final2-tailsort.ml *)

(* P2. tail-recursive sort *)

(* this is NOT a general sort; we fix the
  order for as  fun x -> fun y -> x < y *)

(* ac is accumulrator (partial result in the revsersed order) *)
let rec myinsert (x:int) (sorted_ls:int list) (ac:int list) : int list =
    match sorted_ls with
    | []   -> List.rev_append ac [x]
    | h::t -> if x < h
              then List.rev_append ac (x::sorted_ls)
              else myinsert x t (h::ac) ;;

let rec mysort1 (ls:int list) (ac:int list) : int list =
    match ls with
    | []   -> ac
    | h::t -> let ac2 = myinsert h ac [] in
              mysort1 t ac2 ;;

let mysort (ls:int list) : int list = 
    match ls with
    | []   -> []
    | h::t -> mysort1 t [h] ;;

(* test *)

let rec isSorted1 (x:int) (ls:int list) : bool =
    match ls with
    | []   -> true
    | h::t -> if x <= h then isSorted1 h t
              else false ;;

let isSorted (ls:int list) : bool =
    match ls with
    | []   -> true
    | h::t -> isSorted1 h t ;;
    
let bound = 100 ;;
let _ = Random.init 123123;;
let rec gennumlist (n:int) : int list =
   if n > 0 then
      (Random.int bound) :: (gennumlist (n-1)) 
   else [] ;;   

let string_of_list (ls:int list) : string =
  if List.length ls > 10 then
   (string_of_int (List.nth ls 0)) ^ "," ^
   (string_of_int (List.nth ls 1)) ^ "," ^
   (string_of_int (List.nth ls 2)) ^ "..."
  else
   String.concat "," (List.map string_of_int ls) ;;

let rec test n len =
  if n > 0 then
    let ls = gennumlist len in
    print_endline @@ "Test for " ^ (string_of_list ls) ;
    let sortedlist = mysort ls in
      print_endline @@ "Result: " ^ (string_of_bool (isSorted sortedlist));
      print_endline @@ "Result list: " ^ (string_of_list sortedlist);
     test (n-1) len
;;

(* test 1 1000    ok *)
(* test 1 10000   ok *)
(* test 1 100000  time out (limit is 60 seconds) *)


(* To show that our 'mysort' function is
   tail recursive, we need to show
   (1) the depth D: if a non-tail-recursive
       function is recursively called at D times,
       it causes the stack-overflow error,
   (2) 'mysort' does not cause stack-overflow
       even if it is called more than D times.

   We can estimate the number D by the following
   simple function.
*)

    let rec sum n =
      if n > 0 then 1 + (sum (n-1)) else 0;;
    let rec test n =
      print_endline @@ "Testing " ^ (string_of_int n);
      print_endline @@ "Result: " ^ (string_of_int (sum n));
      test (n * 10)  ;;

(*
  For Kameyama's computing environment,
    the value of D is between 10^8 and 10^9.
 *)
 
      
