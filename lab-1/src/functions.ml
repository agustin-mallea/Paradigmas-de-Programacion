open Printf
open Nota
open Funcrec

let esnota frag = 
	let p x = 		if (String.length x) == 2 then 
					(isequalnote (String.make 1 (x.[0]))) && (isequaltemp (String.make 1 (x.[1])))
		 		else if (String.length x) == 3 then 
			 		(isequalnote (String.make 1 (x.[0]))) && ((String.sub x 1 2)="16")
				else if (String.length x) == 4 then
				 	(isequalnotesos (String.sub x 0 3)) && (isequaltemp (String.make 1 (x.[3])))
				else if (String.length x) == 5 then
				 	(isequalnotesos (String.sub x 0 3)) && ((String.sub x 3 2)="16")
				else false
	in
	List.for_all p frag

let pegarnotas stack fragmento =
	match fragmento with
	|[] -> stack
	|_ -> fragmento :: stack

let transponer stack i= 
	let notas = solonotas (List.nth stack i) [] in
	let tiempos = solotiempos (List.nth stack i) [] in
	pegarnotas stack (List.rev (List.map2 (fun x y -> x ^ y) (List.map (fun z -> siguiente z) notas) tiempos))

let detransponer stack i=
	let notas = solonotas (List.nth stack i) [] in
	let tiempos = solotiempos (List.nth stack i) [] in
	pegarnotas stack (List.rev (List.map2 (fun x y -> x ^ y) (List.map (fun z -> anterior z) notas) tiempos))


let cortar stack i d l= 
	let frag = List.nth stack i in
	let hasta = d + l - 1 in
	pegarnotas stack (List.rev (cutrec 0 d hasta frag []))


let repetir stack i n =
	let frag = List.nth stack i in
	let lista = [] in
	pegarnotas stack (reperec lista frag n)

let pegar stack i j=
	let fragi = List.nth stack i in
	let fragj = List.nth stack j in
	pegarnotas stack (List.append fragi fragj)

let intercalar stack i j=
	let fragi = List.nth stack i in
	let fragj = List.nth stack j in
	let lista = [] in
	pegarnotas stack (List.rev (intercalarrec fragi fragj lista))

let separar stack i= 
	let frag = List.nth stack i in
	let listapar = separarpar (if ((List.length frag) mod 2) == 0 then (List.length frag)-2 else (List.length frag)-1) frag ([]) in
	let listaimpar = separarimpar (if ((List.length frag) mod 2) == 1 then (List.length frag)-2 else (List.length frag)-1) frag ([]) in
	pegarnotas (pegarnotas stack listaimpar) listapar


let tiempo stack i =
	(Printf.printf "%f\n" (tiempo_to_float (List.nth stack i) []); stack)

let largo stack  =
	let timelist = stack_to_float stack [] in
	let maximum = List.fold_left max (0.0) timelist in
	let i = index timelist 0 maximum in
	(Printf.printf "%i\n" (i); stack)

let aplastar stack =
	pegarnotas stack (List.fold_left List.append [] stack)

