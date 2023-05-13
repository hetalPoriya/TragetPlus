part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {}

class OnLoginButtonPressed extends AuthenticationEvent {
  final String? username;
  final String? password;

  OnLoginButtonPressed({this.username, this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [username, password];
}

class OnSignUpButtonPressed extends AuthenticationEvent {
  final LoginModel? loginModel;

  OnSignUpButtonPressed({this.loginModel});

  @override
  // TODO: implement props
  List<Object?> get props => [loginModel];
}

// class onChangePassButtonPressed extends AuthenticationEvent {
//   int? id;
//   String? old_password;
//   String? password;
//
//   onChangePassButtonPressed({this.id, this.password, this.old_password});
//
//   @override
//   // TODO: implement props
//   List<Object?> get props => [id, password, old_password];
// }
//
// class onEmailSubmitButtonPressed extends AuthenticationEvent {
//   String? email;
//
//   onEmailSubmitButtonPressed({this.email});
//
//   @override
//   // TODO: implement props
//   List<Object?> get props => [email];
// }
