import 'package:am_adel_market/core/utils/app_imports.dart';

void customShowSnakeBar(
  BuildContext context, {
  required Color color,
  required String label,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds:900),
      backgroundColor: color,
      content: Text(label),
    ),
  );
}
