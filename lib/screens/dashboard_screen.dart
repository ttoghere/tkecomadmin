import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:tkecomadmin/controllers/list_menu_controller.dart';
import 'package:tkecomadmin/responsive.dart';
import 'package:tkecomadmin/services/utils.dart';
import 'package:tkecomadmin/widgets/product_grid.dart';
import 'package:tkecomadmin/widgets/widgets_shelf.dart';

import '../consts/consts_shelf.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(
              fct: () {
                context.read<ListMenuController>().controlDashboarkMenu();
              },
              title: "Dashboard",
            ),
            const SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Responsive(
                        mobile: ProductGrid(
                          crossAxisCount: size.width < 650 ? 2 : 4,
                          childAspectRatio:
                              size.width < 650 && size.width > 350 ? 1.1 : 0.8,
                        ),
                        desktop: ProductGrid(
                          childAspectRatio: size.width < 1400 ? 0.8 : 1.1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
