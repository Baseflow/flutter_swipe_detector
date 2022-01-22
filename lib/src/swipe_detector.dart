import 'package:flutter/material.dart';

/// Detects user swipes.
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
  /// Creates a [SwipeDetector] which can be used to detects user swipes.
  ///
  /// behavior: How this gesture detector should behave during hit testing.
  ///
  /// onSwipe: Called when the user has swiped in a particular direction.
  ///
  /// onSwipeUp: Called when the user has swiped upwards.
  ///
  /// onSwipeDown: Called when the user has swiped downwards.
  ///
  /// onSwipeLeft: Called when the user has swiped left.
  ///
  /// onSwipeRight: Called when the user has swiped right.
  ///
  /// Attempts to recognize swipes that correspond to its non-null callbacks.
  /// Usage example:
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
  const SwipeDetector({
    Key? key,
    this.behavior,
    this.onSwipe,
    this.onSwipeUp,
    this.onSwipeDown,
    this.onSwipeLeft,
    this.onSwipeRight,
    this.updatable = false,
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
  final void Function(double yAxis)? onSwipeUp;

  /// Called when the user has swiped downwards.
  final void Function(double yAxis)? onSwipeDown;

  /// Called when the user has swiped to the left.
  final void Function(double xAxis)? onSwipeLeft;

  /// Called when the user has swiped to the right.
  final void Function(double xAxis)? onSwipeRight;

  /// If true, the callbacks are called every time the gesture gets updated
  /// and provide an axis value in each callback.
  ///
  /// Otherwise, callbacks are called only when the gesture is ended.
  final bool updatable;

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
        if (widget.updatable) {
          _calculateAndExecute();
        }
      },
      onPanEnd: (details) {
        _calculateAndExecute();
      },
      child: widget.child,
    );
  }

  void _calculateAndExecute() {
    final delta = _updatePosition - _startPosition;
    final direction = _getSwipeDirection(delta);
    _executeCallbacks(direction, _updatePosition);
  }

  void _executeCallbacks(SwipeDirection direction, Offset offset) {
    widget.onSwipe?.call(direction);

    switch (direction) {
      case SwipeDirection.up:
        widget.onSwipeUp?.call(offset.dy);
        break;
      case SwipeDirection.down:
        widget.onSwipeDown?.call(offset.dy);
        break;
      case SwipeDirection.left:
        widget.onSwipeLeft?.call(offset.dx);
        break;
      case SwipeDirection.right:
        widget.onSwipeRight?.call(offset.dx);
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
  /// Swipe up.
  up,

  /// Swipe down.
  down,

  /// Swipe left.
  left,

  /// Swipe right.
  right,
}
