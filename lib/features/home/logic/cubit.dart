import 'package:dio/dio.dart';
import 'package:docdoc_app/core/const/api_const.dart';
import 'package:docdoc_app/features/home/data/home_data_model.dart';
import 'package:docdoc_app/features/home/logic/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  final Dio dio = Dio();

  Future<void> getHomeData() async {
    emit(HomeLoadingState());

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token") ?? "";

      if (token.isEmpty) {
        emit(HomeErrorState(errorMessage: "No token found. Please login again."));
        return;
      }

      final response = await dio.get(
        APIConst.home,
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );

      if (response.statusCode == 200) {
        final data = HomeDataModel.fromJson(response.data);

        emit(HomeSuccessState(homeData: data.data ?? []));
      } else {
        emit(HomeErrorState(errorMessage: "Unexpected status code: ${response.statusCode}"));
      }
    } catch (e) {
      emit(HomeErrorState(errorMessage: "Something went wrong"));
    }
  }
}
