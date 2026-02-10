class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final String token;
  final String userName;

  LoginSuccessState({
    required this.token,
    required this.userName,
  });
}

class LoginErrorState extends LoginStates {
  final String errorMessage;

  LoginErrorState({required this.errorMessage});
}