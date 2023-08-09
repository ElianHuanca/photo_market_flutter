// ignore_for_file: unused_field

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:photo_market/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:photo_market/services/services.dart';
import 'package:photo_market/const/const.dart';

class EventoService extends ChangeNotifier {
  final List<EventoModel> eventos = [];
  static EventoModel? selectedEvento;
  bool isLoading = true;
  final UserModel user = AuthService.user!;

  EventoService() {
    cargarEventos();
  }

  EventoModel? setSelectedEvento(EventoModel event) {
    selectedEvento = event;
    print('Cambio al selectedEvento ${selectedEvento?.id}');
    return selectedEvento;
  }

  Future<List<EventoModel>> cargarEventos() async {
    this.isLoading = true;
    notifyListeners();
    final response = await http.get(Uri.parse(
        '$baseUrl/getEventoParticipante/${user.id}'));
    if (!response.body.contains('message')) {
      final List<dynamic> disList = json.decode(response.body);
      for (var element in disList) {
        final tempDoc = EventoModel.fromMap(element);
        eventos.add(tempDoc);
      }
    }
    this.isLoading = false;
    print('Entro al cargar Eventos, el id del usuario es: ${user.id}');
    notifyListeners();
    return eventos;
  }
}
