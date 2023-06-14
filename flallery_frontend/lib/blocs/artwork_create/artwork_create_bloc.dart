import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flallery_frontend/config/locator.dart';
import 'package:flallery_frontend/models/artwork_create_request.dart';
import 'package:flallery_frontend/services/artwork_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class ArtworkCreateBloc extends FormBloc<String, String> {
  late final ArtworkService _artworkService;

  late PlatformFile file;
  final name = TextFieldBloc(validators: [FieldBlocValidators.required]);
  final description = TextFieldBloc(validators: [FieldBlocValidators.required]);
  final categoryName = SelectFieldBloc(
      validators: [FieldBlocValidators.required],
      items: ['Esculturas', 'Cuadros', 'Graffitis', 'Óleos']);

  ArtworkCreateBloc() {
    _artworkService = getIt<ArtworkService>();
    addFieldBlocs(fieldBlocs: [name, description, categoryName]);
  }

  @override
  Future<void> onSubmitting() async {
    try {
      await _artworkService.createArtwork(
          ArtworkCreateRequest(
              name: name.value,
              description: description.value,
              categoryName: categoryName.value),
          file);
      emitSuccess();
    } catch (e) {
      emitFailure();
    }
  }

  void saveImg(PlatformFile newFile) {
    file = newFile;
  }
}
