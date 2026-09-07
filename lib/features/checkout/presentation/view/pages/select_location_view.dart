import '../../../../../core/utils/app_imports.dart';
import '../../view_model/checkout_cubit.dart';
import '../../widgets/select_location_card.dart';

class SelectLocationView extends StatelessWidget {
  const SelectLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<CheckoutCubit>();
    if (cubit.state is CheckoutLocationsLoading) {
      return const SafeArea(
        child: Center(
          child: CircularProgressIndicator(
            color: AppColor.mainColor,
          ),
        ),
      );
    }

    if (cubit.state is CheckoutLocationsError) {
      return SafeArea(
        child: Center(
          child: Text(
            'حدث خطأ أثناء تحميل أماكن التوصيل',
            style: Theme
                .of(context)
                .textTheme
                .bodyMedium,
          ),
        ),
      );
    }

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: cubit.placesOptions.isEmpty
                ? Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: AppColor.mainColor.withOpacity(0.12),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColor.mainColor.withOpacity(0.25),
                          width: 1.5,
                        ),
                      ),
                      child: const Icon(
                        Icons.location_off_rounded,
                        size: 44,
                        color: AppColor.mainColor,
                      ),
                    ),

                    const SizedBox(height: 22),

                    Text(
                      'لا توجد أماكن توصيل',
                      style: StyleManager.font16Weight700.copyWith(
                        color: AppColor.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 10),

                    Text(
                      'عذرًا، لا توجد مناطق توصيل متاحة حاليًا.\n'
                          'يمكنك المحاولة مرة أخرى لاحقًا.',
                      style: StyleManager.font13Weight600.copyWith(
                        color: AppColor.textSecondary,
                        height: 1.6,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
                : ListView.separated(
              padding: EdgeInsets.only(
                bottom: 20.h,
              ),
              physics: const BouncingScrollPhysics(),
              itemCount: cubit.placesOptions.length,
              separatorBuilder: (_, _) =>
                  SizedBox(
                    height: 10.h,
                  ),
              itemBuilder: (context, index) {
                final item = cubit.placesOptions[index];

                return SelectLocationCard(
                  isSelected:
                  cubit.selectedLocationIndex == index,
                  item: item,
                  onTap: () {
                    cubit.changeSelectedLocationIndex(index);
                  },
                );
              },
            ),
          ),

          CustomButton(
            onPressed: () {
              if (cubit.selectedLocationIndex == null) {
                AppVibration.heavy();
                AppSounds.playClickSound('click_error.wav');

                customShowSnakeBar(
                  context,
                  color: AppColor.red,
                  label: 'يرجى اختيار مكان التوصيل',
                );

                return;
              }

              final selected =
              cubit.placesOptions[cubit.selectedLocationIndex!];

              cubit.orderEntity.selectedLocationEntity = selected;

              cubit.pageController.nextPage(
                duration: const Duration(
                  milliseconds: 300,
                ),
                curve: Curves.easeInOut,
              );
            },
            child: Text(
              'التالي',
              style: Theme
                  .of(context)
                  .textTheme
                  .labelSmall,
            ),
          ),

          SizedBox(height: 30.h),
        ],
      ),
    );
  }
}
