open Functions
open Funcrec
open Nota

let command_fragmento stack commlist =
	if List.length commlist > 1 && esnota (List.tl commlist) then
		begin
			if (stack == []) then
				pegarnotas stack (List.tl commlist)
			else
				let frag = (List.tl commlist) in
				pegarnotas stack frag
		end
	else (print_string "Notas: error de sintaxis\n"; stack)
		

let command_transponer stack commlist =
	if checkarg commlist 3 then
		if is_int (List.nth commlist 2) (String.length(List.nth commlist 2) - 1) then
			let m = (List.nth commlist 1) in
			let i = (int_of_string (List.nth commlist 2)) in
			if i < (List.length stack) then
				match m with
				|"m" -> transponer stack i
				|"e" -> if not(has_b (List.nth stack i)) then
							transponer stack i
						else (print_string "No se pudo transponer\n"; stack)
				|_->(print_string "No es un modificador valido\n"; stack)
			else (print_string "No es un indice valido en el stack de fragmentos\n"; stack)
		else (print_string "El 2° argumento debe ser un entero positivo\n"; stack)
	else (print_string "Cantidad de Argumentos incorrectos\n"; stack)

let command_detransponer stack commlist =
	if checkarg commlist 3 then
		if is_int (List.nth commlist 2) (String.length(List.nth commlist 2) - 1) then
			let m = (List.nth commlist 1) in
			let i = (int_of_string (List.nth commlist 2)) in
			if i < (List.length stack) then
				match m with
				|"m" -> detransponer stack i
				|"e" -> if not(has_c (List.nth stack i)) then
							detransponer stack i
						else (print_string "No se pudo transponer\n"; stack)
				|_->(print_string "No es un modificador valido\n"; stack)
			else (print_string "No es un indice valido en el stack de fragmentos\n"; stack)
		else (print_string "El 2° argumento debe ser un entero positivo\n"; stack) 
	else (print_string "Cantidad de Argumentos incorrectos\n"; stack)	

let command_cortar stack commlist =
	if checkarg commlist 4 then
		if is_int (List.nth commlist 1) (String.length(List.nth commlist 1) - 1)
		&& is_int (List.nth commlist 2) (String.length(List.nth commlist 2) - 1)
		&& is_int (List.nth commlist 3) (String.length(List.nth commlist 3) - 1) then
			let i = (int_of_string (List.nth commlist 1)) in
			let d = (int_of_string (List.nth commlist 2)) in
			let l = (int_of_string (List.nth commlist 3)) in
			if i < (List.length stack) then
				if d >= 0 && l >= 0 then
					if (d + l - 1) < (List.length (List.nth stack i)) then
						cortar stack i d l			
					else (print_string "Argumentos offset y largo estan fuera de la lista\n"; stack)
				else (print_string "Argumentos deben ser enteros positivos\n"; stack)
			else (print_string "No es un indice valido en el stack de fragmentos\n"; stack)
		else (print_string "Los argumentos deben ser enteros positivos\n"; stack)
	else (print_string "Cantidad de Argumentos incorrectos\n"; stack)

let command_repetir stack commlist =
	if checkarg commlist 3 then
		if is_int (List.nth commlist 1) (String.length(List.nth commlist 1) - 1)
		&& is_int (List.nth commlist 2) (String.length(List.nth commlist 2) - 1) then
			let i = (int_of_string (List.nth commlist 1)) in
			let n = (int_of_string (List.nth commlist 2)) in
			if i < (List.length stack) then 
				if n >= 0 then
					repetir stack i n
				else (print_string "El numero debe ser positivo\n"; stack) 
			else (print_string "No es un indice valido en el stack de fragmentos\n"; stack)
		else (print_string "Los argumentos deben ser enteros positivos\n"; stack)
	else (print_string "Cantidad de Argumentos incorrectos\n"; stack)

let command_pegar stack commlist = 
	if checkarg commlist 3 then
		if is_int (List.nth commlist 1) (String.length(List.nth commlist 1) - 1)
		&& is_int (List.nth commlist 2) (String.length(List.nth commlist 2) - 1) then
			let i = (int_of_string (List.nth commlist 1)) in
			let j = (int_of_string (List.nth commlist 2)) in
			if i < (List.length stack) then 
				if j < (List.length stack) then
					pegar stack i j
				else (print_string "No es un indice valido en el stack de fragmentos\n"; stack) 
			else (print_string "No es un indice valido en el stack de fragmentos\n"; stack)
		else (print_string "Los argumentos deben ser enteros positivos\n"; stack)
	else (print_string "Cantidad de Argumentos incorrectos\n"; stack)

let command_intercalar stack commlist = 
	if checkarg commlist 3 then
		if is_int (List.nth commlist 1) (String.length(List.nth commlist 1) - 1)
		&& is_int (List.nth commlist 2) (String.length(List.nth commlist 2) - 1) then
			let i = (int_of_string (List.nth commlist 1)) in
			let j = (int_of_string (List.nth commlist 2)) in
			if i < (List.length stack) then 
				if j < (List.length stack) then
					intercalar stack i j
				else (print_string "No es un indice valido en el stack de fragmentos\n"; stack) 
			else (print_string "No es un indice valido en el stack de fragmentos\n"; stack)
		else (print_string "Los argumentos deben ser enteros positivos\n"; stack)
	else (print_string "Cantidad de Argumentos incorrectos\n"; stack)

let command_separar stack commlist = 
	if checkarg commlist 2 then
		if is_int (List.nth commlist 1) (String.length(List.nth commlist 1) - 1) then
			let i = (int_of_string (List.nth commlist 1)) in
			if i < (List.length stack) then 
				separar stack i
			else (print_string "No es un indice valido en el stack de fragmentos\n"; stack)
		else (print_string "El argumento debe ser entero positivo\n"; stack)
	else (print_string "Cantidad de Argumentos incorrectos\n"; stack)

let command_tiempo stack commlist =
	if checkarg commlist 2 then
		if is_int (List.nth commlist 1) (String.length(List.nth commlist 1) - 1) then
			let i = (int_of_string (List.nth commlist 1)) in
			if i < (List.length stack) then 
				tiempo stack i
			else (print_string "No es un indice valido en el stack de fragmentos\n"; stack)
		else (print_string "El argumento debe ser entero positivo\n"; stack)
	else (print_string "Cantidad de Argumentos incorrectos\n"; stack)

let command_largo stack commlist =
	if checkarg commlist 1 then
		if (List.length stack == 0) then (print_string "No hay fragmentos.\n"; stack)
		else largo stack
	else (print_string "Cantidad de Argumentos incorrectos\n"; stack)

let command_aplastar stack commlist =
	if checkarg commlist 1 then
		if (List.length stack == 0) then (print_string "No hay fragmentos.\n"; stack)
		else aplastar stack
	else (print_string "Cantidad de Argumentos incorrectos\n"; stack)

let finish stack commlist =
	if checkarg commlist 1 then 
		if (List.length stack == 0) then exit 0	
		else (Printf.printf " %s %s\n" Sys.argv.(2) (String.concat " " (List.nth stack 0)); exit 0)
	else (print_string "Cantidad de Argumentos incorrectos\n"; stack)