import "package:alpha_flutter_project/social_media_list_form/src/widgets/error_message.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:localization_service/localization_service.dart";
import "../../common/common.dart";
import "../../home/home_layout.dart";
import "bloc/remote/social_media_list_form.remote.bloc.dart";
import "bloc/local/social_media_list_form.local.bloc.dart";
import "event_bus/social_media_list_form.event_bus.dart";
import "social_media_list_form_arguments.dart";
import "./models/models.dart";
import "./theme/app_theme.dart";
import "./view/social_media_list_form_page.dart";

class SocialMediaListForm extends StatefulWidget {
  static final String route = Config.appRoute;

  const SocialMediaListForm({super.key});

  @override
  State<SocialMediaListForm> createState() => _SocialMediaListFormState();
}

class _SocialMediaListFormState extends State<SocialMediaListForm> {

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    SocialMediaListFormArguments args = ModalRoute.of(context)?.settings.arguments as SocialMediaListFormArguments;
    final localizationService = LocalizationService(Localizations.localeOf(context),feature: "${Config.featureName}/src/lang");
    return MaterialApp(
      localeResolutionCallback: LocalizationService.localeResolutionCallback,
      supportedLocales: LocalizationService.supportedLocales,
      localizationsDelegates: localizationService.localizationsDelegate,
      home: HomeLayout(
          selectedRoute: SocialMediaListForm.route,
          hideAppbar: true,
          body: Theme(
              data: AppTheme().themeData,
              child: args.uploadDocumentResponse==null
                  ? ErrorMessageWidget(context.tr("No file selected"),refresh: false)
                  : RepositoryProvider(
                create: (context) => SocialMediaListFormEventBus(),
                child: Builder(
                    builder: (context) {
                      final eventBus = context.read<SocialMediaListFormEventBus>();
                      return MultiBlocProvider(
                          providers: [
                            BlocProvider<SocialMediaListFormRemoteBloc>(
                                create: (_) => SocialMediaListFormRemoteBloc(args.uploadDocumentResponse!,socialMediaListFormEventBus: eventBus,mediaType: args.mediaType,constrains:args.constrains)
                            ),
                            BlocProvider<SocialMediaListFormLocalBloc>(
                                create: (_) => SocialMediaListFormLocalBloc(args.uploadDocumentResponse!,socialMediaListFormEventBus: eventBus,mediaType: args.mediaType,constrains:args.constrains)
                            ),
                          ],
                          child: Builder(
                              builder: (context) {
                                eventBus.setBlocs(
                                    socialMediaListFormLocalBloc: context.read<SocialMediaListFormLocalBloc>(),
                                    socialMediaListFormRemoteBloc: context.read<SocialMediaListFormRemoteBloc>()
                                );
                                eventBus.listen();
                                return SocialMediaListFormPage();
                              }
                          )
                      );
                    }
                ),
              )
          )
      ),
    );;
  }
}
