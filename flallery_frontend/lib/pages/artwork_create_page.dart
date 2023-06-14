import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flallery_frontend/blocs/artwork_create/artwork_create_bloc.dart';
import 'package:flallery_frontend/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ArtworkCreatePage extends StatefulWidget {
  const ArtworkCreatePage({super.key});

  @override
  State<ArtworkCreatePage> createState() => _ArtworkCreatePageState();
}

class _ArtworkCreatePageState extends State<ArtworkCreatePage> {
  final picker = ImagePicker();
  late File _file;
  FilePickerResult? result;
  bool imageSelected = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArtworkCreateBloc(),
      child: Builder(
        builder: (context) {
          final createArtworkBloc = context.read<ArtworkCreateBloc>();
          return Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            child: Scaffold(
              body: SafeArea(
                child: FormBlocListener<ArtworkCreateBloc, String, String>(
                  onSubmitting: (context, state) =>
                      CreateArtworkDialog.show(context),
                  onSubmissionFailed: (context, state) =>
                      CreateArtworkDialog.hide(context),
                  onSuccess: (context, state) {
                    CreateArtworkDialog.hide(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyApp(),
                      ),
                    );
                  },
                  onFailure: (context, state) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Ha habido un fallo'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    CreateArtworkDialog.hide(context);
                  },
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: createArtworkBloc.name,
                          decoration: InputDecoration(
                            label: Text('Nombre del Artwork'),
                          ),
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: createArtworkBloc.description,
                          decoration: InputDecoration(
                            label: Text('Descripción del Artwork'),
                          ),
                          keyboardType: TextInputType.multiline,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        DropdownFieldBlocBuilder<String>(
                          selectFieldBloc: createArtworkBloc.categoryName,
                          decoration: InputDecoration(
                            label: Text('Descripción del Artwork'),
                          ),
                          itemBuilder: (context, value) =>
                              FieldItem(child: Text(value)),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextButton(
                          onPressed: () async {
                            result = await FilePicker.platform.pickFiles(
                                withData: true,
                                allowMultiple: false,
                                type: FileType.image);
                            setState(() {
                              imageSelected = result != null;
                            });
                            if (imageSelected) {
                              createArtworkBloc.saveImg(result!.files[0]);
                            }
                          },
                          child: const Text("Seleccione una imagen"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (imageSelected)
                          Stack(
                              alignment: Alignment.bottomCenter,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.file(
                                    File(result!.files[0].path!),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                                Positioned(
                                  right: 8,
                                  top: 8,
                                  child: IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      setState(() {
                                        result = null;
                                        imageSelected = false;
                                      });
                                    },
                                    icon: const Icon(Icons.close),
                                  ),
                                ),
                              ]),
                        if (imageSelected)
                          const SizedBox(
                            height: 10,
                          ),
                        ElevatedButton(
                          onPressed: createArtworkBloc.submit,
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.blueGrey)),
                          child: const Text("CREAR ARTWORK"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CreateArtworkDialog extends StatelessWidget {
  static void show(BuildContext context, {Key? key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => CreateArtworkDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  const CreateArtworkDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(12.0),
            child: const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
