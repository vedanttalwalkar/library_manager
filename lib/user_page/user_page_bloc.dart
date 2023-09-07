import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_manager/data/user_operations.dart';
import 'package:library_manager/user_page/user_page_event.dart';
import 'package:library_manager/user_page/user_page_state.dart';
import 'package:validators/validators.dart';

import '../data/list_of_books.dart';
import '../data/list_of_users.dart';
import '../data/user.dart';

class UserPageBloc extends Bloc<UserPageEvent, UserPageState> {
  UserPageBloc()
      : super(const UserPageState([], version: 1, showAddDialog: false)) {
    final List<User> userList = Users.instanceOfUserList.userList;
    on<IssueBook>((event, emit) {
      if (event.bookId > 0 &&
          event.bookId <= Books.instaceOfBooks.bookList.length &&
          event.userId > 0 &&
          event.userId <= Users.instanceOfUserList.userList.length) {
        UserOperations.instanceOfUserOperations
            .assignUser(event.userId, event.bookId);
        // emit(state.exchangeWith());
      }
    });
    on<RemoveUser>((event, emit) {
      Users.instanceOfUserList
          .removeUser(Users.instanceOfUserList.getUser(event.id + 1));
      emit(state.exchangeWith(
        userList: userList,
      ));
    });
    on<AddUser>((event, emit) {
      if (isEmail(event.gmail) &&
          event.phoneNumber.length == 10 &&
          event.age > 10 &&
          isAlpha(event.name)) {
        Users.instanceOfUserList.addUser(User(
            id: event.id,
            name: event.name,
            age: event.age,
            gmail: event.gmail,
            phoneNumber: event.phoneNumber));
        emit(state.exchangeWith(userList: userList, showAddDialog: false));
      }
    });
    on<ReloadUsers>(
        (event, emit) => emit(state.exchangeWith(userList: event.userList)));
    on<LoadUsers>(
        (event, emit) => emit(state.exchangeWith(userList: userList)));
    on<ApplyFilter>(
      ((event, emit) {
        final filteredUsers =
            Users.instanceOfUserList.userList.where((element) {
          final meetsNameCondition = event.nameFilter == null ||
              element.name
                  .toLowerCase()
                  .contains(event.nameFilter!.toLowerCase());
          final meetsAgeCondition =
              event.age == null || element.age < event.age!;
          return meetsAgeCondition && meetsNameCondition;
        }).toList();
        emit(state.exchangeWith(
            userList: filteredUsers,
            nameFilter: event.nameFilter,
            ageFilter: event.age));
      }),
    );
  }
}
