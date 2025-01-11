//
//  DataModel.swift
//  TaskSwiftData
//
//  Created by Carlos Caño Gómez on 11/1/25.
//

import Foundation
import SwiftData

@Model // para que sea una tabla de SwiftData
// Modelo de SwiftData, muy simple de crear es solo una clase con final (final class)
final class Tareas {
    // Campos dentro del Modelo
    // En SwiftData cuando yo creo los campos, los campos son todos de tipo get y set porque funciona como variables calculadas para poder guardar y trabajar los datos por detrás y por ello los campos deben de ser var y no pueden ser let.
    @Attribute(.unique) var id: UUID // Id, con un atributo de que sea único (hay muchos mas tipos de atributos), automaticamente al ponerlo unico me va acrear una clave principal en la BD y un índice de búsqueda por ese ID.
    var nombre: String
    var descripcion: String
    var fecha: Date
    var estado: EstadoTarea // es un tipo enumeración que hay que definir
    
    // Inicializador (constructor)
    init(id: UUID, nombre: String, descripcion: String, fecha: Date, estado: EstadoTarea) {
        self.id = id
        self.nombre = nombre
        self.descripcion = descripcion
        self.fecha = fecha
        self.estado = estado
    }
}

// Enumeración para un campo del Modelo de SwiftData de Tareas
// La enumeración tiene que ser de tipo Codable para ser utilizada en SwiftData para que pueda tner una equivalencia
enum EstadoTarea: String, Codable, CaseIterable, Identifiable {
    case pendiente = "Pendiente"
    case enProgreso = "En Progreso"
    case completada = "Completada"
    
    var id: Self { self }
}
