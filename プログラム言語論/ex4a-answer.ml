(* ex4-answer.ml *)

(* 1-1. flatten *)
let rec f1 ll =
  match ll with
  | [] -> []
  | h::t -> List.append h (f1 t)
;;
let _ = assert (f1 [] = []);;
let _ = assert (f1 [[1;2;3];[4;5];[];[6;7;8]] = [1;2;3;4;5;6;7;8]);;
let _ = assert (f1 [[1.5;2.5;3.5];[4.5;5.5];] = [1.5;2.5;3.5;4.5;5.5]);;
let _ = assert (f1 [["abc";"def"];["ghi"];["jkl";"mno"]] =
                  ["abc";"def";"ghi";"jkl";"mno"]) ;;
let _ = assert (f1 [[[1;2];[3;4;5]];[[6;7;8]]] =
                  [[1;2];[3;4;5];[6;7;8]]) ;;

(*
 *  f3 f n init = f (f ( ... (f init) ...)) (n-th iteration)
 *)
let rec f3 f n init =
  if n = 0 then init
  else f3 f (n-1) (f init) 
;;
let add1 x = x + 1 ;;
let foo1 x = (x +. 1.0 /. x) /. 2.0 ;;
let _ = assert (f3 add1 100 3 = 103) ;;
let _ = assert (f3 foo1 100 3.0 = 1.0) ;;
let _ = assert (f3 (fun x -> x ^ "z") 3 "abc" = "abczzz") ;;
let _ = assert (f3 List.tl 3 [1;2;3;4;5] = [4;5]) ;;
let _ = assert (f3 List.tl 3 [1.0;2.0;3.0;4.0;5.0] = [4.0;5.0]) ;;

(* generic sort *)
let rec insert comp x l1 =
  match l1 with
  | [] -> [x]
  | h::t -> if (comp x h) then x :: l1
            else h :: (insert comp x t) 
;;
let rec sort2 comp l1 =
  match l1 with
  | [] -> []
  | h::t ->
     let l2 = sort2 comp t in
     insert comp h l2
;;
let comp1 x y = x < y ;;
let comp2 x y = x > y ;;

let _ = assert (sort2 comp1 [10;3;6;-1;2] = [-1;2;3;6;10]) ;;
let _ = assert (sort2 comp1 [10.1;3.1;6.1;-1.1;2.1] = [-1.1;2.1;3.1;6.1;10.1]) ;;
let _ = assert (sort2 comp1 ["b";"abc";"caa";"aaa"] = ["aaa";"abc";"b";"caa"]) ;;
let _ = assert (sort2 comp2 [10;3;6;-1;2] = List.rev [-1;2;3;6;10]) ;;
let _ = assert (sort2 comp2 [10.1;3.1;6.1;-1.1;2.1] = List.rev [-1.1;2.1;3.1;6.1;10.1]) ;;
let _ = assert (sort2 comp2 ["b";"abc";"caa";"aaa"] = List.rev ["aaa";"abc";"b";"caa"]) ;;

(* sort2 : ('a -> 'a -> bool) -> 'a list -> 'a list = <fun>
*)
