//
//  Copyright © 2025 Proyecto de grado. All rights reserved.
//

import 'package:flutter/material.dart';
import 'package:mobile_dev/src/components/medical_folder/medical_folder.dart';
import 'package:mobile_dev/src/views/patient_profile/patient_profile.dart';

class BottomActions extends StatelessWidget {
  const BottomActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.folder_copy, size: 40, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MedicalFolderView()),
                );
              },
            ),
            const SizedBox(width: 40),
            IconButton(
              icon: const Icon(Icons.person, size: 40, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PatientProfile()),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
