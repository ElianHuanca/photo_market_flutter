// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:photo_market/color_filters.dart';
import 'package:photo_market/models/models.dart';

class CardImage extends StatelessWidget {
  final FotoModel foto;
  const CardImage({Key? key, required this.foto}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Ink.image(
            image: NetworkImage(foto.url),
            colorFilter: foto.comprado == 0 ? ColorFilters.greyscale : null,
            height: 240,
            fit: BoxFit.cover,
          ),
          if (foto.comprado == 0)
            Text(
              'Precio: 1.55 USD',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 24,
              ),
            )
        ],
      ),
    );
  }
}
