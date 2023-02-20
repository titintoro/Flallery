import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flallery_frontend/blocs/authentication/authentication.dart';
import 'package:flallery_frontend/config/locator.dart';
import 'package:flallery_frontend/services/services.dart';
import '../models/models.dart';

class HomePage extends StatelessWidget {
  final User user;

  const HomePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Colors.amber,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Hola, ${user.fullName}',
                style: TextStyle(
                  fontSize: 24
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                //textColor: Theme.of(context).primaryColor,
                /*style: TextButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                ),*/
                child: Text('Logout'),
                onPressed: (){
                  authBloc.add(UserLoggedOut());
                },
              ),
              ElevatedButton(onPressed: () async {
                print("Check");
                JwtAuthenticationService service = getIt<JwtAuthenticationService>();
                await service.getCurrentUser();
              }
              , child: Text('Check')
              )
            ],
          ),
        ),
      ),
    );
  }
}
