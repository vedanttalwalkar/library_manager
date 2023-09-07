import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_manager/user_page/user_page_bloc.dart';
import 'package:library_manager/user_page/user_page_screen.dart';

class UserPageMain extends StatelessWidget {
  const UserPageMain({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return UserPageBloc();
      },
      child: UserPageScreen(),
    );
  }
}
