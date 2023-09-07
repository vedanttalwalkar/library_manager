//import 'package:equatable/equatable.dart';

import 'package:equatable/equatable.dart';

import '../data/user.dart';

class UserPageEvent extends Equatable {
  const UserPageEvent();

  @override
  List<Object?> get props => [];
}

class ReloadUsers extends UserPageEvent {
  final List<User> userList;
  const ReloadUsers(this.userList);
  @override
  List<Object?> get props => [userList];
}

class LoadUsers extends UserPageEvent {}

class ApplyFilter extends UserPageEvent {
  final String? nameFilter;
  final int? age;
  @override
  List<Object?> get props => [nameFilter, age];
  const ApplyFilter({this.nameFilter, this.age});
}

class AddUser extends UserPageEvent {
  final int id;
  final String phoneNumber;
  final String name;
  final String gmail;
  final int age;
  @override
  List<Object?> get props => [id, phoneNumber, name, gmail, age];

  const AddUser(
      {required this.id,
      required this.phoneNumber,
      required this.name,
      required this.gmail,
      required this.age});
}

class RemoveUser extends UserPageEvent {
  final int id;
  const RemoveUser(this.id);
  @override
  List<Object?> get props => [id];
}

class IssueBook extends UserPageEvent {
  final int bookId;
  final int userId;
  const IssueBook({required this.bookId,required this.userId});
}
