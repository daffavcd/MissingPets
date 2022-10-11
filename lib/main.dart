import 'package:flutter/material.dart';
import 'components/first_image.dart';
import 'pages/first_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MaterialApp(home: MyApp()));
}

class AnimatedLogo extends AnimatedWidget {
  // Constructor
  const AnimatedLogo({super.key, required Animation<double> animation})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: animation.value,
        height: animation.value,
        child: const FirstImage(),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 900), vsync: this);
    animation = Tween<double>(begin: 0, end: 500).animate(controller)
      ..addStatusListener((status) => {
            if (status == AnimationStatus.completed)
              {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FirstPage(),
                  ),
                )
              }
            else if (status == AnimationStatus.dismissed)
              {controller.forward()}
          });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: AnimatedLogo(animation: animation),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
