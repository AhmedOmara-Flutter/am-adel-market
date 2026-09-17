import 'package:am_adel_market/core/utils/app_imports.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _headerAnim;
  late Animation<double> _formAnim;
  late Animation<double> _socialAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _headerAnim = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
    );
    _formAnim = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 0.7, curve: Curves.easeOut),
    );
    _socialAnim = CurvedAnimation(
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
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildAnimated(
                animation: _headerAnim,
                child: Column(
                  children: [
                    SizedBox(height: 300.h),
                    // Text("أهلاً بيك 👋", style: StyleManager.font19Weight700),
                    // SizedBox(height: 8.h),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 16.w),
                    //   child: Text(
                    //     "سجل دخولك واستمتع بأفضل الكريبات والبيتزا",
                    //     textAlign: TextAlign.center,
                    //     style: StyleManager.font13Weight600,
                    //   ),
                    // ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              _buildAnimated(animation: _formAnim, child: const LoginForm()),
              SizedBox(height: 32.h),
              _buildAnimated(
                animation: _socialAnim,
                child: const DontHaveAccountSection(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
