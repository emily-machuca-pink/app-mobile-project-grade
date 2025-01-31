import 'package:flutter/material.dart';

class CreditCardView extends StatefulWidget {
  const CreditCardView({super.key});

  @override
  _CreditCardViewState createState() => _CreditCardViewState();
}

class _CreditCardViewState extends State<CreditCardView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cardHolderController = TextEditingController();

  String _formattedCardNumber = '';
  String _formattedExpiryDate = '';
  String _cardHolder = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Añadir Tarjeta de Crédito',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context); // Regresar a la vista anterior
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tarjeta de Crédito visual
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.blueAccent,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        _formattedCardNumber.isEmpty
                            ? '**** **** **** ****'
                            : _formattedCardNumber,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formattedExpiryDate.isEmpty
                                ? 'MM/AA'
                                : _formattedExpiryDate,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            _cardHolder.isEmpty
                                ? 'Nombre del titular'
                                : _cardHolder,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Formulario para ingresar los datos de la tarjeta
              const Text(
                'Agregar tarjeta de crédito:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _cardNumberController,
                      decoration: const InputDecoration(
                        labelText: 'Número de tarjeta',
                        hintText: '**** **** **** ****',
                        prefixIcon: Icon(Icons.credit_card),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 16,
                      onChanged: (value) {
                        setState(() {
                          _formattedCardNumber = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa el número de tarjeta';
                        }
                        if (value.length != 16) {
                          return 'El número de tarjeta debe tener 16 dígitos';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _expiryDateController,
                      decoration: const InputDecoration(
                        labelText: 'Fecha de vencimiento',
                        hintText: 'MM/AA',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 5,
                      onChanged: (value) {
                        setState(() {
                          _formattedExpiryDate = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa la fecha de vencimiento';
                        }
                        if (!RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$')
                            .hasMatch(value)) {
                          return 'Formato de fecha inválido (MM/AA)';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _cardHolderController,
                      decoration: const InputDecoration(
                        labelText: 'Titular de la tarjeta',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _cardHolder = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa el nombre del titular';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          // Aquí puedes agregar la lógica para guardar la tarjeta
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Tarjeta agregada')),
                          );
                        }
                      },
                      child: const Text('Guardar Tarjeta'),
                      style: ElevatedButton.styleFrom(
                        surfaceTintColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
