import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const int _swipeHistoryLimit = 4;
  final List<SwipeDirection> _swipeHistory = [];

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SwipeDetector(
              // onSwipe: (direction) {
              //   _addSwipe(direction);
              // },
              onSwipeUp: () {
                _addSwipe(SwipeDirection.up);
              },
              onSwipeDown: () {
                _addSwipe(SwipeDirection.down);
              },
              onSwipeLeft: () {
                _addSwipe(SwipeDirection.left);
              },
              onSwipeRight: () {
                _addSwipe(SwipeDirection.right);
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.5,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.greenAccent,
                ),
                child: Column(
                  children: [
                    const Text(
                      'Swipe me!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ..._swipeHistory
                        .map<Widget>(
                          (direction) => Padding(
                            padding: const EdgeInsets.only(
                              top: 8,
                            ),
                            child: Text(
                              describeEnum(direction),
                            ),
                          ),
                        )
                        .toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addSwipe(
    SwipeDirection direction,
  ) {
    setState(() {
      _swipeHistory.insert(0, direction);
      if (_swipeHistory.length > _swipeHistoryLimit) {
        _swipeHistory.removeLast();
      }
    });
  }
}
