# Flutter Swipe Detector
## Author: [Jop Middelkamp](https://github.com/jopmiddelkamp)

A package to detect your swipe directions and provides you with callbacks to handle them.

## Usage

```dart
SwipeDetector(
  onSwipe: (direction) {
    _addSwipe(direction);
  },
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
  child: const Container(
    padding: EdgeInsets.all(16),
    child: Text(
      'Swipe me!',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),
```
