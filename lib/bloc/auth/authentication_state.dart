part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState extends Equatable {}

class AuthenticationInitial extends AuthenticationState {
  final bool? loading;

  AuthenticationInitial({this.loading});

  @override
  // TODO: implement props
  List<Object?> get props => [loading];
}

class AuthenticationLoaded extends AuthenticationState {
  final response;

  AuthenticationLoaded({
    this.response,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [response];
}
