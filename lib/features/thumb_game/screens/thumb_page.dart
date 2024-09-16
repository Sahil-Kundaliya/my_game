import 'package:dazll_demo/constants/app_colors.dart';
import 'package:dazll_demo/features/thumb_game/cubits/thumb_cubit.dart';
import 'package:dazll_demo/features/thumb_game/cubits/thumb_state.dart';
import 'package:dazll_demo/utils/dimens.dart';
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
            body: state is ThumbStateInitialState
                ? const CircularProgressIndicator()
                : Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          thumbCubit.updateScore(player1: false);
                        },
                        child: Container(
                          width: Dimenstions.instance.screenWidth,
                          height: thumbCubit.player_2Score,
                          decoration:
                              const BoxDecoration(color: AppColors.blueColor),
                          child: thumbCubit.winner == 'Blue'
                              ? const Center(
                                  child: Text(
                                    'Blue Win',
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: AppColors.blackColor),
                                  ),
                                )
                              : const SizedBox(),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          thumbCubit.updateScore(player1: true);
                        },
                        child: Container(
                          width: Dimenstions.instance.screenWidth,
                          height: thumbCubit.player_1Score,
                          decoration:
                              const BoxDecoration(color: AppColors.redColor),
                          child: thumbCubit.winner == 'Red'
                              ? const Center(
                                  child: Text(
                                    'Red Win',
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: AppColors.blackColor),
                                  ),
                                )
                              : const SizedBox(),
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
