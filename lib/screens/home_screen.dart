// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:photo_market/screens/screens.dart';
import 'package:photo_market/services/services.dart';
import 'package:photo_market/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final event = Provider.of<EventoService>(context);
    if (event.isLoading) return LoadingScreen();
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
      body: ListView.builder(
          itemCount: event.eventos.length,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () {
            event.setSelectedEvento(event.eventos[index].copy());
            Navigator.pushNamed(context, 'foto');
          },
          child: CardEvent(
            event: event.eventos[index],
          ),
        )
      ),
    );
  }
}
