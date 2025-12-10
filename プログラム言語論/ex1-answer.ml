(* greatest common divisor of m and n (Euclidean algorithm) *)
let rec gcd x y =
    if x=0 then y
    else if y=0 then x
    else if x>y then gcd (x-y) y
    else gcd (y-x) x 
;;

(* f0 can be computed using gcd *)
let f0 n m =
    if (gcd n m) = 1 then 1
    else 0 
;;

(* auxiliary function for f1 
   compute the sum of divisors of n
               between m and n-1, and
   return add it to res,
   3.g. f1_sub 24 3 1000 = (3+4+6+8+12)+1000 *)
let rec f1_sub n m res =
    if n = m then res
    else if (n mod m) = 0 then f1_sub n (m+1) (res+m)
    else f1_sub n (m+1) res 
;;
(* f1 uses f1_sub *)
let f1 n =
    f1_sub n 1 n
;;

(* auxiliary function for f2
   count the number of integers between m and n-1 s.t.
   it is coprime with n (coprime == "tagai-ni-so")
*)
let rec f2_sub n m res =
    if n = m then res
    else f2_sub n (m+1) (res + (f0 n m))
;;
(* f2 uses f2_sub *)
let f2 n =
    f2_sub n 1 0
;;

(* length of binary representation of n *)
let rec bitlength n =
    if n < 2 then 1
    else 1 + (bitlength (n/2)) 
;;
(* auxiliary function for f3
   the k-th bit of n *)
let rec f3_sub n k =
    if k = 0 then n mod 2
    else f3_sub (n/2) (k-1)
;;
let f3 n k =
    let len = bitlength n in
       if (0 <= k && k < len)
         then f3_sub n (len - k)
       else 0
;;

(* least common multiple of m and n *)
let lcm n m =
  (n * m) / (gcd n m) 
;;
(* lcm of 3 numbers are obtained by iterating lcm *)
let f4 n m k = lcm n (lcm m k)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
(* test *)

let test1 =
  List.map2 f0 [10;11;12;13;14;15] [21;21;21;21;21;21]
;;

let test2 = 
  List.map f1 [10;11;12;13;14;15]
;;

let test3 = 
  List.map2 f3 [22;22;22;22;30;30] [0;1;3;5;0;4]
;;

let test4 = 
  let f4_uncurry (x,y,z) = f4 x y z in
  List.map f4_uncurry
           [(1,1,100);
            (4,6,8);
            (15,21,35);
            (2,4,32);
            (91,343,169)]
;;
