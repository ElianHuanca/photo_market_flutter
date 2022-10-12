// ignore_for_file: file_names

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:photo_market/models/models.dart';

class PhotoService {
  static late FotoModel selectFoto;
  static Future<List<FotoModel>> getPhotos(idUser, idEvento) async {
    List<FotoModel> listaFotos = [];
    var response = await http.get(Uri.parse(
        'http://192.168.100.235/sw-photo/public/api/getFotos/$idUser/$idEvento'));
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
}
