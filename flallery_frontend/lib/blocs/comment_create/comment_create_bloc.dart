import 'dart:async';
import 'package:flallery_frontend/config/locator.dart';
import 'package:flallery_frontend/models/comment_create_request.dart';
import 'package:flallery_frontend/services/artwork_service.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class CommentCreateBloc extends FormBloc<String, String> {
  late final ArtworkService _artworkService;

  final comment = TextFieldBloc(validators: [FieldBlocValidators.required]);
  final String id;


  CommentCreateBloc(this.id) {
    _artworkService = getIt<ArtworkService>();
    addFieldBlocs(fieldBlocs: [comment]);
  }

  @override
  Future<void> onSubmitting() async {
    try {
      await _artworkService
          .createComment(CommentCreateRequest(text: comment.value), id);
      emitSuccess();
    } catch (e) {
      emitFailure();
    }
  }
}
