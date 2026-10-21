import '../../../../core/utils/app_imports.dart';
import '../../../../core/widgets/products_grid_view.dart';
import '../../../../core/entities/product_entity.dart';

class BuildSearchSuccess extends StatelessWidget {
  final List<ProductEntity> products;
  const BuildSearchSuccess({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(child: _ResultsHeader(count: products.length)),
        ProductsGridView(products: products),
        SliverToBoxAdapter(
          child: SizedBox(height: 24.h + MediaQuery.of(context).padding.bottom),
        ),
      ],
    );
  }
}

class _ResultsHeader extends StatelessWidget {
  final int count;
  const _ResultsHeader({required this.count});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
      builder: (context, v, child) => Opacity(
        opacity: v,
        child: Transform.translate(
          offset: Offset(0, 10 * (1 - v)),
          child: child,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 18.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'نتائج البحث',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: StyleManager.font19Weight700,
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    width: 36.w,
                    height: 3.h,
                    decoration: BoxDecoration(
                      color: AppColor.accentColor,
                      borderRadius: BorderRadius.circular(3.r),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '$count',
              style: StyleManager.font19Weight700.copyWith(
                color: AppColor.accentColor,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(width: 6.w),
            Padding(
              padding: EdgeInsets.only(bottom: 2.h),
              child: Text(
                count == 1 ? 'نتيجة' : 'نتائج',
                style: StyleManager.font13Weight400.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}