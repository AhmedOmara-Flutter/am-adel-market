import 'package:am_adel_market/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:am_adel_market/core/entities/product_entity.dart';
import '../../../../core/helper_function/get_user.dart';
import '../../../../core/utils/app_imports.dart';
import '../../../../core/entities/offer_entity.dart';


class ProductButtonSection extends StatelessWidget {
  final ProductEntity product;
  final OfferEntity? offer;

  const ProductButtonSection({
    super.key, required this.product,
    required this.offer,
  });

  @override
  Widget build(BuildContext context) {
   return SliverFillRemaining(
     hasScrollBody: false,
     child: Column(
       children: [

         const Spacer(),
         Container(
           margin: EdgeInsets.only(
               bottom: 20
           ),
           child: CustomButton(
             child: Text(
               'أضف الي السله',
               style:StyleManager.font15Weight800.copyWith(color: AppColor.white),
             ),
             onPressed: () {

               context.read<CartCubit>().addProduct(product,offer,getUser().uId);
             },
           ),
         ),
       ],
     ),
   );
  }
}
