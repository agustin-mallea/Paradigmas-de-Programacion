#Lab Funcional


El objetivo de este lab es que se familiaricen con el paradigma funcional. Para ello, van a tener que codificar un programa para escribir música en el lenguaje OCaml.

A grandes rasgos, el programa debe interactuar con el usuario para que éste
pueda crear una canción. La canción consta de un nombre, un tiempo (en bpms,
golpes (beats) por minutos), y un *stack* de fragmentos. Los fragmentos son a su
vez una serie de notas y silencios. Cuando el programa se termina, se considera
que el primer fragmento del stack es la canción final, que puede ser el
resultado de combinar otros fragmentos. Para simplificar, las canciones siempre
van a estar en 4/4 (pueden omitir este dato si no saben lo que significa).

Para representar las notas, vamos a utilizar la convención de escribirlas en el
cifrado anglosajón (a = La, b = Si, c = Do, d = Re, e = Mi, f = Fa, g =
sol). Las notas deben escribirse en minúscula. Si queremos una nota sostenida
agregamos "is" luego de la letra (e.g., "cis" para Do sostenido). No vamos a
incluir bemoles. Para la duración de la nota vamos a escribir: 1 para la redonda
(4 beats), 2 para la blanca (2 beats), 4 para la negra (1 beat), 8 para la
corchea (1/2 beat), y 16 para la semicorchea (1/4 beat). Los silencios serán
indicados con la letra r.

Los fragmentos son una lista de notas, que se presentarán con espacios entre las
notas. El siguiente es un fragmento de ejemplo:

```
c4 cis4 d2 r4
```

Representa 4 figuras:

  - Una negra en Do.
  - Una negra en Do sostenido.
  - Una blanca en Re.
  - Un silencio de misma duración que una negra.

Para crear los fragmentos el usuario puede escribir la siguiente serie de
comandos:

- `fragmento f` agrega al stack el fragmento *f*.

- `transponer m i` agrega al stack el resultado de tomar el fragmento con índice
  *i* y transponerlo (subir cada nota) en 1 semitono. El caso especial de la nota
  `b` (Si), como no estamos considerando octavas, se debe actuar de acuerdo al
  modificador *m*:
  * `m` sube a `b` como un `c` (Do).
  * `e` imprime error en pantalla "No se pudo transponer", y no modifica el stack. En caso que no haya una nota `b` debe transponer el fragmento.

- `detransponer m i` agrega al stack el resultado de tomar el fragmento con
  índice *i* y transponerlo -1 semitono. Al `c` (Do) lo detranspone como `b`
  (Si), o indica error, de acuerdo a los mismos modificadores de `transponer`.

- `cortar i d l` agrega al stack el resultado de cortar el fragmento con indice
  *i* desde la nota *d* hasta la *d*+*l*-1 (la primer nota es 0). Es decir, toma *l* notas desde la posición *d*.

- `repetir i n` agrega al stack el resultado de pegar *n* veces el fragmento con
  índice *i*.

- `pegar i j` concatena el fragmento con índice *i* y el fragmento de índice
  *j*, y agrega el resultado al stack.

- `intercalar i j` agrega al stack el resultado de intercalar cada nota en el
  fragmento de índice *i* con cada nota del fragmento de índice *j*.

- `separar i` agrega al stack dos fragmentos, el primero con las notas en
  posiciones impares del fragmento de índice *i*, y otro con los pares.

- `tiempo i` imprime en pantalla el tiempo total (en beats) del fragmento *i*, y
  no modifica el stack.

- `exit`: imprime en pantalla el resultado. En una primera línea se muestra la
  canción seguido entre paréntesis el tiempo, y en la segunda línea va la
  canción resultante (el primer elemento del stack).

Al comienzo y luego de ejecutar cada comando el programa debe mostrar la
siguiente información, donde *n* es la cantidad de fragmentos:

```
Nombre de canción (tiempo)
n-1 fragmento n-1
...
0 fragmento 0
>
```
El `>` es para indicar que el usuario puede escribir un comando a continuación.

Por ejemplo, podemos crear una alternancia entre Do y Re del siguiente modo:
```
fragmento c4   ( agrega c4 )
transponer e 0  ( agrega cis4 )
transponer e 0  ( agrega d4 )
repetir 2 2   ( agrega c4 c4 )
repetir 1 2  ( agrega d4 d4 )
intercalar 1 0 ( agrega c4 d4 c4 d4 )
exit
```

##Programa

El programa (el binario) debe llamarse `composer`. Debe tomar dos argumentos: el
nombre de la canción y el número de bpms. Ej.,

    composer "motor psico" 105


Además, para facilitar la corrección y la reproducción (ver abajo), deben
permitir ejecutar el pograma agregando al final la opción `-concise`, que sólo
imprime el tiempo y el fragmento final. Por ejemplo, si escribimos la
composición de arriba como `ejemplo`, podemos ejecutar:

     cat ejemplo | ./bin/composer "basura" 100 -concise

Obteniendo el resultado:

     100 c4 d4 c4 d4

##Escuchando las composiciones

Para los curiosos, pueden escuchar sus creaciones utilizando los siguientes
programas:

    Lilypond
    Timidity

En ubuntu, por ejemplo, basta hacer:

    sudo apt-get install lilypond timidity -yes

Luego vamos a utilizar el programa bash `listen.sh` incluido con las consignas:

    cat ejemplo | ./bin/composer "motor psico" 105 -concise | ./listen.sh

##Consignas

1. Es inaceptable que un programa explote por que un usuario se ha equivocado en
algo. Manejen las excepciones, e impriman mensajes lindos. Por ejemplo, si el
usuario escribe `trasponer` en vez de `transponer`, impriman algo como `Comando
inexistente.` Lo mismo para las notas y los números.

1. Aunque OCaml admite el uso de estructuras mutables (punteros, arrays, mutable
records, y objetos), deben utilizar sólo su parte funcional (y las funciones de
input/output). Si realmente creen que es mejor utilizar punteros o arrays en
algún caso particular, pueden hacerlo si lo fundamentan bien en el
`README.md`. Pero nos guardamos el derecho a bajar nota lo mismo!

1. Lean la documentación de OCaml acerca de las listas, y eviten crear de nuevo
funciones que operen sobre las mismas que ya se encuentren disponibles. Casi
seguro que si están haciendo pattern matching con una lista, están repitiendo el
código de una función de librería.

1. Respetar la estructura de directorio indicada en clase: `bin` para
ejecutables, `src` para código, `Makefile`, `README.md`, y `INSTALL.md`.

1. Comentar en el `README.md` toda decisión de diseño que consideren importante
mencionar, y en el `INSTALL.md` cómo compilar y ejecutar el programa, y si
requieren alguna dependencia especial (como `core`).

1. Su programa debe compilar en el lab. Si por alguna razón no pueden cumplir
con este requerimiento (por ejemplo, utilizan funcionalidades que no se
encuentran en la versión del compilador del lab), aclaren esto en el
`INSTALL.md`.

##Características de la presentación

* Fecha de entrega: hasta el 21/04/2017 a las 23:59:59.999

* Deberán crear un tag indicando el release para corregir.

		git tag -a 1.0 -m 'the initial release'

* Si no está el tag no se corrige. Tampoco se consideran commits
  posteriores al tag.

##Recomendaciones

* Tómense el tiempo necesario para pensar la arquitectura del programa y diseñar
  los TADs antes de empezar a codificar.

* Diseñen pensando en reutilizar el código o las abstracciones cuando
  sea posible.

* Si un fragmento de código se repite frecuentemente, abstraiganlo
  mediante una función.

* `ocamlbuild` es una herramienta simple pero efectiva. Pero no tiene
  un parámetro `-o` como para decidir donde poner el ejecutable. De 
  esto se tendrán que ocupar ustedes.

* Sean consistentes con la nomenclatura. Tengan en cuenta que OCaml impone que
  los constructores y los módulos empiecen con mayúscula, y las funciones con
  minúscula.

* Documenten las funciones y las porciones de código que no sean intuitivas.

* No abusen de los comentarios en el código. Tampoco escatimen.

* Si la definición de una funcionalidad es ambigua, busquen clarificaciones
  antes de codificar basados en supuestos. Esto es responsabilidad de ustedes.
