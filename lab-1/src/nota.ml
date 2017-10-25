let isequalnote cha = 
	match cha with
	|"c" -> true
	|"d" -> true
	|"e" -> true
	|"f" -> true
	|"g" -> true
	|"a" -> true
	|"b" -> true
	|"r" -> true
	|_ -> false

let isequaltemp cha =
	match cha with
	|"1" -> true
	|"2" -> true
	|"4" -> true
	|"8" -> true
	|_ -> false

let isequalnotesos cha = 
	match cha with
	|"cis" -> true
	|"dis" -> true
	|"fis" -> true
	|"gis" -> true
	|"ais" -> true
	|_ -> false


let siguiente nota =
	match nota with
	| "c" -> "cis"
	| "cis" -> "d"
	| "d" -> "dis"
	| "dis" -> "e"
	| "e" -> "f"
	| "f" -> "fis"
	| "fis" -> "g"
	| "g" -> "gis"
	| "gis" -> "a"
	| "a" -> "ais"
	| "ais" -> "b"
	| "b" -> "c"
	| "r" -> "r"
	| _ -> ""

let anterior nota = 
	match nota with
	| "c" -> "b"
	| "b" -> "ais"
	| "ais" -> "a"
	| "a" -> "gis"
	| "gis" -> "g"
	| "g" -> "fis"
	| "fis" -> "f"
	| "f" -> "e"
	| "e" -> "dis"
	| "dis" -> "d"
	| "d" -> "cis"
	| "cis" -> "c"
	| "r" -> "r"
	| _ -> ""