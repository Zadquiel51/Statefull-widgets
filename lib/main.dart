import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); //No olvidar que esto es un súper parametro 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue, //Coloca el color de fondo del AppBar
          title: const Text('Operaciones Aritméticas'),
        ),
        body: const OperacionesAritmeticas(),
      ),
    );
  }
}

class OperacionesAritmeticas extends StatefulWidget {
  const OperacionesAritmeticas({super.key});

  @override
  OperacionesAritmeticasState createState() => OperacionesAritmeticasState();
}

class OperacionesAritmeticasState extends State<OperacionesAritmeticas> {
  final TextEditingController _primerValorController = TextEditingController();
  final TextEditingController _segundoValorController = TextEditingController();
  final TextEditingController _resultadoController = TextEditingController();
  String? _operacionSeleccionada;

  void _calcularResultado() { //Función
    double primerValor = double.parse(_primerValorController.text);
    double segundoValor = double.parse(_segundoValorController.text);
    double resultado = 0;

    switch (_operacionSeleccionada) { //Switch que permite la selección de la operación
      case 'Suma':
        resultado = primerValor + segundoValor;
        break;
      case 'Resta':
        resultado = primerValor - segundoValor;
        break;
      case 'Multiplicación':
        resultado = primerValor * segundoValor;
        break;
      case 'División':
        resultado = primerValor / segundoValor;
        break;
    }

    setState(() {
      _resultadoController.text = resultado.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _primerValorController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Primer valor', //Texto de la parte superior del recuadro
                  hintText: 'Ingrese un número', //texto de la parte interior del recuadro
                  helperText: 'Valor correcto', //Texto que aparece debajo del recuadro
                  filled: true,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _segundoValorController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Segundo valor',
                  hintText: 'Ingrese un número',
                  helperText: 'Valor correcto',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButton<String>(
                value: _operacionSeleccionada,
                hint: const Text('Operación'),
                items: <String>['Suma', 'Resta', 'Multiplicación', 'División'] //Opciones de operaciones
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _operacionSeleccionada = newValue;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _resultadoController,
                readOnly: true, // Para que el usuario no pueda editar el campo
                decoration: const InputDecoration(
                  labelText: 'Total',
                  hintText: 'Resultado',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: _calcularResultado,
            child: const Icon(Icons.play_arrow), // Icono de play del botón
          ),
        ),
      ],
    );
  }
}
