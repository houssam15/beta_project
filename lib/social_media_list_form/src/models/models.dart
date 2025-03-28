import "dart:io";

import "package:equatable/equatable.dart";
import "package:alpha_flutter_project/social_media_publication_form/social_media_publication_form.dart";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import 'package:social_media_list_form_repository/social_media_list_form_repository.dart' as social_media_list_form_repository;
import "package:file_uploader_repository/file_uploader_repository.dart" as fur;

import "../bloc/remote/social_media_list_form.remote.bloc.dart";
part 'config.dart';
part 'social_media_item.dart';
part 'social_media_error_item.dart';
part 'valid_constraints.dart';
part 'constraints.dart';
part 'upload_document_response.dart';