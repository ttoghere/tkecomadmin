import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tkecomadmin/responsive.dart';
import 'package:tkecomadmin/widgets/orders_list.dart';
import 'package:tkecomadmin/widgets/widgets_shelf.dart';
import 'package:tkecomadmin/controllers/controllers_shelf.dart';

class AllOrdersScreen extends StatefulWidget {
  static const routeName = "/allorders";
  const AllOrdersScreen({Key? key}) : super(key: key);

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<ListMenuController>().getOrdersScaffoldKey,
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
            Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Header(
                        fct: () {
                          context.read<ListMenuController>().controlAllOrder();
                        },
                        title: 'All Orders',
                        showTextfield: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: OrdersList(),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
