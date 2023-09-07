import 'package:library_manager/data/book.dart';

class User {
  final String name;
  final int id;
  final String gmail;
  final int age;
  final String phoneNumber;
  List<Book> booksBorrowed = [];
  User(
      {required this.id,
      required this.name,
      required this.age,
      required this.gmail,
      required this.phoneNumber});
}
