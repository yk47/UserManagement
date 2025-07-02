import 'package:userdemo_app/models/user_model.dart';

abstract class UserEvent {}

class FetchUsers extends UserEvent {}

class AddUser extends UserEvent {
  final User user;
  AddUser(this.user);
}

class RefreshUsers extends UserEvent {}
