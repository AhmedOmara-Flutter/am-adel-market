import 'package:flutter/services.dart';

import '../../../../../../../core/utils/app_imports.dart';
import '../widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
    child: Scaffold(body: ProfileViewBody()));
  }
}
