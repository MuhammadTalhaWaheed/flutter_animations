import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const FadeInDemo()
      // home: const LogoApp(), // Pass control to LogoApp, which will create the animation
      home: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [LogoApp(), ImplicitLogoApp()],
      ),
    );
  }
}

class LogoApp extends StatefulWidget {
  const LogoApp({super.key});

  @override
  State<LogoApp> createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 300).animate(controller);
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose(); // Clean up the controller to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedLogo(
        animation: animation); // Pass the animation to AnimatedLogo
  }
}

class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo({super.key, required Animation<double> animation})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: const FlutterLogo(),
      ),
    );
  }
}

class ImplicitLogoApp extends StatefulWidget {
  const ImplicitLogoApp({super.key});

  @override
  State<ImplicitLogoApp> createState() => _ImplicitLogoState();
}

class _ImplicitLogoState extends State<ImplicitLogoApp> {
  double opacity = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: Duration(seconds: 3),
      child: Image.network(
        "https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/PrimeMinisterNawazSharif.jpg/475px-PrimeMinisterNawazSharif.jpg",
        width: 500,
        height: 500,
      ),
    );
  }
}
