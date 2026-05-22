import 'package:flutter/material.dart';

class AnimatedAppear extends StatefulWidget {
  final Widget child;

  /// Delay before animation starts
  final Duration delay;

  /// Total animation duration
  final Duration duration;

  /// Starting offset for slide animation
  final Offset beginOffset;

  /// Curve of animation
  final Curve curve;

  /// Enable/disable fade effect
  final bool fade;

  /// Enable/disable slide effect
  final bool slide;

  /// Enable/disable scale effect
  final bool scale;

  const AnimatedAppear({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 300),
    this.beginOffset = const Offset(0, 0.08),
    this.curve = Curves.easeOutCubic,
    this.fade = true,
    this.slide = true,
    this.scale = false,
  });

  @override
  State<AnimatedAppear> createState() => _AppAppearAnimationState();
}

class _AppAppearAnimationState extends State<AnimatedAppear>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _fadeAnimation;

  late final Animation<Offset> _slideAnimation;

  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _slideAnimation = Tween<Offset>(
      begin: widget.beginOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _scaleAnimation = Tween<double>(
      begin: 0.95,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _startAnimation();
  }

  Future<void> _startAnimation() async {
    if (widget.delay != Duration.zero) {
      await Future.delayed(widget.delay);
    }

    if (mounted) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget current = widget.child;

    if (widget.scale) {
      current = ScaleTransition(scale: _scaleAnimation, child: current);
    }

    if (widget.slide) {
      current = SlideTransition(position: _slideAnimation, child: current);
    }

    if (widget.fade) {
      current = FadeTransition(opacity: _fadeAnimation, child: current);
    }

    return current;
  }
}
