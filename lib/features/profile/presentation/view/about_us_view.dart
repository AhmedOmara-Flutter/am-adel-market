import 'package:am_adel_market/core/utils/app_imports.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../core/helper_function/make_call_function.dart';
import '../widgets/values_card.dart';

class AboutUsView extends StatefulWidget {
  const AboutUsView({super.key});

  @override
  State<AboutUsView> createState() => _AboutUsViewState();
}

class _AboutUsViewState extends State<AboutUsView> {
  String version = "0.0.0";

  @override
  void initState() {
    super.initState();
     _getVersion();
  }

  Future<void> _getVersion() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      version = info.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: InfoActionRow(
              text: 'من نحن',
              showBack: true,
              bottomPadding: 0,
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 15.h),
                AboutCard(
                  title: "رؤيتنا",
                  description:
                      "أن نكون الوجهة الأولى لعشاق الكريبات والبيتزا والوجبات السريعة، مع تقديم تجربة مميزة وجودة لا تُنسى.",
                  image: Assets.assets.images.sights.path,
                  icon: Icons.gps_fixed,
                ),
                SizedBox(height: 15.h),
                AboutCard(
                  title: "رسالتنا",
                  description:
                      "تقديم طعام طازج وشهي باستخدام أفضل المكونات مع خدمة سريعة وتجربة ترضي جميع عملائنا.",
                  image: Assets.assets.images.message.path,
                  icon: Icons.remove_red_eye,
                ),
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: const ValuesCard(),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  padding: EdgeInsets.all(18.w),
                  decoration: BoxDecoration(
                    color: AppColor.mainColor.withOpacity(0.04),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          color: AppColor.mainColor.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.location_on_rounded,
                          color: Colors.white,
                          size: 23.sp,
                        ),
                      ),

                      SizedBox(height: 7.h),

                      Text(
                        "تواصل معنا",
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: AppColor.mainColor,
                        ),
                      ),
                      SizedBox(height: 20.h),

                      _item(
                        Icons.place_outlined,
                        "العنوان",
                        "كفر الزيات - شارع الجيش - أمام مستشفى العام ",
                      ),

                      SizedBox(height: 14.h),

                      _item(
                        Icons.phone,
                        "اتصل بنا",
                        "0100000000000\n0100000000000",
                      ),

                      SizedBox(height: 14.h),

                      _item(
                        Icons.support_agent,
                        "الدعم",
                        "للشكاوى والاقتراحات",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.h),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                  decoration: BoxDecoration(
                    color: AppColor.mainColor.withOpacity(0.04),
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 42.w,
                        height: 42.w,
                        decoration: BoxDecoration(
                          color: AppColor.mainColor.withOpacity(.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.code_rounded,
                          color: AppColor.mainColor,
                          size: 22.sp,
                        ),
                      ),

                      SizedBox(width: 14.w),

                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            makePhoneCall('010984311538');
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'تم تطوير التطبيق بواسطة',
                                style:StyleManager.font12Weight500,
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                'Eng. Ahmed Omara',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.mainColor,
                                ),
                              ),
                        
                              Row(
                                children: [
                                  Icon(Icons.phone,color: AppColor.mainColor,size: 12.sp,),
                                  SizedBox(width: 5.w),
                                  Text(
                                    '01098431538',
                                    style:StyleManager.font12Weight500
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const DeveloperImageView(),
                            ),
                          );
                        },
                        child: Hero(
                          tag: 'developer_image',
                          child: CircleAvatar(
                            radius: 22.r,
                            backgroundColor: AppColor.mainColor.withOpacity(0.15),
                            backgroundImage: AssetImage(Assets.assets.images.me.path),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'الإصدار $version',
                  style: TextStyle(color: AppColor.textSecondary),
                ),
                SizedBox(height: 8.h),
                Text(
                  '© 2026 عم عادل - جميع الحقوق محفوظة',
                  style: TextStyle(color: AppColor.textSecondary),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _item(IconData icon, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColor.mainColor, size: 22),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: AppColor.mainColor.withOpacity(0.6),
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4),
              Text(
                value,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: AppColor.mainColor.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AboutCard extends StatelessWidget {
  const AboutCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.image,
  });

  final String title;
  final String description;
  final String image;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.only(
        left: 20.w,
        right: 10.w,
        top: 15.h,
        bottom: 15.h,
      ),
      decoration: BoxDecoration(
        color: AppColor.mainColor.withOpacity(0.04),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            right: -10.w,
            child: SizedBox(
              child: Center(
                child: Image.asset(
                  image,
                  height: 110.h,
                  fit: BoxFit.cover,
                  color: AppColor.mainColor.withOpacity(0.5),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(child: SizedBox(width: 5.w)),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 30.w,
                          height: 30.w,
                          decoration: BoxDecoration(
                            color: AppColor.mainColor.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(icon, color: Colors.white, size: 20.sp),
                        ),

                        SizedBox(width: 10.w),

                        Text(
                          title,
                          style: Theme.of(context).textTheme.labelSmall!
                              .copyWith(color: AppColor.mainColor),
                        ),
                      ],
                    ),

                    SizedBox(height: 10.h),

                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColor.mainColor.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class DeveloperImageView extends StatelessWidget {
  const DeveloperImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Hero(
            tag: 'developer_image',
            child: InteractiveViewer(
              minScale: 1,
              maxScale: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  Assets.assets.images.me.path,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}