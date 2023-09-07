import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_manager/book_page/book_page.event.dart';
import 'package:library_manager/book_page/book_page_state.dart';
import 'package:validators/validators.dart';

import '../data/book.dart';
import '../data/list_of_books.dart';
import '../data/list_of_users.dart';
import '../data/user_operations.dart';

class BookPageBloc extends Bloc<BookPageEvent, BookPageState> {
  final bookList = Books.instaceOfBooks.bookList;
  BookPageBloc()
      : super(const BookPageState(1, bookList: [], shouldPop: true)) {
    on<LoadBooks>((event, emit) {
      emit(state.exchangeWith(bookList: bookList));
    });
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
    on<RemoveBook>((event, emit) {
      Books.instaceOfBooks.removeBook(Books.instaceOfBooks.bookList[event.id]);
      emit(state.exchangeWith(bookList: bookList));
    });
    on<AddBook>(
      (event, emit) {
        bool flag = false;
        if (isEmail(event.gmail) && isAlphanumeric(event.publication)) {
          var book = Books.instaceOfBooks.bookList.firstWhere(
            (element) {
              flag = element.authorGmail == event.gmail &&
                  element.name == event.name &&
                  element.authorName == event.authorName &&
                  element.publication == event.publication;
              return flag;
            },
            orElse: () {
              return Book(
                  name: event.name,
                  publication: event.publication,
                  authorName: event.authorName,
                  id: event.id,
                  authorGmail: event.gmail);
            },
          );

          if (flag) {
            int index = Books.instaceOfBooks.bookList.indexOf(book);
            Books.instaceOfBooks.bookList[index].quantity++;
          } else {
            Books.instaceOfBooks.addBook(book);
          }
        }
        emit(state.exchangeWith(
            bookList: Books.instaceOfBooks.bookList, shouldPop: !flag));
      },
    );
    on<ApplyFitersBooks>(((event, emit) {
      var filteredBookList = bookList.where((element) {
        final meetsAuthorNameFilter = event.authorNameFilter == null ||
            element.authorName
                .toLowerCase()
                .contains(event.authorNameFilter!.toLowerCase());
        final meetsPublicationNameFilter = event.publicationName == null ||
            element.publication
                .toLowerCase()
                .contains(event.publicationName!.toLowerCase());
        final meetsNameFilter = event.nameFilter == null ||
            element.name
                .toLowerCase()
                .contains(event.nameFilter!.toLowerCase());

        return meetsAuthorNameFilter &&
            meetsNameFilter &&
            meetsPublicationNameFilter;
      }).toList();

      emit(state.exchangeWith(
          bookList: filteredBookList,
          nameFilter: event.nameFilter,
          authorNameFilter: event.authorNameFilter,
          publicationName: event.publicationName));
    }));
    on<ReloadBooks>(
      (event, emit) {
        emit(state.exchangeWith(bookList: event.newBookList));
      },
    );
  }
}
