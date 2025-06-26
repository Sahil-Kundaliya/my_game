import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_game/constants/app_colors.dart';
import 'package:my_game/features/brain_tap/cubits/brain_tap_cubit.dart';
import 'package:my_game/features/brain_tap/cubits/brain_tap_state.dart';
import 'package:my_game/features/brain_tap/widgets/brain_tap_game_break_widget.dart';
import 'package:my_game/features/brain_tap/widgets/brain_tap_game_widget.dart';
import 'package:my_game/features/brain_tap/widgets/brain_tap_game_over_widget.dart';
import 'package:my_game/features/brain_tap/widgets/select_game_index.dart';

class BrainTapScreen extends StatelessWidget {
  const BrainTapScreen({super.key});
  static const String brainTapScreen = '/BrainTapScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BrainTabCubit>(
      create: (context) => BrainTabCubit(),
      child:
          BlocBuilder<BrainTabCubit, BrainTabState>(builder: (context, state) {
        var brainTabCubit = context.read<BrainTabCubit>();
        return Stack(
          children: [
            Scaffold(
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
                  child: Builder(builder: (context) {
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

                    if (state is BrainTapBreakState) {
                      return BrainTapGameBreakWidget(
                        nextLevel: brainTabCubit
                            .allGameLevel[brainTabCubit.selectedGameIndex + 1],
                        breakTime: brainTabCubit.breakTimerCount.toString(),
                      );
                    }
                    if (state is BrainTapGameOverState) {
                      return BrainTapGameOverWidget(
                        onRestart: () {
                          brainTabCubit.restartGame();
                        },
                        isGameWin: brainTabCubit.playerWin,
                        lastLevelName: brainTabCubit.allGameLevel.last,
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  }),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter, // Or any position
              child: ConfettiWidget(
                confettiController: brainTabCubit.confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: true,
                emissionFrequency: 0.05, // Adjust for density
                numberOfParticles: 10,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
