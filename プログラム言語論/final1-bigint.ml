(* final1-bigint.ml *)

(* P1. big integer *)

(* [a1; a2; ...; an] where 0<=ai<10
   means a1 + a2*10 + ... + an*10^(n-1)
 *)

type bigInt = int list ;;
let split (n:int) = (n / 10, n mod 10);;

let rec normalize1 (bigR:bigInt) : bigInt = 
  match bigR with
  | [] -> []
  | 0::t -> normalize1 t 
  | h::t -> List.rev bigR ;;
let normalize (big:bigInt) : bigInt = 
   normalize1 (List.rev big) ;;

let isZero (big:bigInt) : bool = 
   (normalize big) = [] ;;

let rec bigAdd1 (big1:bigInt) (big2:bigInt) (c:int): bigInt =
  match (big1,big2) with
  | ([],_) -> if c = 0 then big2
            else bigAdd1 [c] big2 0
  | (_,[]) -> if c = 0 then big1
            else bigAdd1 big1 [c] 0
  | (h1::t1,h2::t2) ->
            let i = c + h1 + h2 in
            let (c2,rem) = split i in
            let rest = bigAdd1 t1 t2 c2 in
               rem :: rest ;;

let bigAdd (big1:bigInt) (big2:bigInt) : bigInt =
    normalize @@ bigAdd1 big1 big2 0 ;;

let rec bigMul1 (big1:bigInt) (n:int) (c:int) : bigInt =
  match big1 with
  | [] -> if c = 0 then [] else [c]
  | h::t -> let i = h * n + c in
            let (c2,rem) = split i in
              rem :: (bigMul1 t n c2) ;;

let rec bigMul2 (big1:bigInt) (big2:bigInt) : bigInt =
  match big2 with
  | [] -> []
  | h::t -> let m1 = bigMul1 big1 h 0 in 
            let m2 = bigMul2 big1 t in 
              bigAdd m1 (0::m2) ;;

let bigMul (big1:bigInt) (big2:bigInt) : bigInt =
   normalize @@ bigMul2 big1 big2;;

(* test *)

let bound = 100000 ;;
let _ = Random.init 123123;;
let gennum () : int = Random.int bound;;

let rec bigInt_of_int (i:int) : bigInt =
    if i > 0 then 
     let (c,r) = split i in
      r :: (bigInt_of_int c) 
    else [] ;;

let rec int_of_bigInt (big:bigInt) : int =
    match big with
    | [] -> 0
    | h::t -> h + (int_of_bigInt t) * 10 ;;

let rec test n =
  if n > 0 then
    let i1 = gennum () in
    let i2 = gennum () in
    let b1 = bigInt_of_int i1 in
    let b2 = bigInt_of_int i2 in
      print_endline @@ "Test for " ^ (string_of_int i1) ^ " and " ^ (string_of_int i2);
      let bigsum = int_of_bigInt @@ bigAdd b1 b2 in
      let sum    = i1 + i2 in
      let result = (bigsum = sum) in
      print_endline @@ "Result of addition: "
        ^ string_of_bool result ^ " : "
	^ (string_of_int bigsum) ^ " and "
	^ (string_of_int sum);
      let bigmul = int_of_bigInt @@ bigMul b1 b2 in
      let mul    = i1 * i2 in
      let result = (bigmul = mul) in
      print_endline @@ "Result of multiplication: "
        ^ string_of_bool result ^ " : "
	^ (string_of_int bigmul) ^ " and "
	^ (string_of_int mul);
      test (n-1)  
;;

   
