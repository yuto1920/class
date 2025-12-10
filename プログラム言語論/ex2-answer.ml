(* ex2-answer.ml *)

(*
 f1 ls n =
   n-th element of ls  if |ls| <= n,
   0                   otherwise
 we assume n=0 is the first element
 *)

let rec f1 ls n =
  match ls with
  | [] -> 0
  | h::t -> if n=0 then h else f1 t (n-1)
;;

let test1 =
  List.map (fun n -> f1 [1;2;3;4;5;6;7] n)
  	   [-3;0;1;3;5;7;10]
;;

(*
 f2 ls1 ls2 = inner product of ls1 and ls2
 if |ls1| != |ls2|, ignore the extra elements
 of a longer list.
 *)

(* most naive implementation *)
let rec f2a ls1 ls2 =
    match ls1 with
    | [] -> 0
    | h1::t1 ->
        match ls2 with
        | [] -> 0
        | h2::t2 -> (h1*h2) + (f2a t1 t2)
;;

(* using clever pattern matching *)
let rec f2b ls1 ls2 =
    match (ls1,ls2) with
    | ([],_) -> 0
    | (_,[]) -> 0
    | ((h1::t1), (h2::t2)) -> (h1 * h2) + (f2b t1 t2) 
;;

(* tail-recursive implementation *)
let rec f2c_sub ls1 ls2 res =
    match (ls1,ls2) with
    | ([],_) -> res
    | (_,[]) -> res
    | ((h1::t1), (h2::t2)) -> f2c_sub t1 t2 (res + (h1 * h2))
;;
let f2c ls1 ls2 = f2c_sub ls1 ls2 0
;;

let test2 f =
  List.map (fun (ls1,ls2) -> f ls1 ls2)
  	   [([1;2;3],[10;20;30]);
  	    ([1;2;3],[10;20;30;40;50]);
  	    ([1;2;3;4;5],[10;20;30]);
  	    ([],[10;20;30]);
  	    ([1;2;3],[]);
  	   ]
;;

let _ = test2 f2a ;;
let _ = test2 f2b ;;
let _ = test2 f2c ;;

(*
 f3 ls = round(average ls), if |ls| > 0
         min_int  if |ls| = 0
 *)
let rec f3_sub ls =
    match ls with
    | [] -> (0,0)
    | h1::t1 ->
      let (num,sum) = f3_sub t1 in
         (num+1,sum+h1)
;;
let f3 ls =
  let (num,sum) = f3_sub ls in
  if num = 0 then min_int
  else let d = sum / num in 
       let r = sum mod num in 
    if r * 2 < num then d 
    else d + 1
;;
(* here, I stick to int-only computation,
   but if we are allowed to use floating-point numbers,
   we could implement it simply by
     round ((float sum) /. (float num))
 *)

let test3 =
  List.map f3
  	   [[1;2;3;4;5];
  	    [1;2;3;4];
  	    [1];
  	    [];
  	    [-100;100;200;-300];
  	   ]
;;

(*
 f4 ls = round(median ls), if |ls| > 0
         min_int  if |ls| = 0
 *)

(* mylength ls == List.length ls *)
let rec mylength ls =
    match ls with
    | []   -> 0
    | h::t -> 1 + (mylength t)
;;
(* mynth ls == List.nth ls *)
let rec mynth ls n =
    match ls with
    | []   -> failwith "no such element"
    | h::t -> if n = 0 then h
              else mynth t (n-1)
;;
(* mysort uses insertion sort *)
let rec myinsert x ls =
    match ls with
    | []   -> [x]
    | h::t -> if x <= h then x :: ls
              else h :: (myinsert x t)
;;
let rec mysort ls =
    match ls with
    | []   -> []
    | h::t -> myinsert h (mysort t)
;;
let myave x y =
    let z = x + y in
      (z / 2) + (z mod 2)
;;
let f4 ls =
    let len = mylength ls in
    if len = 0 then min_int else
      let ls_sorted = mysort ls in
      if (len mod 2 <> 0) then
         mynth ls_sorted (len/2)
      else
        let n1 = mynth ls_sorted (len/2 - 1) in
        let n2 = mynth ls_sorted (len/2) in
          myave n1 n2
;;

let test4 =
  List.map f4
  	   [[1;2;3;4;5];
  	    [4;5;1;2;3];
  	    [4;5;1;2;3;6];
  	    [4;6;1;2;3;5];
  	    [-100;100;-90;90;-80;80];
  	    [-100;100;-90;90;-80;81];
  	    [];
  	   ]
;;

(* re-implementation of List.mp *)
let rec mymap f ls =
    match ls with
    | [] -> []
    | h::t -> (f h) :: (mymap f t)
;;
let test11 =
  List.map (fun ls -> mymap (fun x -> x + 1) ls)
  	   [[];
	    [0;1;2;3;4;5;6;7];
	    [-3;0;1;3;5;7;10];
  	   ]
;;

(* map2 for doubly nested list *)
let rec mymap2 f ll =
    match ll with
    | [] -> []
    | h::t -> (mymap f h) :: (mymap2 f t)
;;
let test12 =
  List.map (fun ll -> mymap2 (fun x -> x + 1) ll)
  	   [[];
	    [[0;1;2;3;4;5;6;7];[-3;0;1;3;5;7;10]];
	    [[0;-10;20];[0;1;2;3;4;5;6;7];[-3;0;1;3;5;7;10]];
	    [[0;-10;20];[];[-3;0;1;3;5;7;10]];
	    [[0;-10;20];[];[-3;0;1;3;5;7;10];[];[1;2;3]];
  	   ]
;;
