import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traget_plus/apiService/api_services.dart';
import 'package:traget_plus/models/models.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<OnLoginButtonPressed>(_onLoginButtonPressed);
    on<OnSignUpButtonPressed>(_onSignUpButtonPressed);
    // on<onChangePassButtonPressed>(_onChangePassButtonPressed);
    // on<onEmailSubmitButtonPressed>(_onEmailSubmitButtonPressed);
  }

  Future<FutureOr<void>> _onLoginButtonPressed(
      OnLoginButtonPressed event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationInitial(loading: true));
    try {
      LoginModel? loginModel;
      loginModel = await ApiServices()
          .loginApi(username: event.username, password: event.password);
      emit(AuthenticationLoaded(response: loginModel));
      emit(AuthenticationInitial(loading: false));
    } catch (e) {
      emit(AuthenticationInitial(loading: false));
    }
  }

  Future<FutureOr<void>> _onSignUpButtonPressed(
      OnSignUpButtonPressed event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationInitial(loading: true));
    try {
      LoginModel? loginModel;
      loginModel = await ApiServices().signUpApi(login: event.loginModel!);
      emit(AuthenticationLoaded(response: loginModel));
      emit(AuthenticationInitial(loading: false));
    } catch (e) {
      emit(AuthenticationInitial(loading: false));
    }
  }

  // Future<FutureOr<void>> _onChangePassButtonPressed(
  //     onChangePassButtonPressed event,
  //     Emitter<AuthenticationState> emit) async {
  //   emit(AuthenticationInitial(loading: true));
  //   try {
  //     await ApiServices().chnagePassApi(
  //         id: event.id,
  //         password: event.password,
  //         old_password: event.old_password);
  //     emit(AuthenticationInitial(loading: false));
  //   } catch (e) {
  //     emit(AuthenticationInitial(loading: false));
  //   }
  // }
  //
  // Future<FutureOr<void>> _onEmailSubmitButtonPressed(
  //     onEmailSubmitButtonPressed event,
  //     Emitter<AuthenticationState> emit) async {
  //   emit(AuthenticationInitial(loading: true));
  //   try {
  //     ApiServices().getChangePasswordDetails(email: event.email);
  //     emit(AuthenticationInitial(loading: false));
  //   } catch (e) {
  //     emit(AuthenticationInitial(loading: false));
  //   }
  // }
}
