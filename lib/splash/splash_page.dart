import 'package:my_game/splash/cubits/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/splash_cubits.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(context),
      child: BlocBuilder<SplashCubit, SplashState>(
        builder: (context, state) {
          if (state is SplashPageState) {
            return const Scaffold(
              body: Center(
                child: FlutterLogo(),
              ),
            );
          } else {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}

//  void initState() {
//     super.initState();
//     Future.delayed(const Duration(seconds: 3)).then(
//       (value) {
//         return Navigator.of(context).pushNamed(MyHomePage.myHomePage);
//       },
//     );
//   }
