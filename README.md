# Información
Aplicacion de notas desarrollada con **Ruby on rails**
La app consiste en ofrecer a los usuarios la posibilidad de gestionar sus libros y notas, estas ultimas dispondran de la posibilidad de inluir texto rico e imagenes.

# Instrucciones de uso
### Requisitos
```
ruby version >= 2.7
ruby on rails >= 6
yarn 
nodejs
SQLite3

```
1. Clonar el proyecto `git clone https://github.com/augustodelg/TTPS-Ruby.git`
2. Ejecutar el siguiente comando: `bundle install && bundle exec rails db:create && bundle exec rails db:migrate && yarn install --check-files && rails s`
3. Ingresar a `127.0.0.1:3000` y crearse un usuario

# Diseño
Una vista general del modelo de la apliacacion seria:
![Model](https://i.imgur.com/XauBycd.png)

Vemos que los usuarios tiene 1 o más libros, ya que los usuarios poseen un libro por defecto, el libro **Global** (el cual no es posible editar el nombre ni eliminar).

Si vamos del lado del **libro** vemos que solo pertenece a un unico usuario y que tiene 0 o más notas. El nombre de los libros es unico, pero relativo a cada usuario, en otras palabras pueden existir en el sistema libros con el mismo nombre pero no al mismo usuario.

En cuanto a las **notas** vemos que solo pertenecen a un unico libro y tiene un unico "**rich text**", el cual es generado por la gema ActioText utilizada para gestionar el contenido de una nota. El titulo de la nota sigue la misma logia aplicada al nombre de los libros, salvo que el titulo es unico respecto al libro.

# Interfaz de usuario
Una vez creado e iniciado sesión veremos una sidebar donde se dispondran las distintas vistas principales:
 - Books: donde se dispone el crud de todos los libros del usuario actual.
 - Notes: donde se dispone el crud de las notas de todos del usuario actual.
 - Profile: para editar poder informacion del usuario actual.
 - Log out: para cerrar sesión.
 
Como pantalla principal por defecto tenemos el crud de libros.

### ¿Como crear una nueva nota?
Partiendo desde la vista del crud de libros:
1. Clickear en el boton "+ new note" del libro al cual se desee agregar una nota.
2. Ingresar el titulo y escribir el contenido de la nota.

### ¿Como ver las notas creadas?
Tenemos dos opciones:
1. Ver todas las notas del usuario.

        - Clickeamos en la opcion "notes" del sidebar.  
2. Ver las notas de un libro en especifico.

        - Clickeamos en el boton "notes" del libro en especifico.
  
# Gemas utilizadas (aparte del rails)
Para el desarrollo del proyecto se utilizo:
- [Action Text](https://edgeguides.rubyonrails.org/action_text_overview.html): Gestion del contenido en texto rico de las notas.
- [Grover](https://github.com/Studiosity/grover): Descarga en pdf de las notas. 
- [rack-cors](https://rubygems.org/gems/rack-cors/versions/0.4.0): Aplicacion de corns a la app.