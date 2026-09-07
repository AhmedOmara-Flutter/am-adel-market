import 'package:am_adel_market/core/utils/app_imports.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isPasswordVisible = true;
  bool isValid = false;

  @override
  void initState() {
    super.initState();

    
    emailController.addListener(_checkFields);
    passwordController.addListener(_checkFields);
  }

  void _checkFields() {
    final valid =
        emailController.text.trim().isNotEmpty &&
            passwordController.text.trim().isNotEmpty;

    if (valid != isValid) {
      setState(() {
        isValid = valid;
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            hintText: 'البريد الإلكتروني',
            prefixIcon: Icons.email_outlined,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'من فضلك أدخل البريد الإلكتروني';
              }

              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'من فضلك أدخل بريد إلكتروني صحيح';
              }

              return null;
            },
          ),

          const SizedBox(height: 15),

          CustomPasswordField(
            controller: passwordController,
            obscureText: isPasswordVisible,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            onSuffixTap: () {
              setState(() {
                isPasswordVisible = !isPasswordVisible;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'من فضلك أدخل كلمة المرور';
              }

              if (value.length < 6) {
                return 'كلمة المرور يجب ألا تقل عن 6 أحرف';
              }

              return null;
            },
          ),

          const SizedBox(height: 40),

          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              return CustomButton(
                onPressed: isValid
                    ? () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (_formKey.currentState!.validate()) {
                    BlocProvider.of<LoginCubit>(context).login(
                      email: emailController.text.trim(),
                      password: passwordController.text,
                    );
                  }
                }
                    : null,
                child:Text(
                  'تسجيل دخول',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}