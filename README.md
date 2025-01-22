
### CRÉDITOS a `Apple Coding Academy`: https://github.com/applecodingacademy
## EXPLICACIÓN POR MI DEL PROYECTO
Vamos a usar SwifData para generar una aplicación de tareas.

`SwifData` es muy distinto cuando lo utilizamos como elemento principal en una aplicación a todo lo que hemos visto con cosa que tiene que ver con `Clean Arquitecture`, `MVVM`, repositorios, etc.
Esta organización de la aplicación va a ser distinta a lo que suele ser, por ejemplo diferente a la anterior clase (el proyecto `1_App_Arqui_Json`, en mi repositorio GitHub `CleanArchi_Testing`).

`SwiftData` es una nueva `API de persistencia` de datos introducida por Apple en WWDC `2023`. Es una alternativa moderna a Core Data, diseñada para simplificar el manejo y almacenamiento de datos en aplicaciones desarrolladas en Swift. SwiftData integra los principios de diseño declarativos de `SwiftUI`, lo que la hace más intuitiva, legible y fácil de usar en comparación con `Core Data`.

Características principales de SwiftData
1. `Modelo de datos simplificado`:
	• En SwiftData, los modelos de datos se crean utilizando clases o estructuras de Swift con el atributo `@Model`. Esto elimina la necesidad de manejar archivos `.xcdatamodeld` como en `Core Data`.

2. `Persistencia automática`:
	• SwiftData maneja automáticamente el `ciclo de vida de los datos`, incluidos guardar, leer, actualizar y eliminar, de forma transparente.

3. Totalmente `integrado` con `Swift` y `SwiftUI`:
	• Compatible con paradigmas `declarativos`.
	• Ofrece `soporte nativo` para trabajar con vistas en `SwiftUI`.

4. `Menor configuración`:
	• Configurar y utilizar `SwiftData` es mucho más `rápido y directo` en comparación con `Core Data`.

5. Consulta de datos `eficiente`:
	• Incluye capacidades para realizar consultas sobre el modelo de datos con `menos esfuerzo y más expresividad`.

| **Aspecto**          | **SwiftData**                        | **Core Data**                          |
|-----------------------|---------------------------------------|-----------------------------------------|
| **Modelo de datos**   | Declarado con `@Model` en Swift      | Necesita un archivo `.xcdatamodeld`    |
| **Configuración**     | Sencilla y automática                | Requiere configuración manual compleja |
| **Integración**       | Diseñado para Swift y SwiftUI        | Compatible con UIKit y SwiftUI         |
| **Sintaxis**          | Declarativa                          | Imperativa                             |
| **Actualizaciones**   | Reactivas con `@Query`               | Necesita notificaciones manuales       |

Lo haremos con `Swift 6` en `concurrencia estricta`.

Tenemos que tener en cuenta que Swift funciona en `MVVM`, si quieres otra arquitectura vas a tener que poner una capa por encima de esta. El profesor cuando trabaja suele poner la capa de `Clean Arquitecture` porque al final es la que mejor se adapta a todo el elemento, pero si tu quieres aplicar cualquier otra arquitectura o patrón de arquitectura tendrás que adaptarlo para que funcione sobre el patrón MVVM basado hasta `iOS 17 @Observable` y desde `iOS 16 o anterior @Observable Object`. Hagas lo que hagas, montes lo que montes o pones un VM con `@Observable` o `@Observable Object` o la app no va a funcionar. A partir de hay si entiendes bien como funciona el framework puedes adaptarte a cualquier arquitectura que para ti sea más cómoda. Porque lo que no se puede hacer es pensar que los patrones arquitectulares son como la biblia y si no la cumplimos con las arquitecturas que Apple desea va a venir Jobs a matarnos 😸.

`¿Patrón factory para inyectar las dependencias?`: `No`, en SwiftUI la la `inyección de dependencias` de hace de manera `nativa`.
Hay que entender una cosa en programación cada lenguaje o framework es un mundo y si intentamos aplicar las reglas de otros lenguajes en Swift no va a funcionar. El `patrón factory` no sirve, ¿lo puedes hacer? Si, ¿pero es util? No. Es absurdo porque en SwiftUI la inyección de dependencias se hace a través de los propios `Struct` cuando defines una propiedad en un `Struct` y no la inicializas, el inicializador te pide que lo inyectes y ya esta, sin necesidad de poner patrón que significaria poner capas sobre capas sobre capas...

Empezamos el proyecto:
Al crear el proyecto tenemos que seleccionar en `Storage: SwiftData (en vez de None ó CoreData)`
Al eligir `SwiftData`, va a crear una `plantilla` con una pantalla ya prehecha con una serie de elementos para tener una funcionalidad básica.
Una vez creado el proyecto para ver la versión de Swift que tenemos vamos al `archivo principal` (que es el `ejecutable`) lo pulsamos y vamos a `Build Settings` y en la parte de abajo sale el `Swift Compiler Language` con la versión (en mi caso Swift 6). Tambien se pueden ver otras configuraciones en ese `Build Settings`.

1. Fichero que ya existente `TaskSwiftDataApp`.

SwiftData tiene `dos partes` fundamentales:
- 1. El `contenedor` que es donde yo `almaceno` la información en `disco` (es el elemento a más alto nivel que hay que definir).

- 2. Un `contexto` que es el que va a permitir `insertar` información, `borrarla`, etc. Es como la `zona intermedia` que tienen las `BD` donde tu puedes insertas, borras, etc y hasta que no haces `el commit` no se inserta en el almacenamiento real o se rechaza.

En este fichero vamos a definir un contenedor de `modelo compartido`.

+ El `módelo compartido` es un objeto que controla el esquema de la App y la configuración del almacenamiento del modelo.

+ El `contenedor` es el `elemento principal` donde yo voy a trabajar con este `módelo compartido`.

Aqui tenemos declarado el contenedor de `modelo compartido` en la escena del fichero de esta manera estamos inyectando `el contenedor` en la App para poder utilizarlo donde quiera y cuando quiera en toda la App.

2. Fichero nuevo `DataModel`.

Con el modelo de SwiftData de `Tarea` (formado por sus `campos` y un `constructor`).

3. Fichero nuevo `SampleData` dentro de la carpeta `Preview Content`.

Nuestra app la queremos de momento  a `0`, es decir que empiece `sin datos` y que espere que el usuario los vaya creando. Pero claro para trabajar eso es un problema por ello necesitamos` datos de prueba`. Entonces tendre que generar un elemento de prueba para que me genere la información y esto se realiza en este fichero.

Necesitamos `datos de prueba` para inyectarselo al proyecto y poder trabajar con ello sobretodo cuando esto en la `Preview`.
Se va a crear un `ModelContainer` de prueba, igual que se creo en el fichero 1_`TaskSwiftDataApp`, pero aqui se van a registrar elementos de Tareas de manera por defecto de prueba en memoria a diferencia que en el fichero 1_`TaskSwiftDataApp` que va a estar vacio y no se va a guardar en memoria sino en la BD porque va a ser el de producción y no el del Preview de pruebas (que es el de este fichero).

4. Fichero que ya existente `ContentView` y lo borramos y lo reharemos desde 0.
Llamamos en el `Preview` a `traits: .sampleData`, para poder en Preview utilizar el contenedor `ModelContainer` del fichero `SampleData` el cual contiene ya datos por defecto para probarlo, en vez de usar el de producción que estaría vacio.

Se llama a la BD para poder consultar las `Tareas` y poder mostrarlas en la vista (llamando a otras vistas secundarias, cuando es necesario).
Tambien en una `Toolbar` se crea un botón para navegar a la vista con el formulario para crear una nueva tarea.

5. Fichero nuevo `TareaRow`
La que estamos haciendo es componentizar el `ContentView` para que tenga aquí el aspecto de elemento de la tarea del listado que luego se llaman en el `ContentView`.

[
Si primero creamos todo en `ContentView` para extraerlo automaticamente y crear el `TareaRow` podemos hacer:
`Botón derecho sobre el elemento --> Refactor --> Extract Subview`: esto lo que hace es un `Struct` separado y la llama todo dentro de ese mismo fichero.
Ahora cortamos ese `Struct` nuevo que se ha generado y pulsamos el boton derecho en el fichero (parte izquierda, estan todos los ficheros) de `ContentView` y pulsamos `New 'Nombre_Struct.swift' from Clipboard` y ya crea el fichero directamente, donde no olvidar importar las cosas que necesitemos en este caso `import SwiftUI`.
]

6. Fichero nuevo `NewTareaView`
Vamos a invocar para `crear nuevos registros`. Lo que tenemos que hacer es recuperar el contexto. Lo primero inyectamos el `(traits: .sampleData)` en la `Preview`, para tener acceso al contexto de prueba, en la `Preview`. Luego creamos variables de entorno para obtener el valor de la BD, es decir `modelContext`. Necesitamos el `context` porque me vas a permitir insertar en la BD.

Parte de lo que hacemos aqui deberia estar en un `VM (View Model)` pero para hacerlo más rapido lo realizamos aqui dentro. Tambien se podria añadir validaciones, etc.
Creamos el formulario con sus items necesarios.

# 📝 SwiftData Tasks App - Ejemplo en SwiftUI (de Apple Coding Academy)

¡Bienvenido al repositorio de ejemplo sobre cómo trabajar con **SwiftData** en **Xcode 16** utilizando **Swift 6** y **SwiftUI**! 🎉 Este proyecto contiene una pequeña aplicación de tareas que ejemplifica el uso básico de **SwiftData**, un potente framework para gestionar bases de datos en las apps de Apple.

## 📋 Descripción del Proyecto

Este proyecto es una **aplicación simple de tareas** que demuestra el funcionamiento de **SwiftData** mediante una **única tabla de tareas**. La app incluye las siguientes características:

- ✅ **Modelo de datos** creado con SwiftData.
- 📦 **Contenedor y contexto** de datos implementados para gestionar las tareas.
- 👁️ **Interfaz de usuario** en **SwiftUI** que permite visualizar las tareas creadas.
- 🆕 **Mensaje informativo** cuando no hay tareas, mostrando cómo empezar.
- ✍️ Funcionalidad para **crear nuevas tareas**.
- 🗑️ Posibilidad de **eliminar tareas** ya existentes.
- 🎨 **Preview avanzada** usando la nueva funcionalidad de **PreviewProvider** de iOS 18, con inyección de datos de prueba para facilitar el desarrollo.

## 🛠️ Tecnologías Utilizadas

- **Xcode 16** 🛠️
- **Swift 6** 🐦
- **SwiftUI** 🚀
- **SwiftData** 💾
- **iOS 18** 📱

## 🎓 Masterclass: Creando una App de Tareas

Este proyecto forma parte de la masterclass **"Creando una app de tareas con SwiftData, SwiftUI y Swift 6"**, disponible de forma gratuita en el canal de **Apple Coding** en **YouTube**. En esta masterclass aprenderás paso a paso cómo construir esta aplicación, así como entender los conceptos fundamentales para trabajar con **SwiftData** y **SwiftUI**.
