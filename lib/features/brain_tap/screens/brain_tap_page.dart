import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: double.infinity,
          child: BlocProvider<BrainTabCubit>(
              create: (context) => BrainTabCubit(),
              child: BlocBuilder<BrainTabCubit, BrainTabState>(
                  builder: (context, state) {
                var brainTabCubit = context.read<BrainTabCubit>();
                if (state is BrainTapGameIndexState) {
                  return SelectGameIndex(
                    allGameIndex: brainTabCubit.allGameIndex,
                    onTap: (index) {
                      brainTabCubit.changeGameIndex(index);
                    },
                  );
                }
                if (state is BrainTapGamesState) {
                  return BrainTapGameWidget(
                    allNumber: brainTabCubit.allNumber,
                    gridviewCrossAxisCount:
                        brainTabCubit.gridviewCrossAxisCount,
                    timerCounter: brainTabCubit.selectedGameIndex -
                        brainTabCubit.timerCount,
                    timerPercentage: brainTabCubit.getTimerPercentage() ?? 0.4,
                    onTap: (tapValue) {
                      brainTabCubit.tapNumber(tapValue);
                    },
                  );
                }
                if (state is BrainTapGameOverState) {
                  return BrainTapGameOverWidget(
                    onRestart: () {
                      brainTabCubit.restartGame();
                    },
                    isGameWin: brainTabCubit.playerWin,
                  );
                }
                return const Center(child: CircularProgressIndicator());
              })),
        ),
      ),
    );
  }
}
