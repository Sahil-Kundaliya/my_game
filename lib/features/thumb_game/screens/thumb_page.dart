import 'package:my_game/constants/app_colors.dart';
import 'package:my_game/features/thumb_game/cubits/thumb_cubit.dart';
import 'package:my_game/features/thumb_game/cubits/thumb_state.dart';
import 'package:my_game/features/thumb_game/widgets/game_intro_page.dart';
import 'package:my_game/features/thumb_game/widgets/game_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThumbGameScreen extends StatelessWidget {
  const ThumbGameScreen({super.key});
  static const String thumbGameScreen = '/ThumbGameScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThumbCubit(context: context),
      child: BlocBuilder<ThumbCubit, ThumbState>(
        builder: (context, state) {
          ThumbCubit thumbCubit = context.read<ThumbCubit>();
          WidgetsBinding.instance.addPersistentFrameCallback(
            (timeStamp) {
              if (!thumbCubit.dataSet) {
                thumbCubit.loadPlayerData(context: context);
              }
            },
          );
          return Scaffold(
            backgroundColor: AppColors.blackColor,
            appBar: state is ThumbGameInfoState
                ? AppBar(
                    leading: const SizedBox(),
                    title: const Text("Thumb Game"),
                    backgroundColor: AppColors.blackColor,
                    foregroundColor: AppColors.whiteColor,
                    centerTitle: true,
                  )
                : null,
            body: Builder(
              builder: (context) {
                if (state is ThumbStateInitialState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is ThumbGameInfoState) {
                  return SafeArea(
                    child: GameIntroPage(
                      onStart: () {
                        thumbCubit.startGame();
                      },
                    ),
                  );
                }
                if (state is ThumbGameState) {
                  return GamePage(
                    player1Score: thumbCubit.player1Score,
                    player2Score: thumbCubit.player2Score,
                    winner: thumbCubit.winner,
                    player1Tap: () {
                      thumbCubit.updateScore(player1: true, context: context);
                    },
                    player2Tap: () {
                      thumbCubit.updateScore(player1: false, context: context);
                    },
                  );
                }

                return const SizedBox(
                  child: Center(child: Text('Try again')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
