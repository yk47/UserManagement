import '../../models/user_model.dart';

abstract class AddUserEvent {}

class SubmitUser extends AddUserEvent {
  final User user;
  SubmitUser(this.user);
}

class ResetAddUserState extends AddUserEvent {}
