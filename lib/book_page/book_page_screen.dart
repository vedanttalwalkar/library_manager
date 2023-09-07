import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:library_manager/book_page/add_book.dart';
import 'package:library_manager/book_page/book_page.event.dart';
import 'package:library_manager/book_page/book_page_bloc.dart';
import 'package:library_manager/book_page/book_page_state.dart';
import 'package:library_manager/data/list_of_users.dart';

import '../data/list_of_books.dart';
import '../snack_bars.dart';

OutlineInputBorder textFieldKa = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30)),
    borderSide: BorderSide(
      color: Colors.white,
      width: 3,
    ));
TextEditingController textEditingController = TextEditingController();
TextEditingController textEditingController1 = TextEditingController();
TextEditingController textEditingController2 = TextEditingController();

class BookPageScreen extends StatelessWidget {
  const BookPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookBloc = context.read<BookPageBloc>();
    bookBloc.add(LoadBooks());
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Books'),
        ),
      ),
      body: BlocBuilder<BookPageBloc, BookPageState>(builder: (context, state) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    child: TextField(
                      controller: textEditingController,
                      onChanged: (value) {
                        bookBloc.add(ApplyFitersBooks(
                            nameFilter: value,
                            authorNameFilter: state.authorNameFilter,
                            publicationName: state.publicationName));
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
                          hintText: 'Name Filter',
                          disabledBorder: textFieldKa,
                          focusedBorder: textFieldKa,
                          errorBorder: textFieldKa),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    child: TextField(
                      controller: textEditingController1,
                      onChanged: (value) {
                        bookBloc.add(ApplyFitersBooks(
                            nameFilter: state.nameFilter,
                            authorNameFilter: state.authorNameFilter,
                            publicationName: value));
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
                          hintText: 'Publication Filter',
                          disabledBorder: textFieldKa,
                          focusedBorder: textFieldKa,
                          errorBorder: textFieldKa),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    child: TextField(
                      controller: textEditingController2,
                      onChanged: (value) {
                        bookBloc.add(ApplyFitersBooks(
                            nameFilter: state.nameFilter,
                            authorNameFilter: value,
                            publicationName: state.publicationName));
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
                          hintText: 'Author Filter',
                          disabledBorder: textFieldKa,
                          focusedBorder: textFieldKa,
                          errorBorder: textFieldKa),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: SizedBox(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Assign User?'),
                                content: SizedBox(
                                  height: 300,
                                  width: 400,
                                  child: ListView.builder(
                                    itemBuilder: (context, i) {
                                      return ListTile(
                                        onTap: () {
                                          bookBloc.add(IssueBook(
                                              bookId: i + 1,
                                              userId: index + 1));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(bookAssignSnackBar);
                                          Navigator.pop(context);
                                        },
                                        title: Text(Users.instanceOfUserList
                                            .userList[i].name),
                                        subtitle: Text(Users.instanceOfUserList
                                            .userList[i].gmail),
                                      );
                                    },
                                    itemCount: Users
                                        .instanceOfUserList.userList.length,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        onLongPress: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Delete this Book?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        bookBloc.add(RemoveBook(index));
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Yes')),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('No'))
                                ],
                              );
                            },
                          );
                        },
                        title: Text(state.bookList[index].name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(state.bookList[index].authorName),
                            Text(state.bookList[index].authorGmail),
                            Text(state.bookList[index].publication),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 20,
                      );
                    },
                    itemCount: state.bookList.length),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      final TextEditingController nameEditingController =
                          TextEditingController();
                      final TextEditingController gmailEditingController =
                          TextEditingController();
                      final TextEditingController publicationEditingController =
                          TextEditingController();
                      final TextEditingController authorEditingController =
                          TextEditingController();
                      String name = '';
                      String publication = '';
                      String gmail = '';
                      String authorName = '';
                      int id = Books.instaceOfBooks.bookList.length + 1;
                      showDialog(
                        context: context,
                        builder: (context) {
                          var sb = const SizedBox(
                            height: 20,
                          );
                          return AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                sb,
                                SizedBox(
                                  width: 300,
                                  child: TextField(
                                    controller: nameEditingController,
                                    onChanged: (value) {
                                      name = value;
                                    },
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                        enabledBorder: textFieldKa,
                                        border: textFieldKa,
                                        filled: true,
                                        fillColor: Colors.white,
                                        hoverColor: Colors.white,
                                        hintText: 'Name of Book',
                                        disabledBorder: textFieldKa,
                                        focusedBorder: textFieldKa,
                                        errorBorder: textFieldKa),
                                  ),
                                ),
                                sb,
                                SizedBox(
                                  width: 300,
                                  child: TextField(
                                    controller: gmailEditingController,
                                    onChanged: (value) {
                                      gmail = value;
                                    },
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                        enabledBorder: textFieldKa,
                                        border: textFieldKa,
                                        filled: true,
                                        fillColor: Colors.white,
                                        hoverColor: Colors.white,
                                        hintText: 'Gmail of Author',
                                        disabledBorder: textFieldKa,
                                        focusedBorder: textFieldKa,
                                        errorBorder: textFieldKa),
                                  ),
                                ),
                                sb,
                                SizedBox(
                                  width: 300,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: publicationEditingController,
                                    onChanged: (value) {
                                      publication = value;
                                    },
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                        enabledBorder: textFieldKa,
                                        border: textFieldKa,
                                        filled: true,
                                        fillColor: Colors.white,
                                        hoverColor: Colors.white,
                                        hintText: 'publication of User',
                                        disabledBorder: textFieldKa,
                                        focusedBorder: textFieldKa,
                                        errorBorder: textFieldKa),
                                  ),
                                ),
                                sb,
                                SizedBox(
                                  width: 300,
                                  child: TextField(
                                    controller: authorEditingController,
                                    onChanged: (value) {
                                      authorName = value;
                                    },
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                        enabledBorder: textFieldKa,
                                        border: textFieldKa,
                                        filled: true,
                                        fillColor: Colors.white,
                                        hoverColor: Colors.white,
                                        hintText: 'AuthorName',
                                        disabledBorder: textFieldKa,
                                        focusedBorder: textFieldKa,
                                        errorBorder: textFieldKa),
                                  ),
                                ),
                                sb,
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  bookBloc.add(AddBook(
                                      name: name,
                                      publication: publication,
                                      gmail: gmail,
                                      authorName: authorName,
                                      id: id));
                                  if (state.shouldPop!) {
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text('Submit'),
                              )
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Add Book'))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        );
      }),
    );
  }
}
