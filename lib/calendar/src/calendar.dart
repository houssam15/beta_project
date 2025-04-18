import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "../../common/src/layouts/feature_layout.dart";
import "bloc/remote/calendar_remote_bloc.dart";
import "calendar_params.dart";
import "config/calendar_config.dart";
import "theme/app_theme.dart";
import "view/calendar_view.dart";
class Calendar extends StatefulWidget {
  static final String route = CalendarConfig().route;
  final CalendarParams? params;

  const Calendar({super.key,this.params});

  @override
  State<Calendar> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<Calendar> {

  CalendarConfig _config = CalendarConfig();

  @override
  Widget build(BuildContext context) {
    return FeatureLayout<CalendarParams>(
      selectedRoute: _config.route,
      params: widget.params ?? CalendarParams().create(ModalRoute.of(context)?.settings.arguments),
      lang: LangParams(_config.langPath),
      theme: ThemeParams(AppTheme().themeData),
      providers: [
          BlocProvider<CalendarRemoteBloc>(
              create: (_) => CalendarRemoteBloc()..add(CalendarRemoteDataRequested())
          )
      ],
      child: CalendarView()
    );
  }
}
