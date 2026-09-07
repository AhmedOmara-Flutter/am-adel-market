import 'dart:math';

import 'package:flutter/material.dart';

class FallingFlowers extends StatefulWidget {
  const FallingFlowers({super.key});

  @override
  State<FallingFlowers> createState() => _FallingFlowersState();
}
class _FallingFlowersState extends State<FallingFlowers>
    with TickerProviderStateMixin {
  final Random _random = Random();

  final List<_Flower> _flowers = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _createFlowers();
    });
  }

  void _createFlowers() {
    if (!mounted) return;

    for (int i = 0; i < 10; i++) {
      Future.delayed(
        Duration(milliseconds: i * 500),
            () {
          if (!mounted) return;

          final flower = _Flower(
            id: UniqueKey(),
            left: _random.nextDouble(),
            size: 16 + _random.nextDouble() * 12,
            duration: Duration(
              milliseconds: 5000 + _random.nextInt(3000),
            ),
          );

          setState(() {
            _flowers.add(flower);
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: _flowers.map(
              (flower) {
            return _FallingFlower(
              key: flower.id,
              left: flower.left,
              size: flower.size,
              duration: flower.duration,
            );
          },
        ).toList(),
      ),
    );
  }
}

class _Flower {
  final Key id;
  final double left;
  final double size;
  final Duration duration;

  _Flower({
    required this.id,
    required this.left,
    required this.size,
    required this.duration,
  });
}

class _FallingFlower extends StatefulWidget {
  final double left;
  final double size;
  final Duration duration;

  const _FallingFlower({
    super.key,
    required this.left,
    required this.size,
    required this.duration,
  });

  @override
  State<_FallingFlower> createState() => _FallingFlowerState();
}

class _FallingFlowerState extends State<_FallingFlower>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _top;
  late final Animation<double> _rotation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..forward();

    _top = Tween<double>(
      begin: -80,
      end: 1000,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    _rotation = Tween<double>(
      begin: 0,
      end: pi * 2,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final screenWidth = MediaQuery.sizeOf(context).width;

        final horizontalMovement =
            sin(_controller.value * pi * 2) * 30;

        return Positioned(
          top: _top.value,
          left: screenWidth * widget.left + horizontalMovement,
          child: Transform.rotate(
            angle: _rotation.value,
            child: Icon(
              Icons.local_florist,
              size: widget.size,
              color: Colors.pinkAccent.withValues(
                alpha: 0.7,
              ),
            ),
          ),
        );
      },
    );
  }
}