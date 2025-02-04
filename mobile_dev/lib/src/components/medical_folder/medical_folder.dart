import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_dev/src/components/credit_card/credit_card.dart';

class MedicalFolderView extends StatelessWidget {
  const MedicalFolderView({super.key});

  @override
  Widget build(BuildContext context) {
    int emergencyCount = 3; // Número de emergencias
    double totalInvoice = 500.75; // Facturación total

    // Obtener la fecha y hora actual
    String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    String formattedTime = DateFormat('HH:mm').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Carpeta Médica',
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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Card que contiene la información de emergencias y facturación
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Número de Emergencias: $emergencyCount',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Facturación Total: \$${totalInvoice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Fecha: $formattedDate\nHora: $formattedTime',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Método de pago
                const Text(
                  'Método de Pago:',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                // Opciones de pago (Tarjeta de Crédito o SISBEN)
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.credit_card, color: Colors.blue),
                          title: const Text('Tarjeta de Crédito'),
                          onTap: () {
                            // Navegar a la vista de la tarjeta de crédito
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const CreditCardView()),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.account_balance, color: Colors.green),
                          title: const Text('SISBEN'),
                          onTap: () {
                            // Acción para seleccionar SISBEN
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
