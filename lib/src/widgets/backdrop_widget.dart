// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:weather/style/styles.dart';

// class BackDropWidget extends StatelessWidget {
//   const BackDropWidget({Key? key,required this.child,this.borderCircularRadius,this.padding}) : super(key: key);
//   final Widget child;
//   final double? borderCircularRadius;
//   final EdgeInsetsGeometry? padding;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: padding??const EdgeInsets.all(0.0),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(borderCircularRadius??0.0),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX:0.1,sigmaY:0.1),
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(borderCircularRadius??0.0),
//               color: backdropColor
//             ),
//             padding: const EdgeInsets.all(10.0),
//             child: child,
//           ),
//         ),
//       ),
//     );
//   }
// }