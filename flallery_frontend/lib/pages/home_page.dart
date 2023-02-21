import 'package:flallery_frontend/models/artwork_list_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flallery_frontend/blocs/authentication/authentication.dart';
import 'package:flallery_frontend/config/locator.dart';
import 'package:flallery_frontend/services/services.dart';
import '../models/models.dart';
/*
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
                style: TextStyle(fontSize: 24),
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
                onPressed: () {
                  authBloc.add(UserLoggedOut());
                },
              ),
              ElevatedButton(
                  onPressed: () async {
                    print("Check");
                    JwtAuthenticationService service =
                        getIt<JwtAuthenticationService>();
                    await service.getCurrentUser();
                  },
                  child: Text('Check'))
            ],
          ),
        ),
      ),
    );
  }
*/

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Colors.amber,
      ),
      body: _body(_index),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.face), label: 'Perfil'),
          BottomNavigationBarItem(icon: Icon(Icons.face), label: 'Hola'),
          BottomNavigationBarItem(icon: Icon(Icons.face), label: 'Siuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu'),
        ],
        onTap: (value) => setState(() {
          _index = value;
        }),
        currentIndex: _index,
      ),
    );
    ;
  }

  Widget _body(int index) {
    switch (index) {
      case 0:
        return SafeArea(
          minimum: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  'Hola, ${widget.user.fullName}',
                  style: TextStyle(fontSize: 24),
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
                  onPressed: () {
                    BlocProvider.of<AuthenticationBloc>(context)
                        .add(UserLoggedOut());
                  },
                ),
                ElevatedButton(
                    onPressed: () async {
                      print("Check");
                      JwtAuthenticationService service =
                          getIt<JwtAuthenticationService>();
                      await service.getCurrentUser();
                    },
                    child: Text('Check'))
              ],
            ),
          ),
        );
      case 1:
        return Center(
          child: Text('Hola'),
        );
      case 2:
        return Center(
          child: Text('Hola'),
        );
      default:
        throw Exception("Fallo");
    }
  }
}
