import 'book.dart';
import 'list_of_books.dart';
import 'list_of_users.dart';
import 'user.dart';

class UserOperations {
  UserOperations._();
  static final instanceOfUserOperations = UserOperations._();
  void assignUser(int userId, int bookId) {
    User user = Users.instanceOfUserList.userList
        .firstWhere((element) => userId == element.id);
    Book book = Books.instaceOfBooks.bookList
        .firstWhere((element) => element.id == bookId);
    int index = Users.instanceOfUserList.userList.indexOf(user);
    int indexBook = Books.instaceOfBooks.bookList.indexOf(book);
    Users.instanceOfUserList.userList[index].booksBorrowed.add(book);
    Books.instaceOfBooks.bookList[indexBook].usersWhoHaveBorrowed.add(user);
  }
  
void removeUser(int userId, int bookId) {
    User user = Users.instanceOfUserList.userList
        .firstWhere((element) => userId == element.id);
    Book book = Books.instaceOfBooks.bookList
        .firstWhere((element) => element.id == bookId);
    int index = Users.instanceOfUserList.userList.indexOf(user);
    int indexBook = Books.instaceOfBooks.bookList.indexOf(book);
    Users.instanceOfUserList.userList[index].booksBorrowed.remove(book);
    Books.instaceOfBooks.bookList[indexBook].usersWhoHaveBorrowed.remove(user);
  }
}
