import "../../common/src/layouts/feature_layout.dart";
import "package:flutter/material.dart";
import "view/qrcode_list_view.dart";
import "config/qrcode_list_config.dart";
import "theme/app_theme.dart";
import "qrcode_list_params.dart";
import "bloc/bloc.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class QrcodeList extends StatefulWidget {
  static final String route = QrcodeListConfig().route;
  final QrcodeListParams? params;

  QrcodeList({super.key,this.params});

  @override
  State<QrcodeList> createState() => _QrcodeListState();
}

class _QrcodeListState extends State<QrcodeList> {

  QrcodeListConfig _config = QrcodeListConfig();

  @override
  Widget build(BuildContext context) {
    return FeatureLayout<QrcodeListParams>(
        selectedRoute: _config.route,
        params: widget.params ?? QrcodeListParams().create(ModalRoute.of(context)?.settings.arguments),
        lang: LangParams(_config.langPath),
        theme: ThemeParams(AppTheme().themeData),
        providers: [
            BlocProvider<QrcodeListLocalBloc>(
                create: (_) => QrcodeListLocalBloc()
            ),
            BlocProvider<QrcodeListRemoteBloc>(
                create: (_) => QrcodeListRemoteBloc()..add(QrcodeListRemoteItemsRequested(context: context))
            ),
        ],
        child: QrcodeListView()
    );
  }
}
