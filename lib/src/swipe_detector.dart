import 'package:flutter/material.dart';

/// A widget that detects swipes.
///
/// Attempts to recognize swipes that correspond to its non-null callbacks.
///
/// ```dart
/// Widget build(BuildContext context) {
///   return Scaffold(
///     body: SwipeDetector(
///       onSwipe: (direction) {
///         setState(() {
///           _swipeHistory.insert(0, direction);
///           if (_swipeHistory.length > _swipeHistoryLimit) {
///             _swipeHistory.removeLast();
///           }
///         });
///       },
///       child: Container(
///         color: Colors.yellow.shade600,
///         padding: const EdgeInsets.all(16),
///         child: const Text(
///           'Swipe me!',
///         ),
///       ),
///     ),
///   );
/// }
/// ```
/// {@end-tool}
///
/// ## Debugging
///
/// To see how large the hit test box of a [SwipeDetector] is for debugging
/// purposes, set [debugPaintPointersEnabled] to true.
///
/// See also:
///
///  * [GestureDetector], a widget that is used to detect gestures.
class SwipeDetector extends StatefulWidget {
  const SwipeDetector({
    Key? key,
    this.behavior,
    this.onSwipe,
    this.onSwipeUp,
    this.onSwipeDown,
    this.onSwipeLeft,
    this.onSwipeRight,
    required this.child,
  }) : super(key: key);

  /// How this gesture detector should behave during hit testing.
  ///
  /// This defaults to [HitTestBehavior.deferToChild] if [child] is not null and
  /// [HitTestBehavior.translucent] if child is null.
  final HitTestBehavior? behavior;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  /// Called when the user has swiped in a particular direction.
  final void Function(SwipeDirection direction)? onSwipe;

  /// Called when the user has swiped upwards.
  final VoidCallback? onSwipeUp;

  /// Called when the user has swiped downwards.
  final VoidCallback? onSwipeDown;

  /// Called when the user has swiped to the left.
  final VoidCallback? onSwipeLeft;

  /// Called when the user has swiped to the right.
  final VoidCallback? onSwipeRight;

  @override
  _SwipeDetectorState createState() => _SwipeDetectorState();
}

class _SwipeDetectorState extends State<SwipeDetector> {
  late Offset _startPosition;
  late Offset _updatePosition;

  @override
  Widget build(
    BuildContext context,
  ) {
    return GestureDetector(
      behavior: widget.behavior,
      onPanStart: (details) {
        _startPosition = details.globalPosition;
      },
      onPanUpdate: (details) {
        _updatePosition = details.globalPosition;
      },
      onPanEnd: (details) {
        final delta = _updatePosition - _startPosition;
        final direction = _getSwipeDirection(delta);
        _executeCallbacks(direction);
      },
      child: widget.child,
    );
  }

  void _executeCallbacks(SwipeDirection direction) {
    if (widget.onSwipe != null) {
      widget.onSwipe!(direction);
    }
    switch (direction) {
      case SwipeDirection.up:
        if (widget.onSwipeUp != null) {
          widget.onSwipeUp!();
        }
        break;
      case SwipeDirection.down:
        if (widget.onSwipeDown != null) {
          widget.onSwipeDown!();
        }
        break;
      case SwipeDirection.left:
        if (widget.onSwipeLeft != null) {
          widget.onSwipeLeft!();
        }
        break;
      case SwipeDirection.right:
        if (widget.onSwipeRight != null) {
          widget.onSwipeRight!();
        }
        break;
    }
  }

  SwipeDirection _getSwipeDirection(
    Offset delta,
  ) {
    if (delta.dx.abs() > delta.dy.abs()) {
      if (delta.dx > 0) {
        return SwipeDirection.right;
      } else {
        return SwipeDirection.left;
      }
    } else {
      if (delta.dy > 0) {
        return SwipeDirection.down;
      } else {
        return SwipeDirection.up;
      }
    }
  }
}

/// The direction in which the user swiped.
enum SwipeDirection {
  up,
  down,
  left,
  right,
}
