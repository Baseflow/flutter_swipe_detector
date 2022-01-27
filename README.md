# Flutter Swipe Detector
## Author: [Jop Middelkamp](https://github.com/jopmiddelkamp)

A package to detect your swipe directions and provides you with callbacks to handle them.

## Usage

```dart
SwipeDetector(
  onSwipe: (direction, offset) {
    _addSwipe(direction);
  },
  onSwipeUp: (offset) {
    _addSwipe(SwipeDirection.up);
  },
  onSwipeDown: (offset) {
    _addSwipe(SwipeDirection.down);
  },
  onSwipeLeft: (offset) {
    _addSwipe(SwipeDirection.left);
  },
  onSwipeRight: (offset) {
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
