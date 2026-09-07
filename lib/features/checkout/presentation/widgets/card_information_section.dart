import '../../../../core/utils/app_imports.dart';

class CardInformationSection extends StatelessWidget {
  const CardInformationSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        CustomTextFormField(
          hintText: 'اسم حامل البطاقه',
        ),
        CustomTextFormField(
          hintText: 'رقم البطاقة',
        ),
        Row(
          children: [
            Expanded(child: CustomTextFormField(
              hintText: 'تاريخ الصلاحيه',
            )),
            SizedBox(width: 10.w,),
            Expanded(child: CustomTextFormField(
              hintText: 'CVV',
            )),
          ],
        ),
      ],
    );
  }
}
