import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:am_adel_market/core/utils/app_color.dart';

class LoadingPage extends StatefulWidget {
  final LoadingPageArgs args;

  const LoadingPage({
    super.key,
    required this.args,
  });

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;

  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: .85,
      end: 1.1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _fadeAnimation = Tween<double>(
      begin: .5,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _timer = Timer(const Duration(seconds: 2), () {
      if (!mounted) return;

      Navigator.pushNamedAndRemoveUntil(
        context,
        widget.args.nextRoute,
            (_) => false,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (_, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Opacity(
                      opacity: _fadeAnimation.value,
                      child: child,
                    ),
                  );
                },
                child: SizedBox(
                  width: 38.w,
                  height: 38.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 3,
                    color: AppColor.mainColor,
                  ),
                ),
              ),

              SizedBox(height: 22.h),

              Text(
                widget.args.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColor.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 8.h),

              Text(
                widget.args.subTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColor.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoadingPageArgs {
  final String title;
  final String subTitle;
  final String nextRoute;

  const LoadingPageArgs({
    required this.title,
    required this.subTitle,
    required this.nextRoute,
  });
}