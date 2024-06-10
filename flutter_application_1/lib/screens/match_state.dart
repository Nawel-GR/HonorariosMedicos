import 'package:flutter/material.dart';
import 'package:flutter_app/screens/layout/header.dart';

class DetalleArchivoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      selectedItem: 0,
      title: 'Detalle de archivo',
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Clinica A Archivo N°7',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  ProgressIndicatorWidget(),
                  SizedBox(height: 20),
                  Expanded(
                    child: InformationList(),
                  ),
                  SizedBox(height: 20),
                  EditButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressIndicatorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        StatusDot(label: 'No existe Match', color: Colors.red),
        StatusDot(label: 'Match', color: Colors.green),
      ],
    );
  }
}

class StatusDot extends StatelessWidget {
  final String label;
  final Color color;

  StatusDot({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 10,
          backgroundColor: color,
        ),
        SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}

class InformationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          InformationItem(label: 'Persona 1', value: '\$ xxx.xxx'),
          InformationItem(label: 'Persona 2', value: '\$ xxx.xxx'),
          InformationItem(label: 'Persona 3', value: '-', error: true),
          InformationItem(label: 'Persona 4', value: '\$ xxx.xxx'),
          InformationItem(label: 'Persona 5', value: '\$ xxx.xxx'),
          InformationItem(label: 'Persona 6', value: '\$ xxx.xxx'),
        ],
      ),
    );
  }
}

class InformationItem extends StatelessWidget {
  final String label;
  final String value;
  final bool error;

  InformationItem({
    required this.label,
    required this.value,
    this.error = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: error ? Colors.red : Colors.green,
              fontWeight: error ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: error ? Colors.red : Colors.green,
              fontWeight: error ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class EditButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Acción de edición
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        'Editar',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DetalleArchivoPage(),
  ));
}
