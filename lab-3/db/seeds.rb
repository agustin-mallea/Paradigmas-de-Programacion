# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Location.destroy_all
Location.create!([{name: "Alta Córdoba", x_coordinate: 1, y_coordinate: 1},
	{name: "Patio Olmos", x_coordinate: -0.3, y_coordinate: -0.2},
	{name: "Plaza San Martín", x_coordinate: 0, y_coordinate: 0},
	{name: "Parque Sarmiento", x_coordinate: 1, y_coordinate: -1},
	{name: "Cerro de las Rosas", x_coordinate: -4, y_coordinate: 4},
	{name: "Aeropuerto", x_coordinate: 0, y_coordinate: 7},
	{name: "Terminal de Ómnibus", x_coordinate: 0, y_coordinate: 1}])
