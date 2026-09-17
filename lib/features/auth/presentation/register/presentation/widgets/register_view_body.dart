import 'package:am_adel_market/core/utils/app_imports.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _formAnim;
  late Animation<double> _footerAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _formAnim = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 0.7, curve: Curves.easeOut),
    );

    _footerAnim = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimated({
    required Animation<double> animation,
    required Widget child,
    double offset = 20,
  }) {
    return FadeTransition(
      opacity: animation,
      child: AnimatedBuilder(
        animation: animation,
        child: child,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, offset.h * (1 - animation.value)),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              const InfoActionRow(text: '', showBack: true, bottomPadding: 0),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 300.h),

                    _buildAnimated(
                      animation: _formAnim,
                      child: const RegisterForm(),
                    ),

                    SizedBox(height: 32.h),

                    _buildAnimated(
                      animation: _footerAnim,
                      child: const CustomAuthFooter(),
                    ),

                    SizedBox(height: 45.h),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
