import "package:alpha_flutter_project/i18n_testing/src/i18n_testing.dart";
import "package:alpha_flutter_project/social_media_file_uploader_form/social_media_file_uploader_form.dart";
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:alpha_flutter_project/login/login.dart";
import "package:alpha_flutter_project/splash/splash.dart";
import "package:alpha_flutter_project/home/home.dart";
import "package:alpha_flutter_project/weather/weather.dart";
import "package:user_repository/user_repository.dart";
import "package:alpha_flutter_project/authentication/authentication.dart";
import "counter/counter_app.dart";
import "flutter_infinite_list/infinite_list_app.dart";
import "package:alpha_flutter_project/social_media_publication_form/social_media_publication_form.dart";
import "package:alpha_flutter_project/social_media_list_form/social_media_list_form.dart";

final navigatorKey = GlobalKey<NavigatorState>();

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
  NavigatorState get _navigator => navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      //initialRoute: SocialMediaPublicationForm.route,
      routes:{
        HomeApp.route:(context) => const HomeApp(),
        WeatherApp.route:(context)=> WeatherApp(),
        LoginApp.route:(context) => const LoginApp(),
        InfiniteListApp.route:(context) => const InfiniteListApp(),
        CounterApp.route:(context) => const CounterApp(),
        SocialMediaFileUploaderForm.route:(context) => const SocialMediaFileUploaderForm(),
        SocialMediaPublicationForm.route:(context) => const SocialMediaPublicationForm(),
        SocialMediaListForm.route:(context) => const SocialMediaListForm(),
        I18nTesting.route:(context) => const I18nTesting()
      },
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                //_navigator.pushNamedAndRemoveUntil(HomeApp.route, (route) => false);
              case AuthenticationStatus.unauthenticated:
                //_navigator.pushNamedAndRemoveUntil(LoginApp.route, (route) => false);
              case AuthenticationStatus.unknown:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route()
    );
  }
}
