import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_game/constants/app_colors.dart';
import 'package:my_game/features/brain_tap/models/number_model.dart';

class FlipCard extends StatefulWidget {
  final NumberModel numberIndex;

  const FlipCard({Key? key, required this.numberIndex}) : super(key: key);

  @override
  _FlipCardState createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFlipped = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  void _flipCard() {
    // if (_isFlipped) {
    //   _controller.reverse();
    // }
    if (!_isFlipped) {
      _controller.forward();
    }
    _isFlipped = true;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildFront() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.blackColor),
          borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: Text(
          widget.numberIndex.number.toString(),
          style: TextStyle(
              // decoration: TextDecoration.lineThrough,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: widget.numberIndex.numberColor),
        ),
      ),
    );
  }

  Widget _buildBack() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.blackColor),
          borderRadius: BorderRadius.circular(8),
          color: AppColors.blackColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flipCard,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final angle = _animation.value;
          final isBack = angle > pi / 2;

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            child: isBack
                ? Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(pi),
                    child: _buildBack(),
                  )
                : _buildFront(),
          );
        },
      ),
    );
  }
}
