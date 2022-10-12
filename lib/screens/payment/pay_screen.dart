// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:photo_market/bloc/pagar/pagar_bloc.dart';
import 'package:photo_market/data/tarjetas.dart';
import 'package:photo_market/helpers/helpers.dart';
import 'package:photo_market/screens/screens.dart';
import 'package:photo_market/services/services.dart';
import 'package:photo_market/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PayScreen extends StatelessWidget {
  const PayScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final foto = PhotoService.selectFoto;
    return Scaffold(
        appBar: AppBar(
          title: Text('Compra De Foto'),
          leading: IconButton(
            icon: Icon(Icons.backspace_outlined),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () async {
                  mostrarAlerta(context, 'Hola', 'Mundo');
                })
          ],
        ),
        body: Stack(
          children: [
            Container(),
            CardImage(
              foto: foto,
            ),
            Positioned(
              width: size.width,
              height: size.height,
              top: 250,
              child: PageView.builder(
                  controller: PageController(viewportFraction: 0.9),
                  physics: BouncingScrollPhysics(),
                  itemCount: tarjetas.length,
                  itemBuilder: (_, i) {
                    final tarjeta = tarjetas[i];

                    return GestureDetector(
                      onTap: () {
                        context
                            .read<PagarBloc>()
                            .add(OnSeleccionarTarjeta(tarjeta));
                        Navigator.push(
                            context, navegarFadeIn(context, TarjetaPage()));
                      },
                      child: Hero(
                        tag: tarjeta.cardNumber,
                        child: CreditCardWidget(
                          cardNumber: tarjeta.cardNumberHidden,
                          expiryDate: tarjeta.expiracyDate,
                          cardHolderName: tarjeta.cardHolderName,
                          cvvCode: tarjeta.cvv,
                          showBackView: false,
                          onCreditCardWidgetChange: (CreditCardBrand) {},
                        ),
                      ),
                    );
                  }),
            ),
            Positioned(bottom: 0, child: TotalPayButton())
          ],
        ));
  }
}
