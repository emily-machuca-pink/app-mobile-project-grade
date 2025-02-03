import 'package:flutter/material.dart';
import 'package:mobile_dev/src/components/loginCard/login_card.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener las dimensiones de la pantalla
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.15), // Ajustar el espaciado arriba del LoginCard
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: LoginCard(),
              ),
              SizedBox(height: screenHeight * 0.05), // Espacio entre LoginCard y la imagen
              Image(
                image: const AssetImage('assets/health-insurance.png'),
                height: screenHeight * 0.25, // El 25% de la altura de la pantalla
                width: screenWidth * 0.5, // El 50% del ancho de la pantalla
              ),
            ],
          ),
        ),
      ),
    );
  }
}
