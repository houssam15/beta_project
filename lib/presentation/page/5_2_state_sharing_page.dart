
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../bloc/switch_theme/switch_theme_bloc.bloc.dart";
import "../bloc/user/user_bloc.bloc.dart";

/*
Exercise 2: MultiBlocProvider with BlocProvider.value
You have a UserBloc and ThemeBloc provided at the top level of the widget tree. Now, you need to pass only the UserBloc to the ProfileScreen without creating a new instance.

Task:
Fill in the blanks in the code below to correctly provide the existing UserBloc instance to ProfileScreen.

MultiBlocProvider(
  providers: [
    BlocProvider(create: (context) => UserBloc()),
    BlocProvider(create: (context) => ThemeBloc()),
  ],
  child: BlocProvider.value(
    value: _______________,
    child: ProfileScreen(),
  ),
);
Questions:

What should replace _______________?
Will the ThemeBloc be available inside ProfileScreen?
*/

class StateSharingPage extends StatefulWidget {
  const StateSharingPage({super.key});

  @override
  State<StateSharingPage> createState() => _StateSharingPageState();
}

class _StateSharingPageState extends State<StateSharingPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => ThemeBloc()),
      ],
      child: BlocBuilder<UserBloc, String>(
        builder:
            (context, state) => BlocProvider.value(
              value: context.read<UserBloc>(),
              child: ProfilePage(),
            ),
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("${context.read<UserBloc>().state}")),
    );
  }
}
