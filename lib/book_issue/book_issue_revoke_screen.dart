import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_manager/book_issue/book_issue_revoke_bloc.dart';
import 'package:library_manager/book_issue/book_issue_revoke_event.dart';
import 'package:library_manager/book_issue/book_issue_revoke_state.dart';

import 'package:library_manager/data/user.dart';

import '../data/list_of_books.dart';
import '../data/list_of_users.dart';

class BookIssueRevokeScreen extends StatelessWidget {
  const BookIssueRevokeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookIssueRevokeBloc = context.read<BookIssueRevokeBloc>();
    bookIssueRevokeBloc.add(LoadBooksBorrowed());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Book Issue/Revoke'),
      ),
      body: BlocBuilder<BookIssueRevokeBloc, BookIssueRevokeState>(
        builder: (context, state) {
          return Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Builder(builder: (context) {
                List<User> usersWhoHaveBorrowed = [];
                for (var element in state.booksBorrowedByUsers) {
                  for (User user in Users.instanceOfUserList.userList) {
                    if (element == user.booksBorrowed &&
                        !usersWhoHaveBorrowed.contains(user)) {
                      usersWhoHaveBorrowed.add(user);
                    }
                  }
                }
                return SizedBox(
                  height: 300,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        List<Widget> borrowedBooksByUser = [];
                        for (var element in state.booksBorrowedByUsers[index]) {
                          borrowedBooksByUser.add(Text(element.name));
                        }
                        return Visibility(
                          visible: borrowedBooksByUser.isNotEmpty,
                          child: ListTile(
                            title: Text(usersWhoHaveBorrowed[index].name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: borrowedBooksByUser,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox();
                      },
                      itemCount: state.booksBorrowedByUsers.length),
                );
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              int bookId = -1;
                              int userId = -1;
                              OutlineInputBorder textFieldKa =
                                  const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 3,
                                      ));
                              var textEditingController1 =
                                  TextEditingController();
                              var textEditingController2 =
                                  TextEditingController();
                              return AlertDialog(
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          bookIssueRevokeBloc.add(IssueBook(
                                              bookId: bookId, userId: userId));
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Submit'))
                                  ],
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        child: TextField(
                                          controller: textEditingController1,
                                          onChanged: (value) {
                                            bookId = int.parse(value);
                                          },
                                          cursorColor: Colors.black,
                                          decoration: InputDecoration(
                                              enabledBorder: textFieldKa,
                                              border: textFieldKa,
                                              prefixIcon: const Icon(
                                                Icons.search,
                                                color: Colors.black,
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                              hoverColor: Colors.white,
                                              hintText:
                                                  'Book Id (from 1 to ${Books.instaceOfBooks.bookList.length})',
                                              disabledBorder: textFieldKa,
                                              focusedBorder: textFieldKa,
                                              errorBorder: textFieldKa),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        child: TextField(
                                          controller: textEditingController2,
                                          onChanged: (value) {
                                            userId = int.parse(value);
                                          },
                                          cursorColor: Colors.black,
                                          decoration: InputDecoration(
                                              enabledBorder: textFieldKa,
                                              border: textFieldKa,
                                              prefixIcon: const Icon(
                                                Icons.search,
                                                color: Colors.black,
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                              hoverColor: Colors.white,
                                              hintText:
                                                  'User Id (from 1 to ${Users.instanceOfUserList.userList.length})',
                                              disabledBorder: textFieldKa,
                                              focusedBorder: textFieldKa,
                                              errorBorder: textFieldKa),
                                        ),
                                      ),
                                    ],
                                  ));
                            });
                      },
                      child: const Text('Issue Book')),
                  TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              int bookId = -1;
                              int userId = -1;
                              OutlineInputBorder textFieldKa =
                                  const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 3,
                                      ));
                              var textEditingController1 =
                                  TextEditingController();
                              var textEditingController2 =
                                  TextEditingController();
                              return AlertDialog(
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          bookIssueRevokeBloc.add(RevokeBook(
                                              bookId: bookId, userId: userId));
                                          if (state.shouldPop!) {
                                            Navigator.pop(context);
                                          }
                                        },
                                        child: const Text('Submit'))
                                  ],
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        child: TextField(
                                          controller: textEditingController1,
                                          onChanged: (value) {
                                            bookId = int.parse(value);
                                          },
                                          cursorColor: Colors.black,
                                          decoration: InputDecoration(
                                              enabledBorder: textFieldKa,
                                              border: textFieldKa,
                                              prefixIcon: const Icon(
                                                Icons.search,
                                                color: Colors.black,
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                              hoverColor: Colors.white,
                                              hintText: 'Book Id ',
                                              disabledBorder: textFieldKa,
                                              focusedBorder: textFieldKa,
                                              errorBorder: textFieldKa),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        child: TextField(
                                          controller: textEditingController2,
                                          onChanged: (value) {
                                            userId = int.parse(value);
                                          },
                                          cursorColor: Colors.black,
                                          decoration: InputDecoration(
                                              enabledBorder: textFieldKa,
                                              border: textFieldKa,
                                              prefixIcon: const Icon(
                                                Icons.search,
                                                color: Colors.black,
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                              hoverColor: Colors.white,
                                              hintText: 'User Id ',
                                              disabledBorder: textFieldKa,
                                              focusedBorder: textFieldKa,
                                              errorBorder: textFieldKa),
                                        ),
                                      ),
                                    ],
                                  ));
                            });
                      },
                      child: const Text('Remove Book')),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
