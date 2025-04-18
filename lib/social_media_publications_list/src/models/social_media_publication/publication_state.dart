import 'dart:ui';

class PublicationState {
  String value;
  Color? backgroundColor;

  PublicationState({
    required this.value,
    required this.backgroundColor
  });

  static PublicationState fromRepository(String value,Color? backgroundColor){
    return PublicationState(
        value: value,
        backgroundColor: backgroundColor
    );
  }

}