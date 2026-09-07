import 'package:cached_network_image/cached_network_image.dart';

import '../../../../core/entities/product_entity.dart';
import '../../../../core/utils/app_imports.dart';

class ProductSubImagesSection extends StatelessWidget {
  final ProductEntity product;

  const ProductSubImagesSection({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final images = product.subImages ?? [];

    if (images.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox());
    }

    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          children: List.generate(
            images.length,
                (index) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => _FullScreenGallery(
                      images: images,
                      initialIndex: index,
                    ),
                  ),
                );
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: EdgeInsets.only(
                  top: 15.h,
                  right: 12.w,
                ),
                height: 108.h,
                width: 108.w,
                decoration: BoxDecoration(
                  color: AppColor.card,
                  borderRadius: BorderRadius.circular(18.r),
                  border: Border.all(
                    color: AppColor.mainColor,
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.black.withOpacity(.25),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18.r),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: CachedNetworkImage(
                          imageUrl: images[index],
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: AppColor.card,
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColor.mainColor,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Center(
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              color: AppColor.textSecondary,
                              size: 34.sp,
                            ),
                          ),
                        ),
                      ),

                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColor.white.withOpacity(.05),
                                AppColor.transparent,
                                AppColor.black.withOpacity(.18),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: 8.h,
                        right: 8.w,
                        child: Container(
                          padding: EdgeInsets.all(5.r),
                          decoration: BoxDecoration(
                            color: AppColor.background.withOpacity(.85),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Icon(
                            Icons.zoom_in_rounded,
                            color: AppColor.textPrimary,
                            size: 17.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FullScreenGallery extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const _FullScreenGallery({
    required this.images,
    required this.initialIndex,
  });

  @override
  State<_FullScreenGallery> createState() => _FullScreenGalleryState();
}

class _FullScreenGalleryState extends State<_FullScreenGallery> {
  late PageController controller;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    controller = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Stack(
        children: [
          PageView.builder(
            controller: controller,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return InteractiveViewer(
                minScale: 1,
                maxScale: 5,
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl: widget.images[index],
                    fit: BoxFit.contain,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                        color: AppColor.mainColor,
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.image_not_supported_outlined,
                      color: AppColor.textSecondary,
                      size: 60.sp,
                    ),
                  ),
                ),
              );
            },
          ),

          /// Close Button
          Positioned(
            top: 45.h,
            left: 15.w,
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.card.withOpacity(.9),
                borderRadius: BorderRadius.circular(50.r),
                border: Border.all(
                  color: AppColor.border,
                ),
              ),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.close_rounded,
                  color: AppColor.textPrimary,
                  size: 24.sp,
                ),
              ),
            ),
          ),

          /// Counter
          Positioned(
            bottom: 35.h,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 22.w,
                  vertical: 10.h,
                ),
                decoration: BoxDecoration(
                  color: AppColor.mainColor,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Text(
                  "${currentIndex + 1} / ${widget.images.length}",
                  style: TextStyle(
                    color: AppColor.textPrimary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}