import 'package:equatable/equatable.dart';

class BookIssueRevokeEvent extends Equatable {
  const BookIssueRevokeEvent();

  @override
  List<Object?> get props => [];
}

class LoadBooksBorrowed extends BookIssueRevokeEvent {}

class ApplyFilters extends BookIssueRevokeEvent {
  final String? userFilterName;
  final String? bookFilterName;
  final String? bookFilterPublication;
  final String? userFilterGmail;
  const ApplyFilters(
      {this.userFilterName,
      this.bookFilterName,
      this.bookFilterPublication,
      this.userFilterGmail});
  @override
  List<Object?> get props =>
      [userFilterGmail, bookFilterName, bookFilterPublication, userFilterName];
}

class IssueBook extends BookIssueRevokeEvent {
  final int bookId;
  final int userId;
  const IssueBook({required this.bookId, required this.userId});

  @override
  List<Object?> get props => [bookId, userId];
}

class RevokeBook extends BookIssueRevokeEvent {
  final int bookId;
  final int userId;
  const RevokeBook({required this.bookId, required this.userId});

  @override
  List<Object?> get props => [bookId, userId];
}
