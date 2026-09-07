import 'package:cached_network_image/cached_network_image.dart';
import '../../features/cart/presentation/view_model/cart_cubit.dart';
import '../../features/favorite/presentation/view_model/favorite_cubit.dart';
import '../../features/offers/presentation/view_model/offer_cubit.dart';
import '../../features/restaurant_status/presentation/view_model/restaurant_status_cubit.dart';
import '../cubit/product_cubit/product_cubit.dart';
import '../entities/product_entity.dart';
import '../helper_function/get_user.dart';
import '../utils/app_imports.dart';

class ProductItem extends StatelessWidget {
  final ProductEntity product;

  const ProductItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    if (product.isPaused) {
      return PausedProductItem(
        product: product,
      );
    }

    return ActiveProductItem(
      product: product,
    );
  }
}

class ActiveProductItem extends StatelessWidget {
  final ProductEntity product;

  const ActiveProductItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final offer = context.watch<OfferCubit>().offersMap[product.id];
    final hasOffer = offer != null && offer.isActive;

    return GestureDetector(
      onTap: () async {
        FocusManager.instance.primaryFocus?.unfocus();

        await AppSounds.playClickSound(
          'click_song.wav',
        );

        Navigator.pushNamed(
          context,
          RouteManager.productDetails,
          arguments: product.id,
        );

        context
            .read<ProductCubit>()
            .increaseSellingCount(product.id);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.card,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: AppColor.mainColor.withOpacity(.1),
            width: 1,
          ),
        ),
        child: Stack(
          children: [
            BlocBuilder<FavoriteCubit, FavoriteState>(
              builder: (context, state) {
                final cubit = context.watch<FavoriteCubit>();
                final isFavorite = cubit.favorites[product.id] ?? false;

                return Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: () {
                      context.read<FavoriteCubit>().toggleFavorite(product);
                    },
                    icon: isFavorite
                        ? const Icon(
                      Icons.favorite,
                      color: Color(0xffEB5757),
                    )
                        : const Icon(
                      Icons.favorite_border,
                      color: AppColor.textSecondary,
                    ),
                  ),
                );
              },
            ),

            if (hasOffer)
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(8.r),
                      topLeft: Radius.circular(24.r),
                    ),
                  ),
                  child: Text(
                    '%${offer.discountPercentage.toInt()}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),

            Positioned.fill(
              top: 25.h,
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  Flexible(
                    child: CachedNetworkImage(
                      imageUrl: product.image ?? '',
                      fit: BoxFit.contain,
                      placeholder: (context, url) => Skeletonizer(
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColor.mainColor,
                            ),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 10.w,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.card,
                            border: Border.all(
                              color: AppColor.border,
                            ),
                            borderRadius:
                            BorderRadius.circular(4.r),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              size: 50.sp,
                              color: AppColor.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 24.h),

                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.only(
                      left: 10.w,
                      right: 10.w,
                    ),
                    title: Text(
                      product.name,
                      textAlign: TextAlign.right,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(
                        color: AppColor.textPrimary,
                      ),
                    ),
                    subtitle: hasOffer
                        ? Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${offer.priceBeforeDiscount} ج.م',
                          style: StyleManager
                              .font12Weight500
                              .copyWith(
                            color:
                            AppColor.textSecondary,
                            decoration:
                            TextDecoration.lineThrough,
                            decorationColor:
                            AppColor.textPrimary,
                            decorationThickness: 1.5,
                          ),
                        ),
                        Text(
                          '${offer.priceAfterDiscount} ج.م',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                            color:
                            AppColor.mainColor,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                        : Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '${product.price} ج.م',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                              color: AppColor.mainColor,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.right,
                    ),
                    // trailing: BlocBuilder<RestaurantStatusCubit, RestaurantStatusState>(
                    //   builder: (context, state) {
                    //     if (state is RestaurantStatusLoaded &&
                    //         !state.restaurantStatus.isOpen) {
                    //       return const SizedBox.shrink();
                    //     }
                    //
                    //     return GestureDetector(
                    //       onTap: () {
                    //         context.read<CartCubit>().addProduct(
                    //           product,
                    //           offer,
                    //           getUser().uId,
                    //         );
                    //       },
                    //       child: CircleAvatar(
                    //         radius: 20.r,
                    //         backgroundColor: AppColor.mainColor,
                    //         child: Icon(
                    //           Icons.add_shopping_cart_rounded,
                    //           color: Colors.white,
                    //           size: 20.sp,
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // ),

                    trailing: GestureDetector(
                      onTap: () {
                        context.read<CartCubit>().addProduct(
                          product,
                          offer,
                          getUser().uId,
                        );
                      },
                      child: CircleAvatar(
                        radius: 20.r,
                        backgroundColor:
                        AppColor.mainColor,
                        child: Icon(
                          Icons.add_shopping_cart_rounded,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PausedProductItem extends StatelessWidget {
  final ProductEntity product;

  const PausedProductItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.card,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: AppColor.border,
          width: 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Opacity(
                    opacity: .38,
                    child: CachedNetworkImage(
                      imageUrl: product.image ?? '',
                      fit: BoxFit.contain,
                      placeholder: (context, url) {
                        return Center(
                          child: SizedBox(
                            width: 25.w,
                            height: 25.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColor.mainColor,
                            ),
                          ),
                        );
                      },
                      errorWidget: (context, url, error) {
                        return Center(
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            size: 45.sp,
                            color: AppColor.textSecondary,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                Positioned(
                  top: 12.h,
                  left: 12.w,
                  right: 12.w,
                  child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.card.withOpacity(.94),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: AppColor.red.withOpacity(.18),
                        ),
                      ),
                      child: Text(
                          'غير متوفر حاليًا',
                          textAlign: TextAlign.center,
                          style:StyleManager.font11Weight400.copyWith(color: Colors.red)
                      )                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(
              12.w,
              10.h,
              12.w,
              14.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColor.textSecondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${product.price} ج.م',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(
                        color: AppColor.textSecondary,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.border.withOpacity(.35),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                          'متوقف',
                          style: StyleManager.font11Weight400
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
