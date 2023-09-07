import 'package:flutter/material.dart';
import 'package:library_manager/book_issue/book_issue_revoke_main.dart';
import 'package:library_manager/book_page/book_page_main.dart';

//import 'package:library_manager/data/user_remove_page.dart';
import 'package:library_manager/user_page/user_page_main.dart';

import 'button.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    const sb = SizedBox(
      height: 20,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: const Text('Library Mananger'),
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(),
          sb,
          Button(
            name: 'Users',
            route: UserPageMain(),
          ),
          sb,
          Button(name: 'Books', route: BookPageMain()),
          sb,
          Button(name: 'Issue/Revoke Book', route: BookIssueRevokeMain())
        ],
      ),
    );
  }
}
