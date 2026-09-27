import 'package:am_adel_market/core/widgets/empty_widget.dart';
import 'package:am_adel_market/features/coupon/presentation/widgets/skeletonizer_coupon_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_color.dart';
import '../view_model/coupons_cubit.dart';
import '../widgets/coupon_card.dart';

class CouponListView extends StatelessWidget {
  const CouponListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CouponsCubit, CouponsState>(
      builder: (context, state) {
        if (state is CouponsLoading) {
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount:4,
            separatorBuilder: (_, __) {
              return const SizedBox(height: 14);
            },
            itemBuilder: (context, index) {
              return SkeletonizerCouponCard();
            },
          );
        }

        if (state is CouponsFailure) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(
                color: AppColor.textSecondary,
              ),
            ),
          );
        }

        if (state is CouponsSuccess) {
          if (state.coupons.isEmpty) {
            return const EmptyWidget();
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.coupons.length,
            separatorBuilder: (_, __) {
              return const SizedBox(height: 14);
            },
            itemBuilder: (context, index) {
              return CouponCard(
                coupon: state.coupons[index],
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _EmptyCoupons extends StatelessWidget {
  const _EmptyCoupons();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.local_offer_outlined,
            size: 60,
            color: AppColor.textSecondary.withValues(
              alpha: 0.5,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'لا يوجد لديك كوبونات',
            style: TextStyle(
              color: AppColor.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'ستظهر هنا الكوبونات الخاصة بك',
            style: TextStyle(
              color: AppColor.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}