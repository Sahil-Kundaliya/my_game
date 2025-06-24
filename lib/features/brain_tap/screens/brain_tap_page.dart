import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_game/constants/app_colors.dart';
import 'package:my_game/constants/app_text_styles.dart';
import 'package:my_game/features/brain_tap/cubits/brain_tap_cubit.dart';
import 'package:my_game/features/brain_tap/cubits/brain_tap_state.dart';
import 'package:my_game/features/brain_tap/widgets/brain_tap_game_widget.dart';
import 'package:my_game/features/brain_tap/widgets/brain_tap_game_over_widget.dart';
import 'package:my_game/features/brain_tap/widgets/select_game_index.dart';

class BrainTapScreen extends StatelessWidget {
  const BrainTapScreen({super.key});
  static const String brainTapScreen = '/BrainTapScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text('Brain Tap'),
        backgroundColor: AppColors.blackColor,
        foregroundColor: AppColors.whiteColor,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: double.infinity,
          child: BlocProvider<BrainTabCubit>(
              create: (context) => BrainTabCubit(),
              child: BlocBuilder<BrainTabCubit, BrainTabState>(
                  builder: (context, state) {
                var brainTabCubit = context.read<BrainTabCubit>();
                if (state is BrainTapInitialState) {
                  return SelectGameIndex(
                    onStart: () {
                      brainTabCubit.nextLevel();
                    },
                  );
                }
                if (state is BrainTapGameState) {
                  return const BrainTapGameWidget();
                }
                if (state is BrainTapGameOverState) {
                  return BrainTapGameOverWidget(
                    onRestart: () {
                      brainTabCubit.restartGame();
                    },
                    isGameWin: brainTabCubit.playerWin,
                  );
                }
                if (state is BrainTapBreakState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Next level\nstart in",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor),
                      ),
                      Text(
                        brainTabCubit.breakTimerCount.toString(),
                        style: AppTextStyles.robotoStyle(
                            fontSize: 130, color: AppColors.redColor),
                      ),
                    ],
                  );
                }
                return const Center(child: CircularProgressIndicator());
              })),
        ),
      ),
    );
  }
}
