import 'user.dart';

class Users {
  List<User> userList = [
    User(
      id: 1,
      name: 'Ugo',
      age: 30,
      gmail: 'uclac0@blogger.com',
      phoneNumber: '769 713 7970',
    ),
    User(
      id: 2,
      name: 'Denys',
      age: 50,
      gmail: 'dhanway1@cargocollective.com',
      phoneNumber: '975 400 8290',
    ),
    User(
      id: 3,
      name: 'Frederich',
      age: 30,
      gmail: 'fseiller2@sciencedaily.com',
      phoneNumber: '501 695 6473',
    ),
    User(
      id: 4,
      name: 'Carina',
      age: 45,
      gmail: 'cgoskar3@spiegel.de',
      phoneNumber: '670 927 2332',
    ),
    User(
      id: 5,
      name: 'Krishna Bhaiya',
      age: 16,
      gmail: 'radhekrsna@gmail.com',
      phoneNumber: '457 863 4293',
    ),
    User(
      id: 6,
      name: 'Myrilla',
      age: 26,
      gmail: 'mtrewett4@chicagotribune.com',
      phoneNumber: '588 358 3806',
    ),
    User(
      id: 7,
      name: 'Guido',
      age: 30,
      gmail: 'ghelkin5@senate.gov',
      phoneNumber: '525 859 0830',
    ),
    User(
      id: 8,
      name: 'RadhaRani Ma',
      age: 15,
      gmail: 'harekrsna@gmail.com',
      phoneNumber: '958 103 0328',
    ),
  ];
  static final instanceOfUserList = Users._();
  Users._();

  void addUser(User value) {
    userList.add(value);
  }

  void removeUser(User value) {
    userList.remove(value);
  }

  User getUser(int id) {
    return userList.firstWhere((element) => element.id == id);
  }
}
