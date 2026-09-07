import 'package:am_adel_market/core/utils/app_imports.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = true;
  bool isValid = false;

  @override
  void initState() {
    super.initState();

    nameController.addListener(_checkFields);
    phoneController.addListener(_checkFields);
    emailController.addListener(_checkFields);
    passwordController.addListener(_checkFields);
  }

  void _checkFields() {
    final valid =
        nameController.text.trim().isNotEmpty &&
        phoneController.text.trim().isNotEmpty &&
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
    nameController.dispose();
    phoneController.dispose();
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
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  controller: nameController,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.name,
                  hintText: 'الاسم ثنائي',
                  prefixIcon: Icons.person,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'أدخل الاسم';
                    }
                    if (!RegExp(r'^[\u0600-\u06FF\s]+$').hasMatch(value.trim())) {
                      return 'يجب أن يكون باللغة العربية فقط';
                    }
                    final parts = value
                        .trim()
                        .split(RegExp(r'\s+'))
                        .where((e) => e.isNotEmpty)
                        .toList();
                    if (parts.length < 2) {
                      return 'أدخل الاسم ثنائي';
                    }
                    if (parts[0].length < 2 || parts[1].length < 2) {
                      return 'يجب أن يكون حرفين على الأقل';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: CustomTextFormField(
                  controller: phoneController,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.phone,
                  hintText: 'رقم الهاتف',
                  prefixIcon: Icons.phone,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'أدخل الرقم';
                    }

                    if (!RegExp(
                      r'^(010|011|012|015)\d{8}$',
                    ).hasMatch(value.trim())) {
                      return 'رقم غير صحيح';
                    }

                    return null;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          CustomTextFormField(
            controller: emailController,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.emailAddress,
            hintText: 'البريد الإلكتروني',
            prefixIcon: Icons.email_outlined,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'من فضلك أدخل البريد الإلكتروني';
              }

              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value.trim())) {
                return 'من فضلك أدخل بريد إلكتروني صحيح';
              }

              return null;
            },
          ),
          SizedBox(height: 15.h),
          CustomPasswordField(
            controller: passwordController,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            obscureText: isPasswordVisible,
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
          SizedBox(height: 40.h),
          BlocBuilder<RegisterCubit, RegisterState>(
            builder: (context, state) {
              return CustomButton(
                onPressed: isValid
                    ? () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (_formKey.currentState!.validate()) {
                          context.read<RegisterCubit>().register(
                            userName: nameController.text.trim(),
                            email: emailController.text.trim(),
                            phone: phoneController.text.trim(),
                            password: passwordController.text,
                          );
                        }
                      }
                    : null,
                child: Text(
                  'إنشاء حساب جديد',
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
