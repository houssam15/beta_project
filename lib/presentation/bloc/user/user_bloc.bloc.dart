import 'package:alpha_flutter_project/presentation/bloc/user/user_event.bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, String> {
  UserBloc() : super("____") {
    on<GetMeEvent>((event, emit) => emit("houssam"));
  }
}
