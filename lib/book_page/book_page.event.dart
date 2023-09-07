import 'package:equatable/equatable.dart';

import '../data/book.dart';

class BookPageEvent extends Equatable {
  const BookPageEvent();

  @override
  List<Object?> get props => [];
}

class AddBook extends BookPageEvent {
  final String name;
  final String publication;
  final String gmail;
  final String authorName;
  final int id;
  const AddBook(
      {required this.name,
      required this.publication,
      required this.gmail,
      required this.authorName,
      required this.id});
}

class RemoveBook extends BookPageEvent {
  final int id;
  const RemoveBook(this.id);
  @override
  List<Object?> get props => [id];
}

class LoadBooks extends BookPageEvent {}

class ApplyFitersBooks extends BookPageEvent {
  @override
  List<Object?> get props => [nameFilter, authorNameFilter, publicationName];
  final String? nameFilter;
  final String? authorNameFilter;
  final String? publicationName;
  const ApplyFitersBooks(
      {this.authorNameFilter, this.nameFilter, this.publicationName});
}

class ReloadBooks extends BookPageEvent {
  final List<Book> newBookList;
  const ReloadBooks({required this.newBookList});
  @override
  List<Object?> get props => [newBookList];
}

class IssueBook extends BookPageEvent {
  final int bookId;
  final int userId;
  const IssueBook({required this.bookId, required this.userId});
  @override
  List<Object?> get props => [bookId, userId];
}
