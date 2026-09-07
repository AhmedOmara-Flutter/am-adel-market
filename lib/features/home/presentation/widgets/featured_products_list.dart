import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:am_adel_market/features/home/presentation/widgets/skeletonizer_featured_item.dart';

import '../../../../core/utils/app_imports.dart';
import '../view_model/featured_cubit.dart';
import 'featured_item.dart';

class FeaturedProductsList extends StatelessWidget {
  const FeaturedProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeaturedCubit, FeaturedState>(
      builder: (context, state) {
        if (state is GetFeaturedProductsSuccessState) {
          if (state.featuredProducts.isEmpty) {
            return SizedBox(
              height: 170.h,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 10.h,
                ),
                alignment: Alignment.center,
                child: Text(
                  'لا يوجد حاليا منتجات مميزه برجاء الاضافه',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            );
          }

          return SizedBox(
            height: 170.h,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemBuilder: (context, index) => FeaturedItem(
                productEntity: state.featuredProducts[index],
              ),
              separatorBuilder: (context, index) => SizedBox(width: 10.w),
              itemCount: state.featuredProducts.length,
            ),
          );
        }

        if (state is GetFeaturedProductsErrorState) {
          return Center(
            child: Text(
              state.errMessage,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          );
        }

        return SizedBox(
          height: 170.h,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemBuilder: (context, index) =>
            const SkeletonizerFeaturedItem(),
            separatorBuilder: (context, index) => SizedBox(width: 10.w),
            itemCount: 5,
          ),
        );
      },
    );
  }
}