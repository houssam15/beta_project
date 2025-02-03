import "login.dart";
class LoginApp extends StatefulWidget {
  static final String route = "/login";
  const LoginApp({super.key});

  @override
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
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
          child: const LoginPage(),
        ),
      ),
    );
  }
}
