import 'package:dio/dio.dart';
import 'package:docdoc_app/core/const/api_const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../register/data/auth_response.dart';
import '../data/login_model.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  final Dio dio = Dio();

  Future<void> login(LoginModel model) async {
    emit(LoginLoadingState());

    try {
      final response = await dio.post(
        APIConst.login,
        data: model.toJson(),
      );

      if (response.statusCode == 200) {
        final auth = AuthResponse.fromJson(response.data);

        emit(LoginSuccessState(
          token: auth.data?.token ?? "",
          userName: auth.data?.username ?? "",
        ));
      } else {
        emit(LoginErrorState(errorMessage: "Unexpected status code"));
      }
    } on DioException catch (e) {
      final data = e.response?.data;

      String message = "Something went wrong";

      if (data is Map) {
        // لو backend بيرجع errors
        if (data["message"] != null) {
          message = data["message"].toString();
        } else if (data["errors"] != null && data["errors"] is Map) {
          final errors = data["errors"] as Map;
          if (errors["email"] != null) message = errors["email"][0].toString();
          if (errors["password"] != null) message = errors["password"][0].toString();
        }
      }

      emit(LoginErrorState(errorMessage: message));
    } catch (_) {
      emit(LoginErrorState(errorMessage: "Unexpected error"));
    }
  }
}