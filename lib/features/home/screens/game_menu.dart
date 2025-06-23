import 'package:my_game/constants/app_colors.dart';
import 'package:my_game/constants/app_images.dart';
import 'package:my_game/constants/app_text_styles.dart';
import 'package:my_game/features/home/cubits/home_cubit.dart';
import 'package:my_game/features/home/cubits/home_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameMenuScreen extends StatelessWidget {
  const GameMenuScreen({super.key});
  static const String gameMenuScreen = '/GameMenuScreen';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var gameBloc = context.read<HomeCubit>();
          if (state is HomeLoadingState) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is HomeShowGamesState) {
            return Scaffold(
              backgroundColor: AppColors.blackColor,
              appBar: AppBar(
                title: const Text('Game Menu'),
                backgroundColor: AppColors.blackColor,
                foregroundColor: AppColors.whiteColor,
                centerTitle: true,
              ),
              body: SizedBox(
                height: size.height,
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.8,
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10),
                    itemCount: gameBloc.gameList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var game = gameBloc.gameList[index];
                      return GestureDetector(
                        onTap: () {
                          context.read<HomeCubit>().selectGame(
                              gameUrl: game.gamePageUrl, context: context);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.customYellowColor,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(game.gameImage))),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Text(game.gameName,
                                  style: AppTextStyles.robotoStyle(
                                      fontSize: 18,
                                      color: AppColors.whiteColor)),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('Game Menu'),
            ),
            body: const Center(
              child: Text('Game Menu'),
            ),
          );
        },
      ),
    );
  }
}
