//
//  Copyright © 2025 Proyecto de grado. All rights reserved.
//

import 'package:flutter/material.dart';

enum HospiRoles { paciente, paramedico }

class LoginCard extends StatefulWidget {
  const LoginCard({super.key});

  @override
  _LoginCardState createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  HospiRoles _selectedRole = HospiRoles.paciente;
  String _selectedDocumentType = 'CC';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Inicio Sesión',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 20),
                _buildRoleTabs(),
                const SizedBox(height: 20),
                if (_selectedRole == HospiRoles.paciente) _buildPatientForm(),
                if (_selectedRole == HospiRoles.paramedico) _buildParamedicForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget para las pestañas de roles
  Widget _buildRoleTabs() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedRole = HospiRoles.paciente),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: _selectedRole == HospiRoles.paciente ? Colors.blue : Colors.grey[300],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                'Paciente',
                style: TextStyle(
                  color: _selectedRole == HospiRoles.paciente ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedRole = HospiRoles.paramedico),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: _selectedRole == HospiRoles.paramedico ? Colors.red : Colors.grey[300],
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                'Paramédico',
                style: TextStyle(
                  color: _selectedRole == HospiRoles.paramedico ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Formulario para Paciente
  Widget _buildPatientForm() {
    return _buildPatientFormContent();
  }

  // Formulario para Paramédico
  Widget _buildParamedicForm() {
    return _buildParamedicFormContent();
  }

  // Formulario para Paciente
  Widget _buildPatientFormContent() {
    return Column(
      children: [
        const Text(
          'Nombre de la EPS',
          style: TextStyle(
            fontSize: 18,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 20),
        _buildDropdownField(),
        const SizedBox(height: 10),
        _buildTextField('Número de documento'),
        const SizedBox(height: 10),
        _buildTextField('Contraseña', isPassword: true),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () {},
            child: const Text(
              '¿Olvidé mi contraseña?',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 10,
            ),
          ),
          child: const Text(
            'Inicia Sesión',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  // Formulario para Paramédico
  Widget _buildParamedicFormContent() {
    return Column(
      children: [
        const Text(
          'Nombre de la EPS',
          style: TextStyle(
            fontSize: 18,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 20),
        _buildTextField('Número de documento'),
        const SizedBox(height: 10),
        _buildTextField('Código de verificación', isPassword: true),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () {},
            child: const Text(
              '¿Olvidé mi contraseña?',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 10,
            ),
          ),
          child: const Text(
            'Inicia Sesión',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        labelText: 'Tipo de documento',
        filled: true,
        fillColor: Colors.grey[200],
      ),
      value: _selectedDocumentType,
      items: const [
        DropdownMenuItem(value: 'CC', child: Text('Cédula de Ciudadanía')),
        DropdownMenuItem(value: 'TI', child: Text('Tarjeta de Identidad')),
        DropdownMenuItem(value: 'PP', child: Text('Pasaporte')),
      ],
      onChanged: (value) {
        setState(() {
          _selectedDocumentType = value ?? 'CC';
        });
      },
    );
  }

  Widget _buildTextField(String label, {bool isPassword = false}) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        labelText: label,
        filled: true,
        fillColor: Colors.grey[200],
      ),
      obscureText: isPassword,
    );
  }
}
