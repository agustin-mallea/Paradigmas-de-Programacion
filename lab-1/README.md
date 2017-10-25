##Acerca del diseño

Hemos tratado de modularizar lo mejor posible el código.
Creamos y utilizamos funciones auxiliares para facilitar operaciones y facilitar
la lectura del código.
No utilizamos ninguna dependencia especial, lenguaje Ocaml puro.
Usamos un Makefile para la compilación.
Definiciones de funciones en archivos mli, implementación en archivos ml.

##Acerca de las correcciones

- Hacer dos veces make falla.
	Corregido.

- Si ingreso cualquier cosa en los bpms, los acepta.
	Corregido.

- No debería imprimir el número de fragmento luego del fragmento (detalle).
	Corregido.

- de/transponer deja el fragmento al reves.
	Corregido.

- detransponer e permite bajar un C.
	Corregido.

- Manejar las notas como strings es poco abstracto.
	Cierto, sin embargo nos dijeron que estaba bien, que era otra forma de hacerlo.

- Idem con el fragmento y el stack: se podrían haber hecho nombres lindos como `type fragmento = list nota`.
	Cierto, pero lo lindo depende de los ojos que lo ven.

- Los módulos Notas, Funciones, y Funcrec tienen grupos arbitrarios de funciones. Por ejemplo, por qué iscommand está en Notas?
	Corregido.

- print_stack se puede hacer con iteri.
	Al preguntar por el uso de iteradores los mismos profesores recomendaron no usarlos.

- Duplican el código de out_in con out_in_concise, y de hecho noté que tienen un bug si no pasan un comando en el segundo.
	Corregido.

- solo_notas y solo_tiempos son ejemplos de lo feo que es utilizar notas como strings. Además, se podrían haber utilizado la función map.
	Cierto, fue todo un desafio, aprendimos bastante yendo por el camino dificil.