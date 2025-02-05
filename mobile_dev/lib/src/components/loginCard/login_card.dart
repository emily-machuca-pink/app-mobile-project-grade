import 'package:flutter/material.dart';
import 'package:mobile_dev/src/components/components.dart';

/// Enumeración para definir los roles en la aplicación.
enum HospiRoles { paciente, paramedico }

class LoginCard extends StatefulWidget {
  const LoginCard({super.key});

  @override
  _LoginCardState createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  HospiRoles _selectedRole = HospiRoles.paciente;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final Map<String, Map<String, dynamic>> _users = {
    'BenjaminPerez': {
      'password': 'pass12355b',
      'role': 'paciente',
      'medicalHistory': {
        'name': 'Benjamin',
        'lastName': 'Perez',
        'cedula': 123455655,
        'email': 'benja.p@example.com',
        'address': 'Calle 96 #56-30',
        'bloodType': 'B+',
        'allergies': 'Ninguna',
        'medicines': 'Metformina (1000mg), Insulina',
        'medicalNotes': 'Diabetes tipo 2, antecedentes de hipoglucemia severa, riesgo de paro cardíaco bajo esfuerzo físico extremo',
        'organDonor': false
      }
    },
    'LuisGutierrez': {
      'password': 'pass123555l',
      'role': 'paciente',
      'medicalHistory': {
        'name': 'Luis',
        'lastName': 'Gutierrez',
        'cedula': 12588685,
        'email': 'lugu25@example.com',
        'address': 'Calle 100 #58-30',
        'bloodType': 'O-',
        'allergies': 'Ninguna',
        'medicines': 'Insulina',
        'medicalNotes': 'Diabetes tipo 3, antecedentes de hipoglucemia severa, riesgo de paro cardíaco bajo esfuerzo físico extremo',
        'organDonor': true
      }
    }
  };

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (_users.containsKey(username) && _users[username]!['password'] == password) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EmergencyButtonView(
            userData: _users[username]!['medicalHistory'],
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Credenciales incorrectas')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Inicio Sesión',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                const SizedBox(height: 20),
                _buildRoleTabs(),
                const SizedBox(height: 20),
                _buildLoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleTabs() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedRole = HospiRoles.paciente),
            child: _buildTab('Paciente', _selectedRole == HospiRoles.paciente, Colors.blue),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedRole = HospiRoles.paramedico),
            child: _buildTab('Paramédico', _selectedRole == HospiRoles.paramedico, Colors.red),
          ),
        ),
      ],
    );
  }

  Widget _buildTab(String title, bool isSelected, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? color : Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      children: [
        _buildTextField('Username', _usernameController),
        const SizedBox(height: 10),
        _buildTextField('Contraseña', _passwordController, isPassword: true),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _login,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
          child: const Text('Inicia Sesión', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isPassword = false}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        labelText: label,
        filled: true,
        fillColor: Colors.grey[200],
      ),
      obscureText: isPassword,
    );
  }
}

class MedicalHistoryView extends StatelessWidget {
  final Map<String, dynamic> data;
  const MedicalHistoryView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Historial Médico de ${data['name']}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(data.toString(), style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
