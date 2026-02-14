import '../data/home_data_model.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeSuccessState extends HomeStates {
  final List<Data> homeData;
  HomeSuccessState({required this.homeData});
}

class HomeErrorState extends HomeStates {
  final String errorMessage;
  HomeErrorState({required this.errorMessage});
}
