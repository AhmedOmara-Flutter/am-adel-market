import '../../../../../../../core/utils/app_imports.dart';

class ItemsCountLabel extends StatelessWidget {
  final int productsNumber;
  const ItemsCountLabel({super.key, required this.productsNumber});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
      child: Row(
        children: [
          Text(
            '$productsNumber نتائج',
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Colors.black),
          ),
          const Spacer(),
       Container(
         padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(4),
           border:Border.all(color: Color(0xffEAEBEB))
         ),
         child: SvgPicture.asset(Assets.assets.images.filter2.path),


       )
        ],
      ),
    );
  }
}
