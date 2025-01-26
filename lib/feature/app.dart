import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:authentication_repository/authentication_repository.dart";
import "package:user_repository/user_repository.dart";
import "package:alpha_flutter_project/feature/authentication/authentication.dart";



class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthenticationRepository _authenticationRepository;
  late final UserRepository _userRepository;

  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthenticationRepository();
    _userRepository = UserRepository();
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      //single instance of AuthenticationRepository provided to the whole app to use it later (e.g logout HomePage).
      value: _authenticationRepository,
      child: BlocProvider(
        //BlocProvider is lazy and does not call create until the first time the Bloc is accessed.
        //Since AuthenticationBloc should always subscribe to the AuthenticationStatus stream immediately (via the AuthenticationSubscriptionRequested event)
        //we can explicitly opt out of this behavior by setting lazy: false.
        lazy: false,
        create:
            (_) => AuthenticationBloc(
              authenticationRepository: _authenticationRepository,
              userRepository: _userRepository,
            )..add(AuthenticationSubscriptionRequested()),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomePage.route(),
                  (route) => false,
                );
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                  (route) => false,
                );
              case AuthenticationStatus.unknown:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_)=>SplashPage.route(),
    );
  }
}
