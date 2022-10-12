import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:photo_market/models/models.dart';
//import 'package:photo_market/services/services.dart';

class EventService{
  //final UserModel user = AuthService.user!;

  static Future<List<EventoModel>> getEvents(userId) async {
    List<EventoModel> listaEventos = [];
    var response =
        await http.get(Uri.parse('http://192.168.100.235/sw-photo/public/api/getEventoParticipante/$userId'));
    var jsonResponse = convert.jsonDecode(response.body);
    for (var item in jsonResponse) {
      EventoModel contact = EventoModel.fromMap(item);
      listaEventos.add(contact);
    }
    return listaEventos;
  }
}