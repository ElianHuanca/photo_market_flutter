// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, unnecessary_const

import 'package:flutter/material.dart';
import 'package:photo_market/services/services.dart';
import 'package:photo_market/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class FotoScreen extends StatefulWidget {
  FotoScreen({Key? key}) : super(key: key);
  @override
  State<FotoScreen> createState() => _FotoScreenState();
}

class _FotoScreenState extends State<FotoScreen> {
  final user = AuthService.user;
  final event = EventoService.selectedEvento;
  List<Widget> lista = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fotos Del Evento'),
        leading: IconButton(
          icon: Icon(Icons.backspace_outlined),
          onPressed: () {
            Navigator.pop(context);
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
      future: PhotoService.getPhotos(user?.id, event?.id),
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
          padding: EdgeInsets.all(2.0),
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
    data.forEach((photo) async {
      lista.add(
        GestureDetector(
          onTap: () {
            if (photo.comprado == 1) {
              final Uri _url = Uri.parse(photo.url);
              _launchUrl(_url);
            } else {
              PhotoService.setSelect(photo);
              Navigator.pushNamed(context, 'payment');
            }
          },
          child: CardImage(
            foto: photo,
          ),
        ),
      );
      lista.add(SizedBox(
        height: 20,
      ));
    });
    return lista;
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}
