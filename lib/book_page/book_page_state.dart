import 'package:equatable/equatable.dart';

import '../data/book.dart';

class BookPageState extends Equatable {
  final bool? shouldPop;
  final int version;
  final List<Book> bookList;
  final String? nameFilter;
  final String? authorNameFilter;
  final String? publicationName;
  const BookPageState(this.version,
      {required this.bookList,
      this.shouldPop,
      this.nameFilter,
      this.authorNameFilter,
      this.publicationName});

  BookPageState exchangeWith(
      //copyWith
      {List<Book>? bookList,
      bool? shouldPop,
      String? nameFilter,
      String? authorNameFilter,
      String? publicationName}) {
    return BookPageState(version + 1,
        bookList: bookList ?? this.bookList,
        shouldPop: shouldPop ?? this.shouldPop,
        authorNameFilter: authorNameFilter ?? this.authorNameFilter,
        publicationName: publicationName ?? this.publicationName,
        nameFilter: nameFilter ?? this.nameFilter);
  }

  @override
  List<Object?> get props => [
        authorNameFilter,
        bookList,
        nameFilter,
        publicationName,
        version,
        shouldPop
      ];
}
