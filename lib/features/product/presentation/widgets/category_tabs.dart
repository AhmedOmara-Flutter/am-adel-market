import 'package:am_adel_market/features/product/presentation/widgets/product_size_widget.dart';
import '../../../../core/cubit/product_cubit/product_cubit.dart';
import '../../../../core/utils/app_imports.dart';
import '../../../category/domain/entities/category_entity.dart';
import '../../../category/presentation/view_model/category_cubit.dart';
import 'categories_tab_bar.dart';
import 'tap_bar_view_body.dart';

class CategoryTabs extends StatefulWidget {
  const CategoryTabs({super.key});

  @override
  State<CategoryTabs> createState() => _CategoryTabsState();
}

class _CategoryTabsState extends State<CategoryTabs>
    with TickerProviderStateMixin {
  TabController? _tabController;
  int selectedCategoryIndex = 0;

  final Map<String, String?> selectedSizes = {};

  CategoryEntity? get selectedCategory {
    final categories = context.read<CategoryCubit>().categories;

    if (categories.isEmpty) {
      return null;
    }

    if (selectedCategoryIndex >= categories.length) {
      return categories.first;
    }

    return categories[selectedCategoryIndex];
  }

  String? get selectedSize {
    final category = selectedCategory;

    if (category == null) {
      return null;
    }

    return selectedSizes[category.name];
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      context.read<CategoryCubit>().getCategories();
    });
  }

  void _createTabController(List<CategoryEntity> categories) {
    if (categories.isEmpty) {
      return;
    }

    if (selectedCategoryIndex >= categories.length) {
      selectedCategoryIndex = 0;
    }

    for (final category in categories) {
      if (category.sizes.isNotEmpty &&
          !selectedSizes.containsKey(category.name)) {
        selectedSizes[category.name] = category.sizes.first;
      }
    }

    if (_tabController != null && _tabController!.length == categories.length) {
      return;
    }

    _tabController?.removeListener(_onTabChanged);
    _tabController?.dispose();

    _tabController = TabController(
      length: categories.length,
      vsync: this,
      initialIndex: selectedCategoryIndex,
    );

    _tabController!.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    final controller = _tabController;

    if (controller == null || controller.indexIsChanging) {
      return;
    }

    final categories = context.read<CategoryCubit>().categories;

    if (categories.isEmpty) {
      return;
    }

    final index = controller.index;

    if (index < 0 || index >= categories.length) {
      return;
    }

    final category = categories[index];

    if (!mounted) {
      return;
    }

    if (category.sizes.isNotEmpty &&
        !selectedSizes.containsKey(category.name)) {
      selectedSizes[category.name] = category.sizes.first;
    }

    setState(() {
      selectedCategoryIndex = index;
    });

    _filterProducts();
  }

  void _filterProducts() {
    final category = selectedCategory;

    if (category == null) {
      return;
    }

    context.read<ProductCubit>().filterProducts(
      category.name,
      size: selectedSize,
    );
  }

  @override
  void dispose() {
    _tabController?.removeListener(_onTabChanged);
    _tabController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        final categories = context.read<CategoryCubit>().categories;

        if (state is CategoryGetLoading && categories.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(color: AppColor.mainColor),
          );
        }

        if (categories.isEmpty) {
          return const Center(
            child: Text(
              'لا توجد تصنيفات',
              style: TextStyle(
                color: AppColor.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }

        _createTabController(categories);

        return _buildContent(categories);
      },
    );
  }

  Widget _buildContent(List<CategoryEntity> categories) {
    final controller = _tabController;

    if (controller == null) {
      return const SizedBox.shrink();
    }

    if (selectedCategoryIndex >= categories.length) {
      return const SizedBox.shrink();
    }

    final category = categories[selectedCategoryIndex];

    return Column(
      children: [
        const SizedBox(height: 2),

        CategoriesTabBar(controller: controller, categories: categories),

        if (category.sizes.isNotEmpty) ...[
          SizedBox(height: 10.h),

          ProductSizeWidget(
            category: category,
            selectedSize: selectedSize,
            onSizeSelected: (size) {
              setState(() {
                selectedSizes[category.name] = size;
              });

              _filterProducts();
            },
          ),
        ],

        SizedBox(height: 10.h),

        Expanded(
          child: TabBarView(
            controller: controller,
            physics: const NeverScrollableScrollPhysics(),
            children: categories.map((category) {
              return TapBarViewBody(
                category: category.name,
                size: category.name == selectedCategory?.name
                    ? selectedSize
                    : null,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
