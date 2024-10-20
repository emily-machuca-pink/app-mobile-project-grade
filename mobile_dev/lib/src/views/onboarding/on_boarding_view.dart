//
//  Copyright © 2024 Emily Machuca. All rights reserved.
//

import 'package:flutter/material.dart';

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
        child: _buildBody(),
      ),
    );
  }

  //#endregion

  //#region Private methods

  Widget _buildBody() {
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
        _makeStarterButton(),
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

  Widget _makeStarterButton() {
    return ElevatedButton(
      onPressed: () {},
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
