Paradigmas de la Programación 2017 - Lab 2

# Programación Orientada a Objetos con Ruby

## El prototipo
El proyecto consiste en diseñar e implementar la estructura de objetos para un prototipo de una web-app tipo **Uber** o **Lyft**.
En este prototipo existen dos tipos de usuarios: los pasajeros (passenger) y los conductores (drivers). Un pasajero puede iniciar sesión y pedir un viaje a una ubicación X. El sistema entonces muestra una lista de posibles conductores que están lo suficientemente cerca para realizar el viaje y cuánto cobran por él. El pasajero puede entonces seleccionar el viaje que más le guste y esperar a que su conductor llegue a buscarlo.
Además de ello, para mejorar la usabilidad se agregan las siguientes características:

 - Los pasajeros pueden pagar los viajes desde la aplicación.
 - Los pasajeros pueden calificar a sus conductores con 1-5 estrellas.
 - Los conductores pueden consultar cuánto dinero han ganado hasta el momento y definir su tarifa por kilómetro.
 - Los pasajeros pueden acumular millas. Una determinada cantidad de millas se puede canjear por descuentos en viajes. (*)
 - Los pasajeros puede seguir la posición del conductor (track) una vez que han aceptado el viaje. (*)

## La implementación
Como punto de partida tienen un esqueleto de código con las funciones que manejan toda la parte de programación web. Su tarea es completar este código para lograr un prototipo funcional.
Como este es un laboratorio de programación orientada a objetos, **se evaluará y se pedirán justificaciones** orales sobre el diseño de clases. Tengan en cuenta también que están diseñando un prototipo: tienen que anticiparse a nuevos cambios y poder agregar fácilmente nuevas funciones que los usuarios requieran.

### Algunas simplificaciones

Para mantener simple nuestro prototipo, tomamos algunas decisiones de diseño que no son óptimas si estuvieramos implementando un producto real.

 - Guardamos los objetos (usuarios registrados y ubicaciones) en archivos json. De esta forma, no hay que preocuparse por configurar una base de datos.
 - Las ubicaciones serán simples strings predefinidos con nombres como “Parque Sarmiento” o “Alta Córdoba”. No se podrán cambiar desde la app.
 - No es necesario manejar los casos de uso con errores "elegantemente". Por ejemplo, si los mails ingresados no son válidos o los números de teléfono tienen letras. Tampoco estamos validando contraseñas.
 - Cada vez que un usuario pide ver los viajes disponibles, mostramos una lista aleatoria de viajes.

### El esqueleto

Se les provee con una implementación parcial del prototipo en donde están implementadas los POST y GET handlers, justo con la mayor parte de las vistas (html). El código está basado en el framework web [Sinatra](http://www.sinatrarb.com/), que permite crear webs con mínimas configuraciones. Es esqueleto se organiza en los siguientes archivos:

- `bin/` directorio que contiene el código Ruby.
    - `app.rb` archivo principal donde se encuentran los handlers.
- `static/` directorio que contiene los archivos estáticos que son servidos en cada consulta. En general esto incluye archivos .css, .js e imágenes.
- `views/` directorio que contiene los archivos .erb (Embedded RuBy). Estos archivos son plantillas html que, luego de ser llenadas por los handlers, son las respuestas a las llamadas GET y POST del cliente.
    - `layout.erb`  Los templates .erb soportan herencia, esto quiere decir, que podemos definir un solo archivo con todo el código común del sitio web y luego reemplazar partes por el contenido específico de cada página. En el esqueleto, este archivo es la plantilla con el código en común.
- `locations.json` archivo json con las ubicaciones predeterminadas.

La base de datos está emulada a través de archivos JSON y cuenta con funciones auxiliares agrupadas en la clase AppController. Esta clase provee una capa de abstracción sobre la forma en que se guarda la información que no depende de la sesión del usuario. Para cargar en memoria estos objetos, se utilizan los atributos de AppController:

- `drivers` y `passengers`: son hashes que almacenan usuarios indexados por el email del usuario.
- `locations`: es un hash indexado por el nombre del location.
- `users_by_id`: es un hash que almacena usuarios  indexado por el id del usuario.

Esta es una solamente una posible organización de la información, y puede ser alterada si encuentran una más conveniente. Sin embargo, se deben conservar métodos de acceso en tiempo constante para los usuarios a través del id y del email.

Para poder guardar objetos en JSON, deben convertirlos en hashes primero. Para eso, deben implementar las funciones `to_hash` y `from_hash` para cada clase de objeto que quieran guardar. Si usan la herencia inteligentemente pueden usar una sola implementación.

## Requerimientos

El laboratorio debe cumplir los siguientes requerimientos:

- Implementación:
    - No tiene que fallar con un error 500. Los 300/400 son aceptables, mientras que sean intencionales
    - Deben respetar el **encapsulamiento** de los atributos. Si dan permisos de escritura/lectura o hacen público un método, deben poder justificar por qué eso era necesario.
    - Tanto pasajeros como conductores deben estar identificados por un **id secuencial**.
- Estilo:
    - Estilo de código de acuerdo a las [convenciones de Ruby](https://github.com/bbatsov/ruby-style-guide).
    - El objetivo de clases, atributos y el output de métodos deben estar documentados en inglés. El estándar es [RDoc](http://rdoc.sourceforge.net/doc/index.html). No exageren tampoco, **good code is the best documentation**.
    - Deben respetar la estructura original del proyecto, agregando nuevos archivos en los directorios correspondientes.
- Entrega
    * Fecha de entrega: hasta el **19/05/2017** a las 23:59:59.999
    * Deberán crear un tag indicando el release para corregir.

        `git tag -a 1.0 -m 'the initial release'`

    * Si no está el tag no se corrige. Tampoco se consideran commits
  posteriores al tag.

## Recomendaciones y recursos

- Busquen en Google antes de implementar!
- Primero hagan funcionar la página principal, después sigan con register. No hagan todo y después traten de correrlo todo junto!
- El diseño de los objetos que elijan se verá reflejado en toda la aplicación. Por eso, deberán completar tanto archivos .rb como archivos .erb. Los .js y .css en general no deberían ser afectados.
- Tengan en cuenta que listas y hashes almacenan solamente referecias a objetos, evitando duplicación de información. Por ello, siempre es más conveniente mantener varios hashes de los objetos con distintos indices que realizar búsquedas lineales.
- Usen incluso las características más inusuales de la Programación Orientada a Objetos: métodos y atributos de clase, generalización de métodos en clases superiores, atributos protected, etc.
- El tipo de archivo erb es el mismo que se utiliza en Ruby on Rails, pueden encontrar más info en esa documentación.
- Pueden cambiar lo que quieran del esqueleto: el diseño, la estructura del sitio, etc., mientras mantengan las mismas funcionalidades.

Un poco de bibliografía

- Singleton Design Pattern
- [ERB templates](http://www.stuartellis.name/articles/erb/)
- [Model view controller design pattern](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller) Tener en cuenta que nosotros hacemos nuestra propia implementación de los modelos
- [Como user el atributo session en Sinatra](http://rubylearning.com/blog/2009/09/30/cookie-based-sessions-in-sinatra/)
- [Principios de la Programación Orientada a Objetos](https://scotch.io/bar-talk/s-o-l-i-d-the-first-five-principles-of-object-oriented-design) (algo avanzado)
- [Lecciones de Ruby en general](https://learnrubythehardway.org/book/)

## Puntos estrella

Recuerden que los puntos estrella son necesarios para recuperar los laboratorios y/o rendir libre la materia. Mientras más tiempo dejan pasar, más puntos estrella tendrán que implentar.

### 1 - Track your driver

Dificultad media

Implementar un nuevo feature en el cual el pasajero pueda saber a qué distancia está su conductor, o a qué distancia están del destino. Para ello, tendrán que simular que los conductores se muevan en el espacio.

### 2 - De driver a carrier

Dificultad alta

Implementar un nuevo tipo de viaje, donde se puedan enviar paquetes además de pasajeros. Los paquetes deberán tener tamaños y pesos, mientras que los conductores deberán agregar los límites de tamaño y tipo para los paquetes que trasladan.

### 3 - Sumá millas!

Dificultad baja

Implementar un sistema en donde los pasajeros puedan sumar millas por sus viajes y luego canjear estas millas por descuentos. Tener en cuenta que los descuentos son absorvidos por la empresa, y no por el conductor.


### 4 - Vamos por todo

Dificultad media

Completar la aplicación para que los viajes no sean aleatorios. Si un conductor está en un viaje, no saldrá en la lista de posibles viajes. Un viaje debe ser aceptado por el conductor antes de que el usuario reciba la confirmación. Tanto el usuario como el conductor deben dar por finalizado el viaje.

## Requirimientos para rendir en las fechas de Julio/Agosto 2017

Para rendir el laboratorio 2 en condición de regular, deben implementar **dos puntos estrella**, mientras que para rendir como libre
deberán implementar **tres puntos estrella**. Los requerimientos mínimos son:

- Punto estrella 1: La ubicacion del conductor y/o la distancia entre el conductor y el pasajero deben mostrarse al listar los viajes disponibles
y al seleccionar un viaje. Una vez seleccionado el viaje, si el usuario refresca la pantalla, debe mostrarse la ubicación actualizada.
La forma es que simulen el movimiento del conductor es libre.

- Punto estrella 2: Deben implementar todas las vistas necesarias para que la selección de viajes, el pago y la puntación sean similares,
agregando características que justifiquen la diferencia entre un carrier (alguien que lleva paquetes) y un driver (alguien que lleva pasajeros).

- Punto estrella 3: Las millas acumuladas deben ser mostradas en el perfil del pasajero, únicamente visible por el propio usuario. Al momento de pagar, se debe dar la
opcion de canjear las millas (todas o una parte) por un respectivo descuento. Si las millas son canjeadas, la diferencia entre el monto pagado y el costo real del viaje
la absorve la empresa.

- Punto estrella 4: Ver descripción arriba.

La evaluación será similar a la anterior, y es requisito indispensable que **todo funcione a la perfección**. Adicionalmente, se espera
que defiendan (con uñas y dientes) sus **decisiones de diseño de objetos**. Para esta entrega no es necesario que conserven la estética de la interfaz gráfica, pero para los puntos estrella 2 y 4 tendrán
que hacer modificaciones al código javascript.

> Written with [StackEdit](https://stackedit.io/).
