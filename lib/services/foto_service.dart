// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:photo_market/models/models.dart';
import 'package:photo_market/services/services.dart';

class FotoService extends ChangeNotifier {
  List<FotoModel> fotos = [];
  static FotoModel? selectedFoto;
  bool isLoading = true;
  final UserModel _user = AuthService.user!;
  final EventoModel _evento = EventoService.selectedEvento!;

  FotoService() {
    cargarFotos();
  }
  Future<List<FotoModel>> cargarFotos() async {
  print('Se ejecuto');
    this.isLoading = true;
    notifyListeners();
    final response = await http.get(Uri.parse(
        'http://192.168.100.235/sw-photo/public/api/getFotos/${_user.id}/${_evento.id}'));
    if (response.body.isNotEmpty) {
      final List<dynamic> disList = json.decode(response.body);
      for (var element in disList) {
        final tempDoc = FotoModel.fromMap(element);
        fotos.add(tempDoc);
      }
    }
    this.isLoading = false;
    print('Entro al cargar Eventos, el id del usuario es: ${_user.id}');
    print('Lista De Las Fotos: ${fotos}');
    notifyListeners();
    return fotos;
  }
}
