import 'package:equatable/equatable.dart';

import '../data/book.dart';

class BookIssueRevokeState extends Equatable {
  final int version;
  final List<List<Book>> booksBorrowedByUsers;
  final String? userFilterName;
  final String? bookFilterName;
  final String? bookFilterPublication;
  final String? userFilterGmail;
  final bool? shouldPop;
  const BookIssueRevokeState(this.version,
      {this.bookFilterPublication,
      this.shouldPop,
      this.userFilterGmail,
      required this.booksBorrowedByUsers,
      this.bookFilterName,
      this.userFilterName});

  BookIssueRevokeState exchangeWith(
      {required List<List<Book>> booksBorrowedByUsers,
      bool? shouldPop,
      String? userFilterName,
      String? bookFilterName,
      String? bookFilterPublication,
      String? userFilterGmail}) {
    return BookIssueRevokeState(version + 1,
        shouldPop: shouldPop ?? this.shouldPop,
        booksBorrowedByUsers: booksBorrowedByUsers,
        userFilterName: userFilterName ?? this.userFilterName,
        bookFilterName: bookFilterName ?? this.bookFilterName,
        bookFilterPublication:
            bookFilterPublication ?? this.bookFilterPublication,
        userFilterGmail: userFilterGmail ?? this.userFilterGmail);
  }

  @override
  List<Object?> get props => [
        booksBorrowedByUsers,
        shouldPop,
        userFilterGmail,
        userFilterName,
        bookFilterName,
        bookFilterPublication,
        version
      ];
}
