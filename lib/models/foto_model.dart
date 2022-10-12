// To parse this JSON data, do
//
//     final fotoModel = fotoModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class FotoModel {
    FotoModel({
        required this.id,
        required this.url,
        required this.precio,
        required this.idEvento,
        required this.idUser,
        required this.comprado,
    });

    int id;
    String url;
    int precio;
    int idEvento;
    int idUser;
    int comprado;

    factory FotoModel.fromJson(String str) => FotoModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory FotoModel.fromMap(Map<String, dynamic> json) => FotoModel(
        id: json["id"],
        url: json["url"],
        precio: json["precio"],
        idEvento: json["idEvento"],
        idUser: json["idUser"],
        comprado: json["comprado"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "url": url,
        "precio": precio,
        "idEvento": idEvento,
        "idUser": idUser,
        "comprado": comprado,
    };
}
