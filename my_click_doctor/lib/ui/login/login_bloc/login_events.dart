// Events
abstract class LoginEvent {}

class UsernameChangedEvent extends LoginEvent {
  final String username;
  UsernameChangedEvent(this.username);
}

class PasswordChangedEvent extends LoginEvent {
  final String password;
  PasswordChangedEvent(this.password);
}

class SubmitLoginEvent extends LoginEvent {}
