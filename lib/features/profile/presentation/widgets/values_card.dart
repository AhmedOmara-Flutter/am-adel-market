import 'package:am_adel_market/features/profile/presentation/widgets/value_item.dart';
import '../../../../core/utils/app_imports.dart';

class ValuesCard extends StatelessWidget {
  const ValuesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 24.h,
      ),
      decoration: BoxDecoration(
        color: AppColor.mainColor.withOpacity(0.04),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: AppColor.mainColor.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.groups_rounded,
              color: Colors.white,
              size: 23.sp,
            ),
          ),

          SizedBox(height: 7.h),

          Text(
            "قيمنا",
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: AppColor.mainColor,
            ),
          ),

          SizedBox(height: 15.h),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              ValueItem(
                icon: Icons.sentiment_satisfied_alt_outlined,
                title: "الرضا",
                subtitle: "راحة عملائنا هي اولويتنا",
              ),
              ValueItem(
                icon: Icons.favorite_border,
                title: "الصحة",
                subtitle: "ندعم نمط\n حياة صحي",
              ),
              ValueItem(
                icon: Icons.shield_outlined,
                title: "الثقة",
                subtitle: "نلتزم بالشفافية",
              ),
              ValueItem(
                icon: Icons.eco_outlined,
                title: "الجودة",
                subtitle: "نختار الأفضل لك دائماً",
              ),
            ],
          ),
        ],
      ),
    );
  }
}