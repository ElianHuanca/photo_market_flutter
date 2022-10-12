// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, unnecessary_const

import 'package:flutter/material.dart';
import 'package:photo_market/services/services.dart';
import 'package:photo_market/widgets/widgets.dart';
import 'package:provider/provider.dart';

class EventScreen extends StatefulWidget {
  EventScreen({Key? key}) : super(key: key);
  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final user = AuthService.user;
  List<Widget> lista = [];
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Eventos'),
        leading: IconButton(
          icon: Icon(Icons.login_outlined),
          onPressed: () {
            authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(padding: EdgeInsets.only(top: 10.0)),
          listContact(),
        ]),
      ),
    );
  }

  Widget listContact() {
    return FutureBuilder(
      future: EventService.getEvents(user?.id),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromRGBO(59, 210, 127, 1)),
            ),
          );
        }
        return Container(
          margin: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            /* border: Border.all(
              color: Colors.black,
              width: 1,
            ), */
          ),
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: _cargarEventos(snapshot.data, context),
          ),
        );
      },
    );
  }

  List<Widget> _cargarEventos(List<dynamic>? data, BuildContext context) {
    lista = [];
    if (data!.length == 0) {
      return [
        Center(child: Text('No hay contenidos para mostrar')),
      ];
    }
    data.forEach((event) async {
      lista.add(CardEvent(
        event: event,
      ));
      lista.add(SizedBox(
        height: 20,
      ));
    });
    return lista;
  }
}
