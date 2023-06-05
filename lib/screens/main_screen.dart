import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:tkecomadmin/controllers/list_menu_controller.dart';
import 'package:tkecomadmin/responsive.dart';
import 'package:tkecomadmin/screens/screens_shelf.dart';
import 'package:tkecomadmin/widgets/widgets_shelf.dart';

class MainScreen extends StatelessWidget {
  static const routeName = "/";
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<ListMenuController>().getScaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              const Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            const Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: DashboardScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
