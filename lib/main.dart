import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dicee',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
          scaffoldBackgroundColor: Colors.redAccent,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.redAccent,
            elevation: 10,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          useMaterial3: true,
        ),
        home: const DicePage());
  }
}

class DicePage extends StatefulWidget {
  const DicePage({super.key});

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  String image1 = 'assets/dice1.png';
  String image2 = 'assets/dice1.png';
  double angle = 0;
  int selected = 0;

  String value = 'single';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: const Text("Dicee"),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: SizedBox(
              width: constraints.maxWidth > constraints.maxHeight ? constraints.maxHeight : constraints.maxWidth,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selected = 0;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                // borderRadius: BorderRadius.circular(10),
                                border: BorderDirectional(
                                  bottom: selected == 0
                                      ? const BorderSide(
                                          color: Colors.white,
                                          width: 5,
                                        )
                                      : BorderSide.none,
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'Single',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selected = 1;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                // borderRadius: BorderRadius.circular(10),
                                border: BorderDirectional(
                                  bottom: selected == 1
                                      ? const BorderSide(
                                          color: Colors.white,
                                          width: 5,
                                        )
                                      : BorderSide.none,
                                ),
                              ),
                              child: const Center(
                                  child: Text(
                                'Double',
                                style: TextStyle(fontSize: 20, color: Colors.white),
                              )),
                            ),
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Spacer(
                          flex: 1,
                        ),
                        Expanded(
                          flex: 4,
                          child: AnimatedContainer(
                            // width: double.infinity / 2,
                            duration: const Duration(milliseconds: 200),
                            child: Transform.rotate(
                              angle: angle,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(image1),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: selected == 1,
                          child: Expanded(
                            flex: 4,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              child: Transform.rotate(
                                angle: angle,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(image2),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(
                          flex: 1,
                        )
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 30,
                          ),
                        ),
                        onPressed: () async {
                          await changeAngle();
                          rollDice();
                        },
                        child: const Text(
                          "Roll Dice!",
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  void rollDice() {
    int random = math.Random().nextInt(6) + 1;
    int random2 = math.Random().nextInt(6) + 1;
    // print(random);
    setState(() {
      image1 = 'assets/dice$random.png';
      image2 = 'assets/dice$random2.png';
    });
  }

  Future<void> changeAngle() async {
    await Future.delayed(const Duration(milliseconds: 20), () {
      setState(() {
        if (angle >= 360) {
          angle = 0;
        } else {
          angle = angle + 45;
          changeAngle();
        }
      });
    });
  }
}
