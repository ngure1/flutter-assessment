import 'package:flutter/material.dart';
import 'package:flutter_assessment/core/layout/desktop_and_tablet_layout.dart';
import 'package:flutter_assessment/core/layout/layout.dart';
import 'package:flutter_assessment/core/layout/mobile_layout.dart';
import 'package:flutter_assessment/features/profile/widgets/user_form_mobile.dart';
import 'package:flutter_assessment/features/profile/widgets/user_form_desktop.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      desktopAndTabletLayout: DesktopAndTabletLayout(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DesktopUserForm(),
        ),
      ),
      mobileLayout: MobileLayout(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: UserFormMobile(),
        ),
      ),
    );
  }
}
