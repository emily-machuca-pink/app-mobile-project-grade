// Copyright © 2025, Proyecto de Grado
// Todos los derechos reservados.

// Importaciones principales
import 'package:flutter/material.dart';

/// {@template patient_profile}
/// Pantalla principal para mostrar y actualizar el perfil de un paciente.
/// Contiene información personal, médica y opciones para editar estos datos.
/// {@endtemplate}
class PatientProfile extends StatelessWidget {
  //#region Constructor

  /// {@macro patient_profile}
  const PatientProfile({super.key});

  //#endregion

  //#region Overridden Methods

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  //#endregion

  //#region Private Widgets

  /// Construye la barra de navegación superior.
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      title: const Text(
        'Perfil',
        style: TextStyle(color: Colors.white),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: Colors.white,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.help_outline),
          onPressed: () {
            // Acción para mostrar ayuda.
          },
        ),
      ],
    );
  }

  /// Construye el cuerpo principal de la pantalla.
  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildInformationCard(),
            const SizedBox(height: 20),
            _buildUpdateForm(),
          ],
        ),
      ),
    );
  }

  /// Construye el encabezado con el avatar y el nombre del paciente.
  Widget _buildHeader() {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.blue[100],
          child: Text(
            'NP',
            style: TextStyle(
              color: Colors.blue[800],
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'NOMBRE DEL PACIENTE',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.camera_alt, color: Colors.blue),
          ],
        ),
      ],
    );
  }

  /// Construye la tarjeta que muestra información médica del paciente.
  Widget _buildInformationCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 3,
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InformationRow(
              icon: Icons.water_drop,
              label: 'Tipo de sangre',
              value: 'B+',
              color: Colors.red,
            ),
            _InformationRow(
              icon: Icons.medical_services,
              label: 'Alergias',
              value: 'Ninguna',
              color: Colors.red,
            ),
            _InformationRow(
              icon: Icons.local_hospital,
              label: 'Medicamentos',
              value: 'Metformina (1000mg), Insulina',
              color: Colors.red,
            ),
            _InformationRow(
              icon: Icons.home,
              label: 'Dirección',
              value: 'Calle 96 #56-30',
              color: Colors.red,
            ),
            _InformationRow(
              icon: Icons.description,
              label: 'Notas médicas',
              value: 'Diabetes tipo 2, antecedentes de hipoglucemia severa, riesgo de paro cardíaco bajo esfuerzo físico extremo',
              color: Colors.red,
            ),
            _InformationRow(
              icon: Icons.favorite,
              label: 'Donador de órganos',
              value: 'No',
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  /// Construye el formulario para actualizar datos personales del paciente.
  Widget _buildUpdateForm() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Actualizar Datos Personales',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 10),
            _buildTextField('Nombre', 'Benjamin Perez'),
            const SizedBox(height: 10),
            _buildTextField('Email', 'benjaperez@gmail.com'),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  // Acción para actualizar los datos.
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 10,
                  ),
                ),
                child: const Text(
                  'Actualizar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Construye un campo de texto genérico para el formulario.
  Widget _buildTextField(String label, String initialValue) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }

  //#endregion
}

/// Widget para mostrar una fila de información en la tarjeta médica.
class _InformationRow extends StatelessWidget {
  //#region Properties

  /// Icono que representa la categoría de la información.
  final IconData icon;

  /// Etiqueta de la información.
  final String label;

  /// Valor correspondiente a la información.
  final String value;

  /// Color del icono y texto de la etiqueta.
  final Color color;

  //#endregion

  //#region Constructor

  const _InformationRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  //#endregion

  //#region Overridden Methods

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(value),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //#endregion
}
