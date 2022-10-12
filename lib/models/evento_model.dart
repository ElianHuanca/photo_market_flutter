// To parse this JSON data, do
//
//     final eventoModel = eventoModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class EventoModel {
    EventoModel({
      required this.id,
      required this.titulo,
      required this.descripcion,
      required this.fecha,
      required this.hora,
      required this.lugar,
      
    });

    int id;
    String titulo;
    String descripcion;
    DateTime fecha;
    String hora;
    String lugar;
    

    factory EventoModel.fromJson(String str) => EventoModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory EventoModel.fromMap(Map<String, dynamic> json) => EventoModel(
        id: json["id"],
        titulo: json["titulo"],
        descripcion: json["descripcion"],
        fecha: DateTime.parse(json["fecha"]),
        hora: json["hora"],
        lugar: json["lugar"],
        
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "titulo": titulo,
        "descripcion": descripcion,
        "fecha": "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
        "hora": hora,
        "lugar": lugar,
        
    };
    EventoModel copy() => EventoModel(
      id: id, 
      titulo: 
      titulo, 
      descripcion: descripcion, 
      fecha: fecha, 
      hora: hora, 
      lugar: lugar
    );
}
