import 'package:flutter/material.dart';

/// {@template patient_profile}
/// Pantalla principal para mostrar y actualizar el perfil de un paciente.
/// Contiene información personal, médica y opciones para editar estos datos.
/// {@endtemplate}
class PatientProfile extends StatelessWidget {
  final Map<String, dynamic> data;

  const PatientProfile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

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

  Widget _buildHeader() {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.blue[100],
          child: Text(
            data['name'][0], // Primera letra del nombre del paciente
            style: TextStyle(
              color: Colors.blue[800],
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${data['name']} ${data['lastName']}',
              style: const TextStyle(
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

  Widget _buildInformationCard() {
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
            _InformationRow(
              icon: Icons.water_drop,
              label: 'Tipo de sangre',
              value: data['bloodType'],
              color: Colors.red,
            ),
            _InformationRow(
              icon: Icons.medical_services,
              label: 'Alergias',
              value: data['allergies'],
              color: Colors.red,
            ),
            _InformationRow(
              icon: Icons.local_hospital,
              label: 'Medicamentos',
              value: data['medicines'],
              color: Colors.red,
            ),
            _InformationRow(
              icon: Icons.home,
              label: 'Dirección',
              value: data['address'],
              color: Colors.red,
            ),
            _InformationRow(
              icon: Icons.description,
              label: 'Notas médicas',
              value: data['medicalNotes'],
              color: Colors.red,
            ),
            _InformationRow(
              icon: Icons.favorite,
              label: 'Donador de órganos',
              value: data['organDonor'] ? 'Sí' : 'No',
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

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
            _buildTextField('Nombre', data['name']),
            const SizedBox(height: 10),
            _buildTextField('Email', data['email']),
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
}

/// Widget para mostrar una fila de información en la tarjeta médica.
class _InformationRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _InformationRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

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
}
