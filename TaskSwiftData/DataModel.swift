//
//  DataModel.swift
//  TaskSwiftData
//
//  Created by Carlos Caño Gómez on 11/1/25.
//

import Foundation
import SwiftData

@Model // 1_Indica que esta clase es una entidad del modelo de datos en SwiftData.
// Modelo de SwiftData, muy simple de crear es solo una clase con final (final class)
final class Tareas {
    // Campos dentro del Modelo
    // En SwiftData cuando yo creo los campos, los campos son todos de tipo get y set porque funciona como variables calculadas para poder guardar y trabajar los datos por detrás y por ello los campos deben de ser var y no pueden ser let.
    @Attribute(.unique) var id: UUID // Id, con un atributo de que sea único (hay muchos mas tipos de atributos), automaticamente al ponerlo unico me va a crear una clave principal en la BD y un índice de búsqueda por ese ID.
    var nombre: String
    var descripcion: String
    var fecha: Date // puede ser útil para `ordenar` o `filtrar` tareas según su programación.
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
// `CaseIterable`, permite `iterar automáticamente` sobre todos sus valores, lo cual es útil para crear `listas desplegables o filtros` en la interfaz de usuario.
// `Codable`: la conformidad con Codable asegura que el valor del estado se puede `serializar/deserializar` fácilmente.
// `Identifiable`: la propiedad `id` de cada `caso enum` facilita su uso directo en `SwiftUI`, por ejemplo, en vistas como `listas o menús`.
enum EstadoTarea: String, Codable, CaseIterable, Identifiable {
    case pendiente = "Pendiente"
    case enProgreso = "En Progreso"
    case completada = "Completada"
    
    var id: Self { self }
}
