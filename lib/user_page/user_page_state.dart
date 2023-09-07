//import 'package:equatable/equatable.dart';

import '../data/user.dart';

class UserPageState {
  final bool? showAddDialog;
  final int version;
  final List<User> userList;
  final String? nameFilter;
  final int? ageFilter;
  const UserPageState(this.userList,
      {required this.version,
      this.nameFilter,
      this.showAddDialog,
      this.ageFilter});

  UserPageState exchangeWith({
    bool? showAddDialog,
    List<User>? userList,
    String? nameFilter,
    int? ageFilter,
  }) {
    return UserPageState(
      userList ?? this.userList,
      version: version + 1,
      showAddDialog: showAddDialog ?? this.showAddDialog,
      nameFilter: nameFilter ?? this.nameFilter,
      ageFilter: ageFilter ?? this.ageFilter,
    );
  }
}
