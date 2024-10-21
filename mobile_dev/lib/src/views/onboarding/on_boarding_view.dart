//
//  Copyright © 2024 Emily Machuca. All rights reserved.
//

import 'package:flutter/material.dart';
import 'package:mobile_dev/src/views/signin/sign_in_view.dart';

/// {@template on_borading_view}
/// A UI that represents the onboarding screen of the Hospinova app.
///
/// This view displays a welcoming message, a health insurance image,
/// and a starter button that allows users to proceed to the main application.
/// {@endtemplate}
class OnBoardingView extends StatelessWidget {
  /// {@macro on_borading_view}
  const OnBoardingView({super.key});

  //#region Overriden methods

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: _buildBody(context),
      ),
    );
  }

  //#endregion

  //#region Private methods

  Widget _buildBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 30),
        const Image(
          image: AssetImage('assets/health-insurance.png'),
          height: 300,
        ),
        const SizedBox(height: 20),
        _makeNameDisplay(),
        const SizedBox(height: 20),
        _makeStarterButton(context),
        const SizedBox(height: 50),
      ],
    );
  }

  Widget _makeNameDisplay() {
    return const Text(
      '¡Bienvenido a Hospinova!',
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.none,
      ),
    );
  }

  Widget _makeStarterButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SignInView(),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 15,
        ),
      ),
      child: const Text(
        'EMPEZAR',
        style: TextStyle(
          color: Colors.blue,
          fontSize: 18,
        ),
      ),
    );
  }

  //#endregion
}
