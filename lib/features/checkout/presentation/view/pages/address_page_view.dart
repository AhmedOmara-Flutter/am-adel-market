import 'package:am_adel_market/core/entities/address_entity.dart';

import '../../../../../core/utils/app_imports.dart';
import '../../view_model/checkout_cubit.dart';
import '../../widgets/address/address_button_section.dart';
import '../../widgets/address/address_form_section.dart';

class AddressPageView extends StatefulWidget {
  const AddressPageView({super.key});

  @override
  State<AddressPageView> createState() => _AddressPageViewState();
}

class _AddressPageViewState extends State<AddressPageView>
    with AutomaticKeepAliveClientMixin {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SafeArea(
      child: Form(
        key: formKey,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      AddressFormSection(
                        nameController: nameController,
                        emailController: emailController,
                        addressController: addressController,
                      ),
                      SizedBox(height: 30.h),
                      const Spacer(),
                      BlocBuilder<CheckoutCubit, CheckoutState>(
                        builder: (context, state) {
                          final cubit = context.read<CheckoutCubit>();
                          return AddressButtonSection(
                            onBack: () {
                              FocusManager.instance.primaryFocus?.unfocus();

                              cubit.pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            onNext: () {
                              FocusManager.instance.primaryFocus?.unfocus();

                              if (formKey.currentState!.validate()) {
                                cubit.orderEntity.addressEntity =
                                    AddressEntity(
                                      name: nameController.text.trim(),
                                      phone: emailController.text.trim(),
                                      address: addressController.text.trim(),
                                    );

                                cubit.pageController.nextPage(
                                  duration:
                                  const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              } else {
                                AppVibration.heavy();
                                AppSounds.playClickSound(
                                  'click_error.wav',
                                );

                                customShowSnakeBar(
                                  context,
                                  color: AppColor.red,
                                  label: 'يرجى استكمال جميع البيانات بشكل صحيح',
                                );
                              }
                            },
                          );
                        },
                      ),

                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}