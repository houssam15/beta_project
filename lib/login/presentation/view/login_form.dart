import "package:alpha_flutter_project/login/login.dart";

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text("Authentication Failure")),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            UsernameInput(),
            const Padding(padding: EdgeInsets.all(12)),
            PasswordInput(),
            const Padding(padding: EdgeInsets.all(12)),
            LoginButton(),
          ],
        ),
      ),
    );
  }
}
