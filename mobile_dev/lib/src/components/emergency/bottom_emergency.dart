// Copyright © 2025, Proyecto de Grado
// Todos los derechos reservados.

import 'package:flutter/material.dart';
import 'package:mobile_dev/src/views/patient_profile/patient_profile.dart';

/// {@template emergency_button_view}
/// Pantalla principal para el botón de emergencia.
/// Incluye un botón central de emergencia y accesos rápidos a otras opciones.
/// {@endtemplate}
class EmergencyButtonView extends StatelessWidget {
  //#region Constructor

  /// {@macro emergency_button_view}
  const EmergencyButtonView({Key? key}) : super(key: key);

  //#endregion

  //#region Overridden Methods

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: Colors.blue,
      body: _buildBody(context),
    );
  }

  //#endregion

  //#region Private Widgets

  /// Construye la barra de navegación superior.
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'Emergencia',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.blue,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: Colors.white,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  /// Construye el cuerpo principal de la pantalla.
  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildBottomActions(context),
          _buildEmergencyButton(),
        ],
      ),
    );
  }

  /// Construye las acciones en la parte inferior de la pantalla.
  Widget _buildBottomActions(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.folder_copy, size: 40, color: Colors.white),
              onPressed: () {
                // Acción para el botón de "carpeta médica"
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

  /// Construye el botón de emergencia en el centro de la pantalla.
  Widget _buildEmergencyButton() {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
          ),
          const Text(
            'SOS',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  //#endregion
}
