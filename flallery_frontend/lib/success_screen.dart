import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Éxito'),
      ),
      body: Center(
        child: Text('Registro exitoso'),
      ),
    );
  }
}