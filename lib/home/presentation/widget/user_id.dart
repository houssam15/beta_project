import "package:alpha_flutter_project/home/home.dart";

class UserId extends StatelessWidget {
  const UserId();

  @override
  Widget build(BuildContext context) {
    final userId = context.select(
      (AuthenticationBloc bloc) => bloc.state.user.id,
    );

    return Text('UserID: $userId');
  }
}