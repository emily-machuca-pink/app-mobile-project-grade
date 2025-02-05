import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WellnessControlView extends StatefulWidget {
  const WellnessControlView({super.key});

  @override
  _WellnessControlViewState createState() => _WellnessControlViewState();
}

class _WellnessControlViewState extends State<WellnessControlView> {
  int _selectedFeeling = 3; // Valor por defecto: 3 (estado intermedio)
  final TextEditingController _commentController = TextEditingController();

  // Para las preguntas de síntomas
  bool _hasVomited = false;
  bool _hasBreathingProblems = false;
  bool _hasFever = false;
  bool _hasHeadache = false;
  bool _hasChestPain = false;

  // Obtiene el color basado en el estado
  Color _getColorForFeeling(int feeling) {
    if (feeling == 1 || feeling == 2) {
      return Colors.red; // Malestar
    } else if (feeling == 3) {
      return Colors.orange; // Intermedio
    } else {
      return Colors.green; // Bienestar
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    String formattedTime = DateFormat('HH:mm').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Control de Bienestar', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Título
              const Text(
                '¿Cómo te sientes hoy?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),

              // Barra deslizante para seleccionar el estado
              Slider(
                value: _selectedFeeling.toDouble(),
                min: 1,
                max: 5,
                divisions: 4,
                onChanged: (value) {
                  setState(() {
                    _selectedFeeling = value.toInt();
                  });
                },
                activeColor: _getColorForFeeling(_selectedFeeling),
                inactiveColor: Colors.grey,
              ),

              const SizedBox(height: 20),

              // Mostrar los iconos de cada estado
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return Icon(
                    Icons.circle,
                    color: _getColorForFeeling(index + 1),
                    size: 30,
                  );
                }),
              ),

              const SizedBox(height: 40),

              // Fecha y hora actual
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Fecha: $formattedDate',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    'Hora: $formattedTime',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Preguntas adicionales de síntomas
              const Text(
                '¿Has experimentado alguno de los siguientes síntomas hoy?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              CheckboxListTile(
                title: const Text('Vómitos'),
                value: _hasVomited,
                onChanged: (bool? value) {
                  setState(() {
                    _hasVomited = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Dificultad para respirar'),
                value: _hasBreathingProblems,
                onChanged: (bool? value) {
                  setState(() {
                    _hasBreathingProblems = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Fiebre'),
                value: _hasFever,
                onChanged: (bool? value) {
                  setState(() {
                    _hasFever = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Dolor de cabeza'),
                value: _hasHeadache,
                onChanged: (bool? value) {
                  setState(() {
                    _hasHeadache = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Dolor en el pecho'),
                value: _hasChestPain,
                onChanged: (bool? value) {
                  setState(() {
                    _hasChestPain = value!;
                  });
                },
              ),

              const SizedBox(height: 20),

              // Comentario adicional
              TextField(
                controller: _commentController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Comentario adicional (opcional)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Botón para guardar
              ElevatedButton(
                onPressed: () {
                  // Acción para guardar o procesar la información del control
                  String comment = _commentController.text;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Te sientes: $_selectedFeeling. Comentario: $comment\nVómitos: $_hasVomited, Dificultad para respirar: $_hasBreathingProblems',
                      ),
                    ),
                  );
                  // Aquí podrías agregar lógica para guardar los datos
                },
                style: ElevatedButton.styleFrom(
                  iconColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: const Text('Guardar Mi Estado'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
