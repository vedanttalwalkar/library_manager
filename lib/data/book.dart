import 'package:library_manager/data/user.dart';

class Book {
  final String name;
  final String publication;
  final String authorName;
  final int id;
  final String authorGmail;
  int quantity=1;
  List<User> usersWhoHaveBorrowed = [];
  Book(
      {required this.name,
      required this.publication,
      required this.authorName,
      required this.id,
      required this.authorGmail});
 


}


