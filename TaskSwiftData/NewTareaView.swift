//
//  NewTareaView.swift
//  TaskSwiftData
//
//  Created by Carlos Caño Gómez on 11/1/25.
//

import SwiftUI

// Vamos a invocar para crear nuevos registros. Necesitamos el context porque me vas a permitir insertar en la BD.
struct NewTareaView: View {

    //2_Creamos variables de entorno:
    @Environment(\.dismiss) private var dismiss // nos permite quitar la pantalla cuando ya no nos interese utilizarla
    @Environment(\.modelContext) private var context // recogemos el valor de la BD, es decir modelContext
    
    // Datos para el formulario (esto tendria que estar en un View Model, etc pero lo hacemos aqui de forma rapida)
    @State private var nombre: String = ""
    @State private var descripcion: String = ""
    @State private var fecha: Date = Date()
    @State private var estado: EstadoTarea = .pendiente
    
    var body: some View {
        NavigationStack {
            Form { //El formulario 
                
                VStack(alignment: .leading) {
                    Text("Nombre de la tarea")
                        .font(.headline)
                        .padding(.leading, 5)
                    TextField("Ingrese el nombre de la tarea", text: $nombre) // TextField (input text)
                }
                
                VStack(alignment: .leading) {
                    Text("Descripción de la tarea")
                        .font(.headline)
                        .padding(.leading, 5)
                    TextField("Ingrese la descripción de la tarea", text: $descripcion) // TextField (input text)
                }
                
                DatePicker(selection: $fecha, displayedComponents: .date) { // DatePicker (fecha)
                    Text("Fecha de la tarea")
                }
                
                Picker(selection: $estado) {    // Picker (desplegable)
                    ForEach(EstadoTarea.allCases) { tarea in
                        Text(tarea.rawValue) // cuidado hay que poner '.rawValue'
                    }
                } label: {
                    Text("Seleccione estado")
                }
            }
            // Atributos del Form...
            .textFieldStyle(.roundedBorder)
            .navigationTitle("Nueva Tarea")
            .toolbar {
                
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        // Se crea la nueva tarea
                        let newTarea = Tareas(id: UUID(),
                                              nombre: nombre,
                                              descripcion: descripcion,
                                              fecha: fecha,
                                              estado: estado)
                        context.insert(newTarea) //  variable de entorno añadimos al BD

                        dismiss() // variable de entorno para salir de la pantalla
                    } label: {
                        Text("Crear")
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss() // variable de entorno para salir de la pantalla
                    } label: {
                        Text("Cancelar")
                    }
                }
                
            }
        }
    }
}

// 1_inyectamos el (traits: .sampleData) en la Preview.
#Preview(traits: .sampleData) {
    NewTareaView()
}
