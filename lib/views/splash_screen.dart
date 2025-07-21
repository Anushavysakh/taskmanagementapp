// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:taskmanagement/main.dart';
//
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(vsync: this);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Lottie.asset(
//           'assets/animation.json',
//           controller: _controller,
//           onLoaded: (composition) {
//             _controller
//               ..duration = composition.duration
//               ..forward().whenComplete(() => Navigator.pushReplacement(
//                 context,
//               //   MaterialPageRoute(builder: (context) => MyHomePage(title: "sdfgas")),
//               // ));
//           },
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }