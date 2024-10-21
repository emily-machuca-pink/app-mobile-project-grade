//
//  Copyright © 2024 Emily Machuca. All rights reserved.
//

import 'package:flutter/material.dart';
import 'package:mobile_dev/src/views/views.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: OnBoardingView(),
    );
  }
}
