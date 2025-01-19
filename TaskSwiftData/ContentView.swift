//
//  ContentView.swift
//  TaskSwiftData
//
//  Created by Carlos Caño Gómez on 11/1/25.
//

import SwiftUI
import SwiftData // Para trabajar con la BD

struct ContentView: View {
    
    @Query private var tareas: [Tareas] // 2_ @Query nos permite consultar la BD
    
    @Environment(\.modelContext) private var context // Variable de entorno donde recogemos el valor de la BD, es decir modelContext, necesario para poder borrar las tareas qque queramos en este caso
   
    @State private var showAdd = false
    
    var body: some View {
        NavigationStack {
            VStack {
                
                if tareas.isEmpty { // Si no hay tareas que me salga esto en pantalla
                    ContentUnavailableView("No hay tareas",
                                           systemImage: "list.bullet.clipboard",
                                           description: Text("Aún no existen tareas en la app. Por favor, pulse el + arriba a la derecha para crear una nueva tarea."))
                    Spacer()
                } else {
                    main // variable de la vista secundaria
                }

            }
            // Atributos del VStack...
            .navigationTitle("Tareas")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showAdd.toggle() // para poner la variable showAdd a verdadero
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        // variable de estado $showAdd si es verdadero
        .fullScreenCover(isPresented: $showAdd) {
            NewTareaView() // navegar a la vista nueva tarea
        }
    }
    
    // Variable secundaria
    var main: some View {
        List {
            ForEach(tareas) { tarea in
                TareaRow(tarea: tarea) // se llama al fichero TareaRow que sera un componente de Vista al que se le debe de pasar la tarea
            }
            // Atributos del List...
            .onDelete { index in // borrar una Tarea de la lista
                for i in index {
                    context.delete(tareas[i]) // seleccionar la tarea a borrar a traves del modelContext
                }
            }
        }
    }
}

// 1_traits: .sampleData, para poder en Preview utilizar el contenedor (ModelContainer) del fichero 'SampleData' el cual contiene ya datos por defecto para probarlo, en vez de usar el de producción que estaría vacio
#Preview(traits: .sampleData) {
    ContentView()
}
