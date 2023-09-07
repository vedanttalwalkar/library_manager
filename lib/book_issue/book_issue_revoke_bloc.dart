import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_manager/book_issue/book_issue_revoke_event.dart';
import 'package:library_manager/book_issue/book_issue_revoke_state.dart';

import '../data/book.dart';
import '../data/list_of_books.dart';
import '../data/list_of_users.dart';
import '../data/user_operations.dart';

class BookIssueRevokeBloc
    extends Bloc<BookIssueRevokeEvent, BookIssueRevokeState> {
  List<List<Book>> borrowedBooks = [];
  BookIssueRevokeBloc()
      : super(const BookIssueRevokeState(
            booksBorrowedByUsers: [], shouldPop: true, 1)) {
    for (var element in Users.instanceOfUserList.userList) {
      borrowedBooks.add(element.booksBorrowed);
    }

    on<IssueBook>(
      (event, emit) {
        if (event.bookId <= Books.instaceOfBooks.bookList.length &&
            event.bookId > 0 &&
            event.userId > 0 &&
            event.userId <= Users.instanceOfUserList.userList.length &&
            !Users.instanceOfUserList
                .getUser(event.userId)
                .booksBorrowed
                .contains(Books.instaceOfBooks.getBook(event.bookId))) {
          UserOperations.instanceOfUserOperations
              .assignUser(event.userId, event.bookId);
          emit(state.exchangeWith(
              booksBorrowedByUsers: borrowedBooks, shouldPop: true));
        }
      },
    );

    on<RevokeBook>(
      (event, emit) {
        if (event.bookId <= Books.instaceOfBooks.bookList.length &&
            event.bookId > 0 &&
            event.userId > 0 &&
            event.userId <= Users.instanceOfUserList.userList.length) {
          UserOperations.instanceOfUserOperations
              .removeUser(event.userId, event.bookId);
          emit(state.exchangeWith(
              booksBorrowedByUsers: borrowedBooks, shouldPop: true));
        }
      },
    );
    on<LoadBooksBorrowed>((event, emit) =>
        emit(state.exchangeWith(booksBorrowedByUsers: borrowedBooks)));

    on<ApplyFilters>((event, emit) {
      List<List<Book>> filteredBorrowedBooks = [];

      for (var user in Users.instanceOfUserList.userList) {
        List<Book> borrowedBooksByUser = user.booksBorrowed;

        bool meetsBookNameCondition = event.bookFilterName == null ||
            borrowedBooksByUser.any((element) => element.name
                .toLowerCase()
                .contains(event.bookFilterName!.toLowerCase()));

        bool meetsPublicationCondition = event.bookFilterPublication == null ||
            borrowedBooksByUser.any((element) => element.publication
                .toLowerCase()
                .contains(event.bookFilterPublication!.toLowerCase()));

        bool meetsUserNameCondition = event.userFilterName == null ||
            user.name
                .toLowerCase()
                .contains(event.userFilterName!.toLowerCase());

        bool meetsUserGmailCondition = event.userFilterGmail == null ||
            user.gmail
                .toLowerCase()
                .contains(event.userFilterGmail!.toLowerCase());

        if (meetsUserGmailCondition &&
            meetsBookNameCondition &&
            meetsPublicationCondition &&
            meetsUserNameCondition) {
          filteredBorrowedBooks.add(borrowedBooksByUser);
        }
      }

      emit(state.exchangeWith(
        booksBorrowedByUsers: filteredBorrowedBooks,
        bookFilterName: event.bookFilterName,
        userFilterGmail: event.userFilterGmail,
        bookFilterPublication: event.bookFilterPublication,
        userFilterName: event.userFilterName,
      ));
    });
  }
}
