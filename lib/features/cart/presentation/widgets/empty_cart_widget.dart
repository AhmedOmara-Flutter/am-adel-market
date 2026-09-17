import 'package:am_adel_market/core/widgets/info_action_row.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../generated/assets.dart';

class EmptyCartWidget extends StatefulWidget {
  const EmptyCartWidget({super.key});

  @override
  State<EmptyCartWidget> createState() => _EmptyCartWidgetState();
}

class _EmptyCartWidgetState extends State<EmptyCartWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InfoActionRow(
            text: 'السله',
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  Assets.assets.json.shoppingCart.path,
                  height: MediaQuery
                      .sizeOf(context)
                      .height * 0.3,
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    "سلة المشتريات فارغة. ابدأ بإضافة فواكه طازجة واستمتع بتجربة تسوق صحية",
                    textAlign: TextAlign.center,
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                      color: AppColor.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

