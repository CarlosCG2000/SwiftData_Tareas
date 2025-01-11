//
//  SampleData.swift
//  TaskSwiftData
//
//  Created by Carlos Caño Gómez on 11/1/25.
//

import SwiftUI
import SwiftData // SwiftData

// Necesitamos datos de prueba para inyectarselo al proyecto y poder trabajar con ello
struct SampleData: PreviewModifier { // 1_PreviewModifier, me permite (y obliga) a tener una propiedad Body con un Content y un Context (2_)
    
    static func makeSharedContext() async throws -> ModelContainer { //3_ es una funcion estatica donde se devuelve un ModelContainer de prueba, igual que se creo en el fichero TaskSwiftDataApp pero con tareas y guardandose en memoria en vez de la BD
        
        let schema = Schema([Tareas.self]) // esquema con las tablas de los datos que vamos a guardar
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true) // configuración de modelo, utilizando el esquema que nosotros hemos creado y diciendo que si se va a guardar en memoria (isStoredInMemoryOnly: true)
        
        let container = try ModelContainer(for: schema, configurations: [modelConfiguration]) // se crea el contenedor
        
        // Creamos las tareas por defecto
        let tarea1 = Tareas(id: UUID(),
                            nombre: "Realizar tareas de forma autodidacta",
                            descripcion: "Tarea con respecto a mejora y aprendizaje para prepararse al máster MIMO en la asignatura de iOS",
                            fecha: .now,
                            estado: .enProgreso)
        
        let tarea2 = Tareas(id: UUID(),
                            nombre: "Subir arreglos en GitHub",
                            descripcion: "Una vez termine el subirlo a un repositorio en GitHub para que lo vea el mundo que quiera en https://github.com/CarlosCG2000",
                            fecha: .now,
                            estado: .pendiente)
        
        // Insertamos en el contenedor (ModelContainer) las tareas
        container.mainContext.insert(tarea1)
        container.mainContext.insert(tarea2)

        return container
    }
    
    // 2_El context seria el elemento de la propia BD, es decir el tipo del ModelContainer que estoy utilizando.
    func body(content: Content, context: ModelContainer) -> some View {
        content.modelContainer(context)
    }
}

// Para poder usarlo de una manera sencilla, se puede hacer una extension de PreviewTrait, que tiene que estar fijada por generico a que solo funcione para 'Preview.ViewTraits'
extension PreviewTrait where T == Preview.ViewTraits {
    @MainActor static var sampleData: Self = .modifier(SampleData()) // Creamos un 'MainActor' paraque no de problema de vconcurrencia en Swift 6
}
