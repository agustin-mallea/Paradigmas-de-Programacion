let rec sum_tiempo l=
	match l with
	|[] -> 0.00
	|h::t -> h+. (sum_tiempo t)

let rec has_b frag =
	match frag with
	|[] -> false
	|x::xs -> if (String.contains x 'b') then true
				else has_b (List.tl frag)

let rec has_c frag =
	match frag with
	|[] -> false
	|x::xs -> if (String.contains x 'c') then true
				else has_b (List.tl frag)

let rec split_space s slist =
	match s with
	|""-> slist
	|s -> if (String.contains s ' ') then split_space (String.sub s 0 (String.rindex s ' ')) ((String.sub s ((String.rindex s ' ')+1) ((String.length s)-((String.rindex s ' ')+1)))::slist) else split_space ("") (s :: slist)


let rec solonotas frag list_solo_notas = 
		match frag with
		| [] -> list_solo_notas
		| x::xs -> 	if (String.contains x 'i') && (String.contains x 's') then
						solonotas (List.tl frag) ((String.sub x 0 3)::list_solo_notas)
					else solonotas (List.tl frag) ((String.sub x 0 1)::list_solo_notas)

let rec solotiempos frag list_solo_tiempo = 
		match frag with
		| [] -> list_solo_tiempo
		| x::xs -> 	if (String.contains x '1') && (String.contains x '6') then solotiempos (List.tl frag) ((String.sub x ((String.length x)-2) 2)::list_solo_tiempo)
				else solotiempos (List.tl frag) ((String.sub x ((String.length x)-1) 1)::list_solo_tiempo)

let rec reperec lista frag n =
	match n with
	| 0 -> lista
	| n -> reperec (List.append frag lista) frag (n-1)	


let rec intercalarrec fragi fragj lista =
	if ((List.length fragi) == 0) && ((List.length fragj) == 0) then lista
	else if ((List.length fragi)>0) && ((List.length fragj)>0) then intercalarrec (List.tl fragi) (List.tl fragj) ((List.hd fragj) :: ((List.hd fragi) :: lista))
	else if (List.length fragi) > 0 then intercalarrec (List.tl fragi) fragj ((List.hd fragi) :: lista)
	else intercalarrec fragi (List.tl fragj) ((List.hd fragj) :: lista)

let rec separarpar n frag lista =
	if n<0 then lista
	else separarpar (n-2) frag ((List.nth frag n) :: lista)

let rec separarimpar n frag lista =
	if n<=0 then lista
	else separarimpar (n-2) frag ((List.nth frag n) :: lista)

let rec tiempo_to_float frag list_tiempo = 
	match frag with
	|[] -> sum_tiempo list_tiempo
	|x::xs -> if (String.contains x '1') then
					if (String.contains x '6') then 
						(tiempo_to_float (List.tl frag) (0.25 :: list_tiempo))
					else (tiempo_to_float (List.tl frag) (4.00 :: list_tiempo))
				else if (String.contains x '2') then
						(tiempo_to_float (List.tl frag) (2.00 :: list_tiempo))
				else if (String.contains x '4') then
						(tiempo_to_float (List.tl frag) (1.00 :: list_tiempo))
				else if (String.contains x '8') then
						tiempo_to_float (List.tl frag) (0.50 :: list_tiempo) 
				else (tiempo_to_float (List.tl frag) (0.00 :: list_tiempo))

let rec stack_to_float stack list_tiempo =
	match stack with
	| [] -> list_tiempo
	| x::xs -> tiempo_to_float x list_tiempo :: stack_to_float xs list_tiempo

let rec index timelist i value =
	match timelist with
	| [] -> (-1)
	| x::xs -> if (x == value) then (i) else (index xs (i+1) value)

let rec cutrec i d hasta frag lista = 
	if i>hasta then lista
	else if i<d then  cutrec (i+1) d hasta frag lista
	else cutrec (i+1) d hasta frag ((List.nth frag i) :: lista)
	

let checkarg commlist cant = (List.length commlist) == cant


let chk chr =
	match chr with
	|'0' -> true
	|'1' -> true
	|'2' -> true
	|'3' -> true
	|'4' -> true
	|'5' -> true
	|'6' -> true
	|'7' -> true
	|'8' -> true
	|'9' -> true
	|_ -> false

let rec is_int word l=
	if l>=0 then
		chk word.[l] && is_int word (l-1)
	else
		true