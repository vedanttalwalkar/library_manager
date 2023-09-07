import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_manager/book_issue/book_issue_revoke_bloc.dart';
import 'package:library_manager/book_issue/book_issue_revoke_screen.dart';

class BookIssueRevokeMain extends StatelessWidget {
  const BookIssueRevokeMain({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return BookIssueRevokeBloc();
      },
      child: const BookIssueRevokeScreen(),
    );
  }
}
