import 'package:am_adel_market/core/widgets/empty_widget.dart';
import '../../../../core/utils/app_imports.dart';
import '../view_model/profile_cubit.dart';
import 'order_item.dart';
import 'skeletonizer_order_item.dart';

class OrdersViewBody extends StatelessWidget {
  const OrdersViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: InfoActionRow(
            text: 'طلباتي',
            showBack: true,
          ),
        ),

        BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileGetOrdersSuccess) {
              if (state.orders.isEmpty) {
                return const SliverToBoxAdapter(
                  child: EmptyWidget(),
                );
              }

              return SliverList.builder(
                itemCount: state.orders.length,
                itemBuilder: (context, index) {
                  return OrderItem(
                    orderEntity: state.orders[index],
                  );
                },
              );
            }

            if (state is ProfileGetOrdersError) {
              return SliverToBoxAdapter(
                child: Center(
                  child: Text(state.errMessage),
                ),
              );
            }

            return SliverList.builder(
              itemCount: 7,
              itemBuilder: (context, index) {
                return const SkeletonizerOrderItem();
              },
            );
          },
        ),
      ],
    );
  }
}