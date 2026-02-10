import 'package:dio/dio.dart';
import 'package:docdoc_app/core/const/api_const.dart';
import 'package:docdoc_app/features/auth/register/data/auth_response.dart';
import 'package:docdoc_app/features/auth/register/data/user_model.dart';
import 'package:docdoc_app/features/auth/register/logic/state.dart' show RegisterStates, RegisterInitialState, RegisterLoadingState, RegisterSuccessState, RegisterErrorState;
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  Dio dio = Dio();

  Future register(UserModel user) async {
    emit(RegisterLoadingState());
    try {
      final response = await dio.post(APIConst.register, data: user.toJson());
      if (response.statusCode == 200) {
        final auth = AuthResponse.fromJson(response.data);
        emit(RegisterSuccessState(
          token: auth.data?.token ?? "",
          userName: auth.data?.username ?? "",
        ));
      }
    }on DioException catch (e) {
      final data = e.response?.data;

      String message = "Something went wrong";

      if (data is Map && data['data'] != null) {
        if (data['data']['email'] != null) {
          message = data['data']['email'][0];
        }
      }

      emit(RegisterErrorState(errorMessage: message));
    }
  }
}
