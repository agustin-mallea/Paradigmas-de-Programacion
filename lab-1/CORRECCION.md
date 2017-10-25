Nota: 7.1

## Entrega (80%)

 - Hacer dos veces make falla.

 - El README repite el enunciado y dice poco del trabajo y las decisiones de diseño.

## Funcionalidad (90%)

 - Si ingreso cualquier cosa en los bpms, los acepta.

 - No debería imprimir el número de fragmento luego del fragmento (detalle).

 - de/transponer deja el fragmento al reves.

 - detransponer e permite bajar un C.

## Modularización (60%)

 - Manejar las notas como strings es poco abstracto.

 - Idem con el fragmento y el stack: se podrían haber hecho nombres lindos como `type fragmento = list nota`.

 - Los módulos Notas, Funciones, y Funcrec tienen grupos arbitrarios de funciones. Por ejemplo, por qué iscommand está en Notas?

 - Bien la separación de Commands.

## Código (70%)

 - print_stack se puede hacer con iteri.

 - Duplican el código de out_in con out_in_concise, y de hecho noté que tienen un bug si no pasan un comando en el segundo.

 - solo_notas y solo_tiempos son ejemplos de lo feo que es utilizar notas como strings. Además, se podrían haber utilizado la función map.

 - Un poco mas de abstracción en los chequeos de Commands hubieran hecho el código un poco mas legible. Pero likes al checkeo de ints.
