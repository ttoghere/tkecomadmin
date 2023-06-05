import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tkecomadmin/controllers/controllers_shelf.dart';
import 'package:tkecomadmin/responsive.dart';
import 'package:tkecomadmin/services/utils.dart';
import 'package:tkecomadmin/widgets/product_grid.dart';
import 'package:tkecomadmin/widgets/widgets_shelf.dart';

class AllProductsGrid extends StatefulWidget {
  static const routeName = "/allproducts";
  const AllProductsGrid({super.key});

  @override
  State<AllProductsGrid> createState() => _AllProductsGridState();
}

class _AllProductsGridState extends State<AllProductsGrid> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;

    return Scaffold(
      key: context.read<ListMenuController>().getgridscaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              const Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screeqn
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Header(
                      showTextfield: false,
                      fct: () {
                        context
                            .read<ListMenuController>()
                            .controlProductsMenu();
                      },
                      title: "All Products",
                    ),
                    Responsive(
                      mobile: ProductGrid(
                        crossAxisCount: size.width < 650 ? 2 : 4,
                        isInMain: false,
                        childAspectRatio:
                            size.width < 650 && size.width > 350 ? 1.1 : 0.8,
                      ),
                      desktop: ProductGrid(
                        childAspectRatio: size.width < 1400 ? 0.8 : 1.1,
                        isInMain: false,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
