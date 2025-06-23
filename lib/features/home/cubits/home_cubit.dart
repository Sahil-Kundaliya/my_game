import 'package:my_game/constants/app_images.dart';
import 'package:my_game/features/brain_tap/screens/brain_tap_page.dart';
import 'package:my_game/features/home/cubits/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_game/features/home/models/game_list_model.dart';
import 'package:my_game/features/thumb_game/screens/thumb_page.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState()) {
    loadingGames();
  }

  loadingGames() async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 0));
    emit(HomeShowGamesState());
  }

  selectGame({required String gameUrl, required BuildContext context}) {
    if (gameUrl.isNotEmpty) {
      Navigator.pushNamed(context, gameUrl);
    }
  }

  List<GameListModel> gameList = [
    GameListModel(
        gameName: "Brain Tap",
        gameImage: AppImages.brainTapGameImage,
        gameIndex: 101,
        gamePageUrl: BrainTapScreen.brainTapScreen),
    GameListModel(
        gameName: "Thumb Game",
        gameImage: AppImages.thumbGameImage,
        gameIndex: 102,
        gamePageUrl: ThumbGameScreen.thumbGameScreen),
    // GameListModel(
    //     gameName: "Number Game",
    //     gameImage: AppImages.brainTapGameImage,
    //     gameIndex: 102,
    //     gamePageUrl: NumberGameScreen.numberGameScreen),
    // GameListModel(
    //     gameName: "Tic Tac Toe",
    //     gameImage: AppImages.brainTapGameImage,
    //     gameIndex: 102,
    //     gamePageUrl: TicTacToeGameScreen.ticTacToeGameScreen),
  ];
}
