import 'package:flallery_frontend/blocs/auth_bloc.dart';
import 'package:flallery_frontend/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _verifyPasswordController = TextEditingController();
  final TextEditingController _avatarController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SuccessAuthState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SuccessScreen(),
              ),
            );
          } else if (state is ErrorAuthState) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Error'),
                  content: Text(state.errorMessage),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
          }
        },
        builder: (context, state) {
          if (state is LoadingAuthState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Nombre de usuario',
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _verifyPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Verificar contraseña',
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _avatarController,
                  decoration: InputDecoration(
                    labelText: 'Avatar',
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _fullNameController,
                  decoration: InputDecoration(
                    labelText: 'Nombre completo',
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(
                      RegisterEvent(
                        username: _usernameController.text,
                        password: _passwordController.text,
                        verifyPassword: _verifyPasswordController.text,
                        avatar: _avatarController.text,
                        fullName: _fullNameController.text,
                      ),
                    );
                  },
                  child: Text('Registrarse'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
