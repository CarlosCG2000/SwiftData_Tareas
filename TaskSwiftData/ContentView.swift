//
//  ContentView.swift
//  TaskSwiftData
//
//  Created by Carlos Caño Gómez on 11/1/25.
//

import SwiftUI
import SwiftData // Para trabajar con la BD

struct ContentView: View {
    
    @Environment(\.modelContext) private var context
   
    @Query private var tareas: [Tareas] // 2_ @Query nos permite consultar la BD
    @State private var showAdd = false
    
    var body: some View {
        NavigationStack {
            VStack {
                
                if tareas.isEmpty {
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
                        showAdd.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $showAdd) {
            NewTareaView()
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
                    context.delete(tareas[i])
                }
            }
        }
    }
}

// 1_traits: .sampleData, para poder en Preview utilizar el contendor (ModelContainer) del fichero SampleData el cual contiene ya datos por defecto para probarlo, en vez de usar el de producción que estaría vacio
#Preview(traits: .sampleData) {
    ContentView()
}
