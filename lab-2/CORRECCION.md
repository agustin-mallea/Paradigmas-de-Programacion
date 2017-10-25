# Corrección
Tag o commit corregido: 2.0

# Nota: 5,92

## Entrega  90%
- Los modelos deberían haber estado en la carpeta bin

## Funcionalidad    70%
- Cuando un passenger paga, no se descuenta el monto de su balance.
- Listan la cantidad de puntuaciones que tiene el usuario en lugar de mostrar el puntaje promedio. Revisen como implementaron la funcion get_rating


## Modularización   60%
- Agregaron un atributo de “tipo”, podrían haber usado la clase del objeto para distinguir entre pasajeros y drivers. Además, si desde llaman a Driver.from_hash, self va a ser la clase Driver, no la clase User, a pesar de que la función from_hash esté definida originalmente en User y después heredada por Driver.
- Para qué definen initialize con parametros nil y después usan un constructor?
- El objeto Location debería haber sido el encargado de calcular la distancia entre dos locations, ya que está íntimamente relacionado con la representación interna del Location.


## Calidad de código    20%
- Mezclan espacios con tabs
- Lineas de más de 80 caracteres
- En load_users, primero llaman a Passenger.new y después reasignan la variable haciendo Passenger.from_hash. Además de ello, comprueban dos veces si es un driver o un passenger.
- Cuando comprueban si el email ya está registrado, vuelven a recorrer la lista de usuarios siendo que tienen un hash que les provee búsqueda de acceso constante sobre todos los email registrados.
- TIP: El flujo de ejecución del código es algunas veces demasiado complicado. Traten de pensarlo más simple, con menos variables auxiliares.
- Están buscando los valores en un hash ITERANDO sobre todos los pares clave-valor.

