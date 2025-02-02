import "package:alpha_flutter_project/login/login.dart";

class UsernameInput extends StatelessWidget {
  const UsernameInput({super.key});

  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (LoginBloc bloc) => bloc.state.username.displayError,
    );
    return TextField(
      key: const Key("loginForm_usernameInput_textField"),
      onChanged: (username) {
        context.read<LoginBloc>().add(LoginUsernameChanged(username));
      },
      decoration: InputDecoration(
        labelText: "username",
        errorText: displayError != null ? "invalid username" : null,
      ),
    );
  }
}
