import "package:alpha_flutter_project/app.dart";
import "package:alpha_flutter_project/home/home.dart";
import "package:alpha_flutter_project/weather/weather.dart";
import "package:alpha_flutter_project/weather/weather_app.dart";
import "package:weather_repository/weather_repository.dart" show WeatherRepository;
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  NavigatorState get _navigator => navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    final weatherRepository = WeatherRepository();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            UserId(),
            LogoutButton(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RepositoryProvider.value(
                      value: weatherRepository,
                      child: WeatherApp(weatherRepository: weatherRepository),
                    ),
                  ),
                );
              },
              child: Text("weather page"),
            ),
          ],
        ),
      ),
    );
  }
}
