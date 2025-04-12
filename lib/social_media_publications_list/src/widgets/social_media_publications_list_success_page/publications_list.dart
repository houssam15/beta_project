import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "../../bloc/remote/social_media_publications_list_remote_bloc.dart";
import "publications_list_item.dart";
import "bottom_loader.dart";
import "failed_to_load_more_items.dart";
class PublicationsList extends StatefulWidget {
  const PublicationsList({super.key,required this.remoteState});
  final SocialMediaPublicationsListRemoteState remoteState;

  @override
  State<PublicationsList> createState() => _PublicationsListState();
}

class _PublicationsListState extends State<PublicationsList> {
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
            return index >= widget.remoteState.publications.length
                //? (widget.remoteState.failedToLoadMoreItems ? FailedToLoadMoreItems(remoteState: widget.remoteState):BottomLoader())
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if(widget.remoteState.failedToLoadMoreItems) 
                        ...[
                          FailedToLoadMoreItems(remoteState: widget.remoteState),
                          SizedBox(height: 5),
                          InkWell(
                              onTap: () => context.read<SocialMediaPublicationsListRemoteBloc>().add(SocialMediaPublicationsListRemotePublicationFetched(context: context,simulateLoading:true)),
                              child: Icon(FontAwesomeIcons.arrowsRotate,color: Theme.of(context).colorScheme.secondary,size: 15)
                          )
                        ],
                      if(!widget.remoteState.failedToLoadMoreItems)
                        BottomLoader()
                    ],
                )
                : PublicationsListItem(publication: widget.remoteState.publications[index],index:index);
          },
          itemCount: widget.remoteState.hasReachedMax
              ? widget.remoteState.publications.length
              : widget.remoteState.publications.length + 1,
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
    if (_isBottom && widget.remoteState.hasReachedMax==false) context.read<SocialMediaPublicationsListRemoteBloc>().add(SocialMediaPublicationsListRemotePublicationFetched(context: context));
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
