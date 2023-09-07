import 'book.dart';

class Books {
  List<Book> bookList = [
    Book(
      name: 'To Kill a Mockingbird',
      publication: 'Nature',
      authorName: 'SatyaNarayan',
      id: 1,
      authorGmail: 'john.doe@gmail.com',
    ),
    Book(
      name: '1984',
      publication: 'Cell',
      authorName: 'Nature',
      id: 2,
      authorGmail: 'susan.johnson@gmail.com',
    ),
    Book(
      name: 'BhagavadGita',
      publication: 'BhaktiVedant',
      authorName: 'Srila Prabhupada',
      id: 3,
      authorGmail: 'acbvsrilaprabhupada@gmail.com',
    ),
    Book(
      name: 'Easy Journey to Other Planets',
      publication: 'BhaktiVedant',
      authorName: 'Srila Prabhupada',
      id: 4,
      authorGmail: 'acbvsrilaprabhupada@gmail.com',
    ),
    Book(
      name: 'Beyond Birth and Death',
      publication: 'BhaktiVedant',
      authorName: 'Srila Prabhupada',
      id: 5,
      authorGmail: 'acbvsrilaprabhupada@gmail.com',
    ),
  ];
  Books._();
  static final instaceOfBooks = Books._();
  void addBook(Book book) {
    bookList.add(book);
  }

  void removeBook(Book book) {
    bookList.remove(book);
  }

  Book getBook(int id) {
    return bookList.firstWhere((element) => element.id == id);
  }
}
