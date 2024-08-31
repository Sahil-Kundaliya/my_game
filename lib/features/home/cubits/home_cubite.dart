import 'package:dazll_demo/features/home/cubits/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState()) {
    loadingGames();
  }
  List<String> allGames = [
    'Game 1',
    'Game 2',
    'Game 3',
    'Game 4',
  ];

  loadingGames() async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    emit(HomeShowGamesState());
  }

  selectGame({required BuildContext context}) {
    Navigator.of(context).pushNamed('routeName');
  }
}
