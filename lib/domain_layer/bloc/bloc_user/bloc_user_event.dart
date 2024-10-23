abstract class UserEvent {}

class GetUser extends UserEvent {
  late String uid;
  GetUser(uid);
}
