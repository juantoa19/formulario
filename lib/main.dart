import 'package:flutter/material.dart';

class FormularioExamen extends StatefulWidget {
  @override
  _FormularioExamenState createState() => _FormularioExamenState();
}

class _FormularioExamenState extends State<FormularioExamen> {
  final _formKey = GlobalKey<FormState>();
  String? _cedula;
  String? _nombres;
  String? _apellidos;
  DateTime? _fechaNacimiento;
  String _genero = 'Masculino';
  String _estadoCivil = 'Soltero';

  // Método para seleccionar fecha
  Future<void> _selectFechaNacimiento(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _fechaNacimiento = pickedDate;
      });
    }
  }

  // Método para mostrar cuadro de diálogo
  void _showMessage(String mensaje) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Información'),
          content: Text(mensaje),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Validar todos los campos
  bool _validarFormulario() {
    return _cedula != null &&
        _cedula!.isNotEmpty &&
        _cedula!.length == 10 &&
        _nombres != null &&
        _nombres!.isNotEmpty &&
        _apellidos != null &&
        _apellidos!.isNotEmpty &&
        _fechaNacimiento != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario Elegante'),
        backgroundColor: Colors.teal[800],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.cyan[100]!, Colors.teal[100]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Registro de Datos',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Campo Cédula
                  _buildTextField(
                    label: 'Cédula',
                    hint: 'Ingrese su cédula',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'La cédula es obligatoria';
                      }
                      if (value.length != 10) {
                        return 'La cédula debe tener 10 dígitos';
                      }
                      return null;
                    },
                    onSaved: (value) => _cedula = value,
                  ),

                  // Campo Nombres
                  _buildTextField(
                    label: 'Nombres',
                    hint: 'Ingrese sus nombres',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Los nombres son obligatorios';
                      }
                      if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                        return 'Solo se permiten letras y espacios';
                      }
                      return null;
                    },
                    onSaved: (value) => _nombres = value,
                  ),

                  // Campo Apellidos
                  _buildTextField(
                    label: 'Apellidos',
                    hint: 'Ingrese sus apellidos',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Los apellidos son obligatorios';
                      }
                      if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                        return 'Solo se permiten letras y espacios';
                      }
                      return null;
                    },
                    onSaved: (value) => _apellidos = value,
                  ),

                  // Fecha de nacimiento
                  Row(
                    children: [
                      Text(
                        'Fecha de Nacimiento:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () => _selectFechaNacimiento(context),
                        child: Text(
                          _fechaNacimiento == null
                              ? 'Seleccionar'
                              : '${_fechaNacimiento!.day}/${_fechaNacimiento!.month}/${_fechaNacimiento!.year}',
                          style: TextStyle(fontSize: 16, color: Colors.blue[700]),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Género
                  Text(
                    'Género:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 'Masculino',
                        groupValue: _genero,
                        onChanged: (value) {
                          setState(() {
                            _genero = value.toString();
                          });
                        },
                      ),
                      Text('Masculino'),
                      Radio(
                        value: 'Femenino',
                        groupValue: _genero,
                        onChanged: (value) {
                          setState(() {
                            _genero = value.toString();
                          });
                        },
                      ),
                      Text('Femenino'),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Estado Civil
                  Text(
                    'Estado Civil:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    value: _estadoCivil,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    items: ['Soltero', 'Casado', 'Divorciado', 'Viudo']
                        .map((estado) => DropdownMenuItem(
                              value: estado,
                              child: Text(estado),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _estadoCivil = value!;
                      });
                    },
                  ),
                  SizedBox(height: 20),

                  // Botones
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            if (_validarFormulario()) {
                              _showMessage('Formulario enviado con éxito');
                            } else {
                              _showMessage(
                                  'Por favor complete todos los campos obligatorios');
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                        ),
                        child: Text(
                          'Siguiente',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.red),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Salir',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        keyboardType: keyboardType,
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: FormularioExamen()));
