import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterEvent extends AuthEvent {
  final String username;
  final String password;
  final String verifyPassword;
  final String avatar;
  final String fullName;

  RegisterEvent({
    required this.username,
    required this.password,
    required this.verifyPassword,
    required this.avatar,
    required this.fullName,
  });

  @override
  List<Object> get props =>
      [username, password, verifyPassword, avatar, fullName];
}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  LoginEvent({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

class InitialAuthState extends AuthState {}

class LoadingAuthState extends AuthState {}

class SuccessAuthState extends AuthState {}

class ErrorAuthState extends AuthState {
  final String errorMessage;

  ErrorAuthState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitialAuthState());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is RegisterEvent) {
      yield LoadingAuthState();

      try {
        final response = await http.post(
          Uri.parse('http://localhost:8080/auth/register'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'username': event.username,
            'password': event.password,
            'verifyPassword': event.verifyPassword,
            'avatar': event.avatar,
            'fullName': event.fullName,
          }),
        );

        if (response.statusCode == 201) {
          yield SuccessAuthState();
        } else {
          final jsonResponse = jsonDecode(response.body);
          yield ErrorAuthState(errorMessage: jsonResponse['message']);
        }
      } catch (e) {
        yield ErrorAuthState(errorMessage: 'Error al registrar el usuario');
      }
    } else if (event is LoginEvent) {
      yield LoadingAuthState();

      try {
        final response = await http.post(
          Uri.parse('http://localhost:8080/auth/login'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'username': event.username,
            'password': event.password,
          }),
        );

        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          yield SuccessAuthState();
        } else {
          final jsonResponse = jsonDecode(response.body);
          yield ErrorAuthState(errorMessage: jsonResponse['message']);
        }
      } catch (e) {
        yield ErrorAuthState(errorMessage: 'Error al hacer login');
      }
    }
  }
}
