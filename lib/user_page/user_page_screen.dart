import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:library_manager/user_page/user_page_bloc.dart';
import 'package:library_manager/user_page/user_page_event.dart';
import 'package:library_manager/user_page/user_page_state.dart';
import '../data/list_of_books.dart';
import '../data/list_of_users.dart';
import '../snack_bars.dart';


class UserPageScreen extends StatefulWidget {
  const UserPageScreen({super.key});

  @override
  State<UserPageScreen> createState() => _UserPageScreenState();
}

class _UserPageScreenState extends State<UserPageScreen> {
  final TextEditingController text1EditingController = TextEditingController();

  final TextEditingController textEditingController = TextEditingController();

  OutlineInputBorder textFieldKa = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      borderSide: BorderSide(
        color: Colors.white,
        width: 3,
      ));

  @override
  Widget build(BuildContext context) {
    final userBloc = context.read<UserPageBloc>();
    userBloc.add(LoadUsers());
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 246, 239),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 247, 246, 239),
        title: const Center(
          child: Text('User List'),
        ),
      ),
      body: BlocBuilder<UserPageBloc, UserPageState>(
        builder: ((context, state) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: textEditingController,
                      onChanged: (value) {
                        userBloc.add(ApplyFilter(
                            nameFilter: value, age: state.ageFilter));
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
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: text1EditingController,
                      onChanged: (value) {
                        userBloc.add(ApplyFilter(
                            nameFilter: state.nameFilter,
                            age: int.parse(value)));
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
                          hintText: 'Age Filter',
                          disabledBorder: textFieldKa,
                          focusedBorder: textFieldKa,
                          errorBorder: textFieldKa),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SizedBox(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Assign Book?'),
                                content: SizedBox(
                                  height: 300,
                                  width: 400,
                                  child: ListView.builder(
                                    itemBuilder: (context, i) {
                                      return ListTile(
                                        onTap: () {
                                          userBloc.add(IssueBook(
                                              bookId: i + 1,
                                              userId: index + 1));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(bookAssignSnackBar);
                                          Navigator.pop(context);
                                        },
                                        title: Text(Books
                                            .instaceOfBooks.bookList[i].name),
                                        subtitle: Text(Books.instaceOfBooks
                                            .bookList[i].publication),
                                      );
                                    },
                                    itemCount:
                                        Books.instaceOfBooks.bookList.length,
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
                                title: const Text('Delete this User?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        //since the book being removed should not bee visible in the borrowed
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(userRemoveSnackBar);
                                        userBloc.add(RemoveUser(index));
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
                        title: Text('Name:${state.userList[index].name}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('email:${state.userList[index].gmail}'),
                            Text(
                                'Phone Number:${state.userList[index].phoneNumber}'),
                            Text('Age:${state.userList[index].age}'),
                          ],
                        ),
                      );
                    },
                    itemCount: state.userList.length,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    final TextEditingController nameEditingController =
                        TextEditingController();
                    final TextEditingController gmailEditingController =
                        TextEditingController();
                    final TextEditingController ageEditingController =
                        TextEditingController();
                    final TextEditingController pNEditingController =
                        TextEditingController();
                    String name = '';
                    int age = 0;
                    String gmail = '';
                    String phoneNumber = '';
                    int id = Users.instanceOfUserList.userList.length;
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
                                      hintText: 'Name of User',
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
                                      hintText: 'Gmail of User',
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
                                  controller: ageEditingController,
                                  onChanged: (value) {
                                    age = int.parse(value);
                                  },
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                      enabledBorder: textFieldKa,
                                      border: textFieldKa,
                                      filled: true,
                                      fillColor: Colors.white,
                                      hoverColor: Colors.white,
                                      hintText: 'Age of User',
                                      disabledBorder: textFieldKa,
                                      focusedBorder: textFieldKa,
                                      errorBorder: textFieldKa),
                                ),
                              ),
                              sb,
                              SizedBox(
                                width: 300,
                                child: TextField(
                                  controller: pNEditingController,
                                  onChanged: (value) {
                                    phoneNumber = value;
                                  },
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                      enabledBorder: textFieldKa,
                                      border: textFieldKa,
                                      filled: true,
                                      fillColor: Colors.white,
                                      hoverColor: Colors.white,
                                      hintText: 'Phone Number of User',
                                      disabledBorder: textFieldKa,
                                      focusedBorder: textFieldKa,
                                      errorBorder: textFieldKa),
                                ),
                              ),
                              sb,
                              TextButton(
                                  onPressed: () {
                                    if (state.showAddDialog!) {
                                      userBloc.add(AddUser(
                                          id: id,
                                          phoneNumber: phoneNumber,
                                          name: name,
                                          gmail: gmail,
                                          age: age));
                                    }
                                  },
                                  child: const Text('Submit')),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: const Text('Add User')),
              const SizedBox(
                height: 20,
              ),
            ],
          );
        }),
      ),
    );
  }
}
