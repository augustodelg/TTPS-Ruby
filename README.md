# Diseño
 
En el diseño de la herramienta se busco generar una estructura donde cada parte tenga una función en específica. Esta estructura se entiende como:
 
```
lib
├── rn
│   ├── commands
│   │   ├── books.rb
│   │   ├── notes.rb
│   │   └── version.rb
│   ├── commands.rb
│   ├── helpers
│   │   ├── exporter.rb
│   │   ├── outputs.rb
│   │   ├── paths.rb
│   │   └── validator.rb
│   ├── helpers.rb
│   ├── models
│   │   ├── book.rb
│   │   └── note.rb
│   ├── models.rb
│   └── version.rb
└── rn.rb

```
Profundizando en cada parte de la estructura anterior podemos decir:
 
- **commands**: En esta sección se encuentra la logica utilizada para atender los comandos definidos, adicionalmente tiene asignada la tarea de filtrar que lo que indican los comandos para luego enviar a la parte capacitada que realice una determinada acción. Esto se hace para liberar a dicha parte de tener que procesar lo enviado a los comandos.
 
- **models**: Aquí podemos encontrar la lógica de los libros y las notas. Como se mencionó antes veremos que estas clases solo se encargan de lo indicado en sus métodos, tales como create, delete, list, etc. Cabe mencionar que las dos clases, son enriquecidas extendiendo de los módulos validator, tambien utilizan el modulo Paths, pero no extienden de él(Posteriormente explicaremos la función que cumplen  estos módulos).Estos son implementados para dejar centrado el comportamiento de los libros y notas.

    -  **note**: Encontraremos la logica para realizar el CRUD de las notas. Su implementación es una clase, que se instancia y se le asigna la información necesaria.

    -  **book**: Se aplica la misma idea que en Notas.

- **helpers**: Se podra encontrar todas las ayudas extras

    - **outputs**: Este módulo solo se encarga de imprimir lo que le indiquen. Se implementó para no dejar la lógica de mostrar los resultados, en las notas y libros. A la hora de querer mostrar algo en consola, estos utilizaran los methods Output para que muestre lo indicado.
    
    - **paths**: En el podremos encontrar la path base de la aplicacion, junto con la extension de los archivos manejados por la aplicacion. 

    - **validator**: En este módulo encontraremos la lógica de "verificaciones", ya que en él se encuentran los métodos para chequear los nombres ingresados.

    - **exporter**: Modulo dedicado a centrar la loca de exportar notas.
        ```
          Para exportar se utiliza la gema **redcarpet**, que toma texto con formato Markdown y lo trasforma en html.
          El exporter en una clase que se instancia y almacena una instancia de el conversor y el path donde se almacenara el export. El formato de la carpeta, es 'export - fecha actual + hora actual'
          La idea principal es que tanto el libros como las notas utilicen una instancia del exporter para realizar los exports deseados.
        ```

### Gemas
- **[Dry-cli](https://dry-rb.org/gems/dry-cli/0.6/)**: es una framework de proposito general, que nos permite desarrollar aplicaciones de Command Line Interface (CLI) .
- **[Tty-editor](https://github.com/piotrmurach/tty-editor)**: nos provee una forma fácil y sencilla de incorporar el uso de editores de texto a nuestra aplicacion resolviendo muchos inconvenientes que podrian aparecer.

### Información


- La herramienta cuenta con una carpeta base inicial, y dentro de la misma una carpeta llamada global. Estas en caso de no existir se autogeneraran.

- Los nombres tanto de libros como notas adminten **solamente** letras y numeros.

- Al utilizar el metodo edit de las notas, se utilizara el editor **nano**. Una guia de como utilizar nano.   **[GUIA](https://www.comoinstalarlinux.com/como-usar-el-editor-nano-linux/2/)  - [Video](https://www.youtube.com/watch?v=RlPmmdcLe8g)**



# rn

Plantilla para comenzar con el Trabajo Práctico Integrador de la cursada 2020 de la materia
Taller de Tecnologías de Producción de Software - Opción Ruby, de la Facultad de Informática
de la Universidad Nacional de La Plata.

Ruby Notes, o simplemente `rn`, es un gestor de notas concebido como un clon simplificado
de la excelente herramienta [TomBoy](https://wiki.gnome.org/Apps/Tomboy).

Este proyecto es simplemente una plantilla para comenzar a implementar la herramienta e
intenta proveer un punto de partida para el desarrollo, simplificando el _bootstrap_ del
proyecto que puede ser una tarea que consume mucho tiempo y conlleva la toma de algunas
decisiones que pueden tener efectos tanto positivos como negativos en el proyecto.

## Uso de `rn`

Para ejecutar el comando principal de la herramienta se utiliza el script `bin/rn`, el cual
puede correrse de las siguientes manera:

```bash
$ ruby bin/rn [args]
```

O bien:

```bash
$ bundle exec bin/rn [args]
```

O simplemente:

```bash
$ bin/rn [args]
```

Si se agrega el directorio `bin/` del proyecto a la variable de ambiente `PATH` de la shell,
el comando puede utilizarse sin prefijar `bin/`:

```bash
# Esto debe ejecutarse estando ubicad@ en el directorio raiz del proyecto, una única vez
# por sesión de la shell
$ export PATH="$(pwd)/bin:$PATH"
$ rn [args]
```

> Notá que para la ejecución de la herramienta, es necesario tener una versión reciente de
> Ruby (2.5 o posterior) y tener instaladas sus dependencias, las cuales se manejan con
> Bundler. Para más información sobre la instalación de las dependencias, consultar la
> siguiente sección ("Desarrollo").

Documentar el uso para usuarios finales de la herramienta queda fuera del alcance de esta
plantilla y **se deja como una tarea para que realices en tu entrega**, pisando el contenido
de este archivo `README.md` o bien en uno nuevo. Ese archivo deberá contener cualquier
documentación necesaria para entender el funcionamiento y uso de la herramienta que hayas
implementado, junto con cualquier decisión de diseño del modelo de datos que consideres
necesario documentar.

## Desarrollo

Esta sección provee algunos tips para el desarrollo de tu entrega a partir de esta
plantilla.

### Instalación de dependencias

Este proyecto utiliza Bundler para manejar sus dependencias. Si aún no sabés qué es eso
o cómo usarlo, no te preocupes: ¡lo vamos a ver en breve en la materia! Mientras tanto,
todo lo que necesitás saber es que Bundler se encarga de instalar las dependencias ("gemas")
que tu proyecto tenga declaradas en su archivo `Gemfile` al ejecutar el siguiente comando:

```bash
$ bundle install
```

> Nota: Bundler debería estar disponible en tu instalación de Ruby, pero si por algún
> motivo al intentar ejecutar el comando `bundle` obtenés un error indicando que no se
> encuentra el comando, podés instalarlo mediante el siguiente comando:
>
> ```bash
> $ gem install bundler
> ```

Una vez que la instalación de las dependencias sea exitosa (esto deberías hacerlo solamente
cuando estés comenzando con la utilización del proyecto), podés comenzar a probar la
herramienta y a desarrollar tu entrega.

### Estructura de la plantilla

El proyecto te provee una estructura inicial en la cual podés basarte para implementar tu
entrega. Esta estructura no es necesariamente rígida, pero tené en cuenta que modificarla
puede requerir algún trabajo adicional de tu parte.

* `lib/`: directorio que contiene todas las clases del modelo y de soporte para la ejecución
  del programa `bin/rn`.
  * `lib/rn.rb` es la declaración del namespace `RN`, y las directivas de carga de clases
    o módulos que estén contenidos directamente por éste (`autoload`).
  * `lib/rn/` es el directorio que representa el namespace `RN`. Notá la convención de que
    el uso de un módulo como namespace se refleja en la estructura de archivos del proyecto
    como un directorio con el mismo nombre que el archivo `.rb` que define el módulo, pero
    sin la terminación `.rb`. Dentro de este directorio se ubicarán los elementos del
    proyecto que estén bajo el namespace `RN` - que, también por convención y para facilitar
    la organización, deberían ser todos. Es en este directorio donde deberías ubicar tus
    clases de modelo, módulos, clases de soporte, etc. Tené en cuenta que para que todo
    funcione correctamente, seguramente debas agregar nuevas directivas de carga en la
    definición del namespace `RN` (o dónde corresponda, según tus decisiones de diseño).
  * `lib/rn/commands.rb` y `lib/rn/commands/*.rb` son las definiciones de comandos de
    `dry-cli` que se utilizarán. En estos archivos es donde comenzarás a realizar la
    implementación de las operaciones en sí, que en esta plantilla están provistas como
    simples disparadores.
  * `lib/rn/version.rb` define la versión de la herramienta, utilizando [SemVer](https://semver.org/lang/es/).
* `bin/`: directorio donde reside cualquier archivo ejecutable, siendo el más notorio `rn`
  que se utiliza como punto de entrada para el uso de la herramienta.
