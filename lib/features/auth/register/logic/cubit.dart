import 'package:dio/dio.dart';
import 'package:docdocapp97/core/const/api_const.dart';
import 'package:docdocapp97/features/auth/register/data/user_model.dart';
import 'package:docdocapp97/features/auth/register/logic/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  Dio dio = Dio();

  Future register(UserModel user) async {
    emit(RegisterLoadingState());
    try {
      final response = await dio.post(APIConst.register, data: user.toJson());
      if (response.statusCode == 200) {
        emit(RegisterSuccessState());
      }
    } catch (e) {
      print("==========register error $e");
      emit(RegisterErrorState(errorMessage: e.toString()));
    }
  }
}
