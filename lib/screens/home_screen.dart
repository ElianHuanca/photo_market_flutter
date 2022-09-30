// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:photo_market/services/services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Eventos'),
        leading: IconButton(
          icon: Icon( Icons.login_outlined ),
          onPressed: () {
            authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
      ),
    );
  }
}