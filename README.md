
# MI PARTE
Vamos a usar SwifData para generar una aplicaicón de tareas.

SwifData es muy distinto cuando lo utilizamos como elemento principal en una aplicación a todo lo que hemos visto con coasa que tiene que ver con Clean Arquitecture, MVVM, repositorios, etc.
Esta organización de la aplicación va a ser distinta a lo que suele ser, por ejemplo diferente a la anterior clase (el proyecto `1_App_Arqui_Json`, en mi repositorio GitHub `CleanArchi_Testing`).

Lo haremos con Swift 6 en concurrencia estricta.

Tenemos que tener en cuenta que Swift funciona en `MVVM`, si quieres otra arquitectura vas a tener que poner una capa por encima de esta. El profesor cuando trabaja suele poner la capa de `Clean Arquitecture` porque al final es la que mejor se adapta a todo el elemento, pero si tu quieres aplicar cualquier otra arquitectura o patrón de arquitectura tendrás que adaptarlo para que funcione sobre el patrón MVVM basado hasta `iOS 17 @Observable` y desde `iOS 16 o anterior @Observable Object`. Hagas lo que hagas, montes lo que montes o pones un VM con `@Observable` o `@Observable Object` o la app no va a funcionar. A partir de hay si entiendes bien como funciona el framework puedes adaptarte a cualquier arquitectura que para ti sea más cómoda. Porque lo que no se puede hacer es pensar que los patrones arquitectulares son como la biblia y si no la cumplimos con las arquitecturas que Apple desea va a venir Jobs a matarnos 😸.

¿Patrón factory para inyectar las dependencias? No, en SwiftUI la la inyección de dependencias de hace de manera nativa.
Hay que entender una cosa en programación cada lenguaje o framework es un mundo y si intentamos aplicar las reglas de otros lenguajes en Swift no va a funcionar. El patrón factory no sirve, ¿lo puedes hacer? Si,¿pero es util? No. Es absurdo porque en SwiftUI la inyección de dependencias dse hace a través de los propios `Struct` cuando defines una propiedad en un 'Struct' y no la inicalizas, el inicializador te pide que lo inyectes y ya esta, sin necesidad de poner patrón que significaria poner capas sobre capas sobre capas...

Empezamos el proyecto:
Al crear el proyecto tenemos que seleccionar en 'Storage: SwiftData (en vez de None ó CoreData)'
Al eligir SwiftData, va a crear una plantilla con una pantalla ya prehecha con una serie de elementos para tener una funcionalidad básica.
Una vez creado el proyecto para ver la versión de Swift que tenemos vamos al archivo principal (que es el ejecutable) lo pulsamos y vamos a 'Build Settings' y en la parte de abajo sale el 'Swift Compiler Language' con la versión (en mi caso Swift 6). Tambien se pueden ver otras configuraciones en ese 'Build Settings'.

1. Fichero ya existente `TaskSwiftDataApp`:
SwiftData tiene dos partes fundamentales:
- El contenedor que es donde yo almaceno la información en disco (es el elemento a más alto nivel que hay que definir).
- Un contexto que es el que va a permitir insertar información, borrarla, etc. Es como la zona intermedia que tienen las BD donde tu puedes insertas, borras, etc y hasta que no haces el commit no se inserta en el almacenamiento real o se rechaza.

En este fichero vamos a definir un contenedor de modelo compartido.
+ El módelo compartido es un objeto que controla el esquema de la App y la configuración del almacenamiento del modelo.
+ El contenedor es el elemento principal donde yo voy a trabajar con este módelo compartido.

Aqui tenemos declarado el contenedor de modelo compartido en la escena dle fichero de esta manera estamos inyectando el contenedor en la App para poder utlizarlo donde quiera y cuando quiera en toda la App.

2. Fichero `DataModel`.





3. Fichero ya existente `ContentView` y lo borramos y lo reharemos desde 0.



# 📝 SwiftData Tasks App - Ejemplo en SwiftUI

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

Esta masterclass es una muestra de cómo son las formaciones de [AC Academy](https://acoding.academy), en especial para la formación Swift Developer Program 2024 que incluirá este contenido y mucho más, más pausado, más explicado y con todo detalle en sesiones de trabajo en directo.

Descubre toda la información del [Swift Developer Program 2024](https://acoding.academy/sdp24) y apúntate. Comenzamos en octubre.

📺 **Enlace a la masterclass**: [Ver en YouTube](https://youtube.com/live/TNrqH-sm4q4)

## 🚀 ¿Cómo Empezar?

1. Clona este repositorio:
   ```bash
   git clone https://github.com/tu-repo/swiftdata-tasks-app.git
   ```
2. Abre el proyecto en **Xcode 16**.
3. Ejecuta la app en un simulador o dispositivo real.
4. ¡Empieza a crear y gestionar tus tareas! 🎉

## 🤝 Contribuciones

Este repositorio es **abierto** y **gratuito**, propiedad de **AC Academy SLU**, y está diseñado para ser una referencia educativa. Si deseas contribuir al proyecto o mejorar alguna funcionalidad, no dudes en hacer un fork y enviar un **Pull Request**.

## 📢 Sobre AC Academy SLU

Este proyecto es parte de **AC Academy SLU**, una sociedad limitada unipersonal que forma parte de la **Apple Consultant Network (ACN)**. Nos especializamos en brindar soporte a empresas en el ámbito de la **educación** y el **desarrollo en entornos Apple**.

- 🌐 **Sitio web**: [Apple Coding Academy](https://acoding.academy)
- 🎓 **YouTube**: [youtube.com/@applecoding](https://youtube.com/@applecoding)
- 🎥 **Twitch**: [twitch.tv/applecoding](https://twitch.tv/applecoding)

## ⚖️ Licencia

Este proyecto está licenciado bajo la licencia **MIT**, lo que significa que puedes usar, modificar y distribuir el código con total libertad, siempre y cuando incluyas los créditos correspondientes.

---
¡Gracias por tu interés y esperamos que disfrutes aprendiendo con este ejemplo! 🚀
