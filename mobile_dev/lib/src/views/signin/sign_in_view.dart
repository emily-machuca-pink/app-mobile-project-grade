//
//  Copyright © 2024 Emily Machuca. All rights reserved.
//

import 'package:flutter/material.dart';
import 'package:mobile_dev/src/components/loginCard/login_card.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoginCard(),
          SizedBox(height: 30),
          Image(
            image: AssetImage('assets/health-insurance.png'),
            height: 200,
          ),
        ],
      ),
    );
  }
}
