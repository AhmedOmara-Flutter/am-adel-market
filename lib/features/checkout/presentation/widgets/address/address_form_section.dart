import '../../../../../core/utils/app_imports.dart';

class AddressFormSection extends StatelessWidget {
  const AddressFormSection({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.addressController,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController addressController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          autoValidateMode: AutovalidateMode.onUserInteraction,
          label: 'الاسم الكامل',
          controller: nameController,
          prefixIcon: Icons.person,
          hintText: 'أدخل اسمك بالكامل',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'من فضلك أدخل الاسم الكامل';
            }

            if (value.trim().length < 3) {
              return 'الاسم قصير جدًا';
            }

            return null;
          },
        ),

        SizedBox(height: 15.h),

        CustomTextFormField(
          autoValidateMode: AutovalidateMode.onUserInteraction,
          label: 'رقم الهاتف',
          controller: emailController,
          prefixIcon: Icons.phone,
          keyboardType: TextInputType.phone,
          hintText: '01xxxxxxxxx',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'من فضلك أدخل رقم الهاتف';
            }

            if (!RegExp(r'^(010|011|012|015)\d{8}$')
                .hasMatch(value.trim())) {
              return 'من فضلك أدخل رقم هاتف صحيح';
            }

            return null;
          },
        ),

        SizedBox(height: 15.h),

        CustomTextFormField(
          autoValidateMode: AutovalidateMode.onUserInteraction,
          label: 'العنوان',
          controller: addressController,
          prefixIcon: Icons.home_outlined,
          hintText: 'الشارع والمنطقة',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'من فضلك أدخل العنوان';
            }

            return null;
          },
        ),
      ],
    );
  }
}