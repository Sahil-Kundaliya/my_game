// import 'package:flutter/material.dart';
// import 'package:my_game/constants/app_colors.dart';

// class CurrentIndicatorWidget extends StatelessWidget {
//   const CurrentIndicatorWidget(
//       {super.key, required this.isCurrentIndex, this.isLastIndex});
//   final bool isCurrentIndex;
//   final bool? isLastIndex;

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           CircleAvatar(
//             radius: 14,
//             backgroundColor:
//                 isCurrentIndex ? AppColors.redColor : AppColors.greyColor,
//             child: CircleAvatar(
//               radius: 12,
//               backgroundColor:
//                   !isCurrentIndex ? AppColors.redColor : AppColors.whiteColor,
//             ),
//           ),
//           if (isLastIndex == null)
//             Flexible(
//               flex: 1,
//               child: Container(
//                   height: 4,
//                   color: isCurrentIndex
//                       ? AppColors.redColor
//                       : AppColors.greyColor),
//             )
//         ],
//       ),
//     );
//   }
// }
