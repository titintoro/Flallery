import 'package:flallery_frontend/blocs/register/register_form_bloc.dart';
import 'package:flallery_frontend/models/artwork_list_response.dart';
import 'package:flallery_frontend/services/artwork_service.dart';
import 'package:flallery_frontend/view/artwork_list.dart';
import 'package:flallery_frontend/view/artwork_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flallery_frontend/blocs/authentication/authentication.dart';
import 'package:flallery_frontend/config/locator.dart';
import 'package:flallery_frontend/services/services.dart';
import '../blocs/artwork_list/artwork_list_bloc.dart';
import '../models/models.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ArtworkService artworkService = ArtworkService();
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FLALLERY'),
        backgroundColor: Colors.amber,
      ),
      body: _body(_index),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.face), label: 'Perfil'),
          BottomNavigationBarItem(icon: Icon(Icons.photo_filter), label: 'Galería'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Gestión'),
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
                  child: Text('Log out'),
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
        return BlocProvider(
          create: (_) =>
              ArtworkBloc(this.artworkService)..add(ArtworkFetched()),
          child: const ArtworksList(),
        );

      case 2:
        return Center(child: Text('Admin Page'));

      default:
        throw Exception("Fallo");
    }
  }
}
