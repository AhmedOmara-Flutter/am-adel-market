import '../../../../core/utils/app_imports.dart';

class InActiveStepItem extends StatelessWidget {
final String text;
final int index;

const InActiveStepItem({
super.key,
required this.text,
required this.index,
});

@override
Widget build(BuildContext context) {
return Row(
mainAxisSize: MainAxisSize.min,
children: [
Container(
width: 30.w,
height: 30.w,
decoration: BoxDecoration(
color: AppColor.cardLight,
shape: BoxShape.circle,
border: Border.all(
color: AppColor.border.withOpacity(.45),
width: 1.2,
),
),
child: Center(
child: Text(
'$index',
style: StyleManager.font13Weight700.copyWith(
color: AppColor.textSecondary,
),
),
),
),
SizedBox(width: 7.w),
Text(
text,
style: StyleManager.font13Weight600.copyWith(
color: AppColor.textSecondary,
),
),
],
);
}
}
