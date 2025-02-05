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
              SizedBox(height: screenHeight * 0.15),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: LoginCard(),
              ),
              SizedBox(height: screenHeight * 0.05),
              Image(
                image: const AssetImage('assets/health-insurance.png'),
                height: screenHeight * 0.25,
                width: screenWidth * 0.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
