import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:alpha_flutter_project/home/home.dart";

class LogoutButton extends StatelessWidget {
  const LogoutButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Logout'),
      onPressed: () {
        context.read<AuthenticationBloc>().add(AuthenticationLogoutPressed());
      },
    );
  }
}