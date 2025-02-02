import 'package:alpha_flutter_project/login/login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create:
              (context) => LoginBloc(
                authenticationRepository:
                    context.read<AuthenticationRepository>(),
              ),
          child: const LoginForm(),
        ),
      ),
    );
  }
}
