import 'package:flutter/material.dart';
import 'package:mobile_dev/src/components/bienestar/control_binestar.dart';
import 'package:mobile_dev/src/components/medical_folder/medical_folder.dart';
import 'package:mobile_dev/src/views/patient_profile/patient_profile.dart';

class BottomActions extends StatelessWidget {
  final Map<String, dynamic> patientData;

  const BottomActions({super.key, required this.patientData});

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
                  MaterialPageRoute(
                    builder: (context) => PatientProfile(data: patientData),
                  ),
                );
              },
            ),
            const SizedBox(width: 40),
            IconButton(
              icon: const Icon(Icons.help, size: 40, color: Colors.white), // Icono de ayuda
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WellnessControlView()), // Navegar a la vista de ayuda
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
