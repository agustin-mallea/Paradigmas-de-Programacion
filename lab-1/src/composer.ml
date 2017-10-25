open Functions
open Comandos
open Funcrec

let rec printstack stack n =
	if n>0 then (Printf.printf "%d %s\n" (n-1) (String.concat " " (List.nth stack (n-1)));
	printstack stack (n-1))

let rec out_in concise stack =
	if (not concise) then
		Printf.printf "%s (%s)\n" Sys.argv.(1) Sys.argv.(2);
		printstack stack (List.length stack);
		Printf.printf ">";
	let command = read_line() in
	let commlist = split_space command [] in
	if commlist == [] then out_in concise stack
	else match (List.nth commlist 0) with
		|"fragmento" -> out_in concise (command_fragmento stack commlist)
		|"transponer" -> out_in concise (command_transponer stack commlist)
		|"detransponer" -> out_in concise (command_detransponer stack commlist)
		|"cortar" -> out_in concise (command_cortar stack commlist)
		|"repetir" -> out_in concise (command_repetir stack commlist)
		|"pegar" -> out_in concise (command_pegar stack commlist)
		|"intercalar" -> out_in concise (command_intercalar stack commlist)
		|"separar" -> out_in concise (command_separar stack commlist)
		|"tiempo" -> out_in concise (command_tiempo stack commlist)
		|"largo" -> out_in concise (command_largo stack commlist)
		|"aplastar" -> out_in concise (command_aplastar stack commlist)
		|"exit" -> out_in concise (finish stack commlist)
		|_-> (print_string "Comando inexistente\n";out_in concise (stack)) ;;

let main () =
	match (Array.length Sys.argv) with
	|3 -> if is_int Sys.argv.(2) (String.length(Sys.argv.(2)) - 1) then out_in false [] else print_string "El argumento debe ser entero positivo\n"
	|4 -> if Sys.argv.(3) = "-concise" then out_in true [] else print_string "Argumento invalido. \nDid you mean '-concise' ? \n "
	|_ -> (print_string "Cantidad de argumentos invalida\n";exit 0)	

let _= main ()