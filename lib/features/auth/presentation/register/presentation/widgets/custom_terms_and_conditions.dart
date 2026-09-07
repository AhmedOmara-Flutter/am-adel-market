import 'package:am_adel_market/core/utils/app_imports.dart';

class CustomTermsAndConditions extends StatelessWidget {
  final bool isTermsAndConditionsSelected;
  final Function()? onTap;
  const CustomTermsAndConditions({super.key, required this.isTermsAndConditionsSelected, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10),
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: isTermsAndConditionsSelected ? Color(0xff2D9F5D) : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Color(0xffDDDFDF)),
            ),
            child: isTermsAndConditionsSelected?Icon(Icons.done,size: 17,color: Colors.white,):null,
          ),
          RichText(
            text: TextSpan(
              text: ' من خلال إنشاء حساب ، فإنك توافق على',
              style: Theme.of(context).textTheme.titleMedium,
              children: [
                TextSpan(
                  text: ' الشروط \nوالأحكام الخاصة بنا',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(color:AppColor.mainColor.withOpacity(0.7)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
