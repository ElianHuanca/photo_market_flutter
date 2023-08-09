// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:photo_market/models/models.dart';

class CardEvent extends StatelessWidget {
  final EventoModel event;
  const CardEvent({Key? key, required this.event}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.purple.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Text(
              event.titulo,
              style: TextStyle(fontSize: 22, color: Colors.black),
            ),
            const SizedBox(height: 12),
            Text(
              event.descripcion,
              style: TextStyle(fontSize: 22, color: Colors.black54),
            ),
            const SizedBox(height: 12),
            Text(
              '${event.hora.substring(0, 5)} - ${event.fecha.day.toString()}/${event.fecha.month.toString()}/${event.fecha.year.toString()}',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1),
            ),
            const SizedBox(height: 12),
            Text(
              'Lugar:${event.lugar}',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1),
            ),
          ],
        ),
      ),
    );
  }
}
