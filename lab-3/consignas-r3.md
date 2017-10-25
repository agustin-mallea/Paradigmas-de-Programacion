 La versión original del lab3 permitía que los trips sean creados (solamente) por los drivers y que si un pasajero ingresa origen-destino, se listen aquellos trips disponibles.

El extra que pedimos para recuperar implica tener en cuenta la ubicación actual del driver. Lo que pretendemos es que sean capaces de añadir tal información de modo que sea relevante para listar los trips según el origin que escoja el pasajero.

Para esto pueden optar por una de las siguientes opciones, cualquiera que elijan es válida por lo que si ya están encaminados en una, genial!:

Opción 1. Hacer la versión nueva, donde el conductor ya no crea los viajes sino que los crea la aplicación.
Ejemplo: Si un pasajero seleciona origin='Alta Córdoba', destination='Cerro', la aplicación va a buscar los drivers que tienen como su ubicación actual a la location 'Alta Córdoba'. Luego, el pasajero va a optar por algún conductor y se hará el trip como siempre...

Opción 2. Tener funcionando (bien) la versión original y agregar la restricción de solo mostrar los trips que creó el driver si su ubicación actual coincide con la del origin introducida por el pasajero).
Ejemplo: Si un pasajero seleciona origin='Alta Córdoba', destination='Cerro', la aplicación va a buscar los drivers que tienen como ubicacion actual la location 'Alta Córdoba' y que hayan creado el trip (Alta
Córdoba,Cerro) previamente.

Como ven, el último caso es igual que antes solo que se tienen en cuenta la ubicación actual del driver como una suerte de filtro. Y el primero elimina la función de creación de trips por parte de drivers dejando que la aplicación cree (y guarde) los trips que se van haciendo.
