import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;

// 翻转方向
enum FlipDirection { up, down }

// 面向流的itemBuilder
typedef Widget StreamItemBuilder<T>(BuildContext context, T);

class FlipBoard<T> extends StatefulWidget {
  final EdgeInsets spacing;
  final Duration duration;
  final FlipDirection direction;
  final StreamItemBuilder<T> itemBuilder;
  final Stream<T> stream;
  final T initValue;
  final Cubic curves;

  const FlipBoard({
    Key? key,
    required this.itemBuilder,
    required this.stream,
    required this.initValue,
    this.curves = Curves.easeInOut,
    this.spacing = const EdgeInsets.only(top: .5),
    this.duration = const Duration(milliseconds: 450),
    this.direction = FlipDirection.up,
  }) : super(key: key);

  @override
  _FlipBoardState<T> createState() => _FlipBoardState<T>();
}

class _FlipBoardState<T> extends State<FlipBoard<T>>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  bool _isAnimationReserve = false;
  late T _currentValue, _nextValue;
  bool _isFlipping = false;
  late StreamSubscription<T> _subscription;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initValue;
    _nextValue = _currentValue;
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
          _isAnimationReserve = true;
        }
        if (status == AnimationStatus.dismissed) {
          _isAnimationReserve = false;
          _currentValue = _nextValue;
          _isFlipping = false;
        }
      })
      ..addListener(() {
        setState(() {
          _isFlipping = false;
        });
      });
    // 做一个插值器处理
    CurvedAnimation curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.curves,
    );
    // 角度在0-pi/2 即在0-90度之间进行转变
    _animation =
        Tween(begin: 0.0001, end: math.pi / 2).animate(curvedAnimation);
    // 订阅流
    _subscription = widget.stream.listen((value) {
      if (_currentValue == null) {
        _currentValue = value;
      } else if (value != _currentValue) {
        _nextValue = value;
        _isAnimationReserve = false;
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTopHalf(),
        Padding(padding: widget.spacing),
        _buildBottomHalf(),
      ],
    );
  }

  /// 构建上半部分
  Widget _buildTopHalf() {
    return Stack(
      children: [
        ClipRect(
          child: Align(
            alignment: Alignment.topCenter,
            heightFactor: .5,
            child: widget.itemBuilder(context, _getBuilderValue(true, false)),
          ),
        ),
        Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.006)
            ..rotateX(_getRotateX(true)),
          alignment: Alignment.bottomCenter,
          child: ClipRect(
            child: Align(
              alignment: Alignment.topCenter,
              heightFactor: .5,
              child: widget.itemBuilder(context, _getBuilderValue(true, true)),
            ),
          ),
        ),
      ],
    );
  }

  /// 构造下半部分
  Widget _buildBottomHalf() {
    return Stack(
      children: [
        ClipRect(
          child: Align(
            alignment: Alignment.bottomCenter,
            heightFactor: .5,
            child: widget.itemBuilder(context, _getBuilderValue(false, false)),
          ),
        ),
        Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.006)
            ..rotateX(_getRotateX(false)),
          alignment: Alignment.topCenter,
          child: ClipRect(
            child: Align(
              alignment: Alignment.bottomCenter,
              heightFactor: .5,
              child: widget.itemBuilder(context, _getBuilderValue(false, true)),
            ),
          ),
        ),
      ],
    );
  }

  /// 获取当前旋转的角度 方向、上下、动画是否翻转为判定条件
  double _getRotateX(bool isTop) {
    if (widget.direction == FlipDirection.up) {
      if (isTop) {
        return _isAnimationReserve ? _animation.value : math.pi / 2;
      } else {
        return _isAnimationReserve ? math.pi / 2 : -_animation.value;
      }
    } else {
      if (isTop) {
        return _isAnimationReserve ? math.pi / 2 : _animation.value;
      } else {
        return _isAnimationReserve ? -_animation.value : math.pi / 2;
      }
    }
  }

  /// 通过方向，上下部分，是否为翻转部分来获取当前item所需要的值
  T _getBuilderValue(bool isTop, bool isFlipHalf) {
    if (widget.direction == FlipDirection.up) {
      if (isTop) {
        return isFlipHalf ? _nextValue : _currentValue;
      } else {
        return isFlipHalf ? _currentValue : _nextValue;
      }
    } else {
      if (isTop) {
        return isFlipHalf ? _currentValue : _nextValue;
      } else {
        return isFlipHalf ? _nextValue : _currentValue;
      }
    }
  }
}
