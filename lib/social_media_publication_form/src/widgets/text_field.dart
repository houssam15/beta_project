import "package:flutter/material.dart";

import "../bloc/remote/social_media_publication_form.remote.bloc.dart";

class MyTextField extends StatelessWidget {
  const MyTextField(
   this.remoteState,
  {
    super.key,
    required this.hintText,
    required this.labelText,
    required this.controller,
    this.onChanged
  });

  final String hintText;
  final String labelText;
  final SocialMediaPublicationFormRemoteState remoteState;
  final TextEditingController controller;
  final void Function()? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextField(
        controller: controller,
        onChanged:(v) => onChanged?.call(),
        maxLines: null, // Allows unlimited lines
        keyboardType: TextInputType.multiline, // Enables multiline input
        style: TextStyle(
            fontSize: 10
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(), // Adds a border
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: 10
          ),
          labelText: labelText,
          labelStyle: TextStyle(
              fontSize: 12
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary.withOpacity(0.1),width: 2)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),width: 2)
          ),
        ),

      ),
    );
  }
}
