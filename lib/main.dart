import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expanding Rectangle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  double _height = 150;
  double _width = 50;
  Color _color = Colors.red;

  void changeHeight() {
    setState(() {
      _height = _height == 50 ? 150 : 50;
    });
  }

  void changeWidth() {
    setState(() {
      _width = _width == 50 ? 150 : 50;
    });
  }

  void changeColor() {
    setState(() {
      _color = getRandomColor();
    });
  }

  Color getRandomColor() => Color(
        0xFF000000 +
            math.Random().nextInt(
              0x00FFFFFF,
            ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 43, 34, 43),
      body: Center(
        child: TweenAnimationBuilder(
          tween: ColorTween(begin: getRandomColor(), end: _color),
          onEnd: () {
            changeColor();
          },
          duration: const Duration(seconds: 1),
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 50, end: _height),
            duration: const Duration(seconds: 1),
            onEnd: () {
              changeHeight();
            },
            builder: (context, double height, child) {
              return TweenAnimationBuilder(
                tween: Tween<double>(begin: 150, end: _width),
                duration: const Duration(seconds: 1),
                onEnd: () {
                  changeWidth();
                },
                builder: (context, double width, child) {
                  return Container(
                    color: _color,
                    height: height,
                    width: width,
                  );
                },
              );
            },
          ),
          builder: (context, Color? value, child) {
            return ColorFiltered(
              colorFilter: ColorFilter.mode(
                value ?? getRandomColor(),
                BlendMode.srcATop,
              ),
              child: child!,
            );
          },
        ),
      ),
    );
  }
}
