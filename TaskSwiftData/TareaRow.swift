//
//  TareaRow.swift
//  TaskSwiftData
//
//  Created by Carlos Caño Gómez on 11/1/25.
//

import SwiftUI

struct TareaRow: View {
    
    let tarea: Tareas // una tarea en especifico
        
    var body: some View {
        VStack(alignment: .leading) {
            Text(tarea.nombre) // nombre de la tarea
                .font(.headline)
            HStack {
                Text(tarea.fecha.formatted(date: .long, time: .omitted)) // la fecha formateada
                Spacer() // Unn espacio entre los dos textos
                Text(tarea.estado.rawValue) // Enum del estado
            }
            // Atributos del HStack...
            .font(.subheadline)
            .foregroundStyle(.secondary)
        }
    }
}
