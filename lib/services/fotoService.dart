// ignore_for_file: file_names

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:photo_market/const/const.dart';
import 'package:photo_market/models/models.dart';

class PhotoService {
  static late FotoModel selectFoto;
  static Future<List<FotoModel>> getPhotos(idUser, idEvento) async {
    List<FotoModel> listaFotos = [];
    var response =
        await http.get(Uri.parse('$baseUrl/getFotosCliente/$idUser/$idEvento'));
    var jsonResponse = convert.jsonDecode(response.body);
    for (var item in jsonResponse) {
      FotoModel contact = FotoModel.fromMap(item);
      listaFotos.add(contact);
    }
    return listaFotos;
  }

  static FotoModel setSelect(FotoModel photo) {
    selectFoto = photo;
    print('La foto cambio al id : ${selectFoto.id}');
    return selectFoto;
  }

  static Future comprar(idUser,idFoto) async{
    await http.put(
        Uri.parse('$baseUrl/buyFotoUsuario/$idUser/$idFoto'),);
  }
}
