//
//  TaskSwiftDataApp.swift
//  TaskSwiftData
//
//  Created by Carlos Caño Gómez on 11/1/25.
//

import SwiftUI
import SwiftData // SwiftData

@main
struct TaskSwiftDataApp: App { // 1_Struct con el protocolo App
    // 3_Definir el contenedor de modelo compartido, es un elemento que es una clase
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([Tareas.self]) // esquema con las tablas de los datos que vamos a guardar
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false) // configuración de modelo, utilizando el esquema que nosotros hemos creado y diciendo que no se va a guardar en memoria (isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration]) // deovlvemos el contenedor con el esquema y la configuración (es un array porque puede haber varias configuraciones)
        } catch { // en caso de que halla un error no va a funcionar. Es decir la aplicación no va a funcionar si la BD no se crea correctamente (esto solo puede pasar si hay algo mal en la configuración).
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    //2_Su Scene, WindowGroup, ContentView()
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer) // Aqui tenemos declarado el contenedor de modelo compartido (3_) en la escena de esta manera estamos inyectando mi contenedor en la App para poder utilizarlo donde quiera y cuando quiera en toda la App.
        // El módelo compartido es un objeto que controla el esquema de la App y la configuración del almacenamiento del modelo.
        // El contenedor es el elemento principal donde yo voy a trabajar con este módelo compartido.

    }
}
