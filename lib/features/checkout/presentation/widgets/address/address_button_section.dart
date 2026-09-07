import 'package:flutter/cupertino.dart';

import '../../../../../core/utils/app_imports.dart';

class AddressButtonSection extends StatelessWidget {
  const AddressButtonSection({
    super.key,
    required this.onBack,
    required this.onNext,
  });

  final VoidCallback onBack;
  final VoidCallback onNext;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
              onPressed:onBack,
              child: Icon(
                CupertinoIcons.back, color: Colors.white, size: 30,)
          ),
        ),
        Expanded(
          child: CustomButton(
              onPressed:onNext,
              child: Icon(CupertinoIcons.forward, color: Colors.white,
                size: 30,)),
        ),
      ],
    );
  }
}
