import "package:alpha_flutter_project/qrcode_list/src/bloc/bloc.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "failed_to_load_more_items.dart";
import "bottom_loader.dart";
import "qrcode_list_item/qrcode_list_item.dart";
class QrcodeList extends StatefulWidget {
  const QrcodeList({super.key});

  @override
  State<QrcodeList> createState() => _QrcodeListState();
}

class _QrcodeListState extends State<QrcodeList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: ListView.builder(
          physics: const ClampingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return index >= context.read<QrcodeListRemoteBloc>().state.items.length
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if(context.read<QrcodeListRemoteBloc>().state.failedToLoadMoreItems)
                  ...[
                    FailedToLoadMoreItems(),
                    SizedBox(height: 5),
                    InkWell(
                        //onTap: () => context.read<SocialMediaQrcodeListRemoteBloc>().add(SocialMediaQrcodeListRemotePublicationFetched(context: context,simulateLoading:true)),
                        child: Icon(FontAwesomeIcons.arrowsRotate,color: Theme.of(context).colorScheme.secondary,size: 15)
                    )
                  ],
                if(context.read<QrcodeListRemoteBloc>().state.showBottomLoader)
                  BottomLoader()
              ],
            )
                : QrcodeListItem(index:index);
          },
          itemCount: context.read<QrcodeListRemoteBloc>().state.hasReachedMax
              ? context.read<QrcodeListRemoteBloc>().state.items.length
              : context.read<QrcodeListRemoteBloc>().state.items.length + 1,
          controller: _scrollController
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    //if (_isBottom && context.read<QrcodeListRemoteBloc>().state.hasReachedMax==false) context.read<SocialMediaQrcodeListRemoteBloc>().add(SocialMediaQrcodeListRemotePublicationFetched(context: context));
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
