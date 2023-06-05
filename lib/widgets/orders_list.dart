import 'package:flutter/material.dart';
import 'package:tkecomadmin/consts/consts_shelf.dart';
import 'package:tkecomadmin/widgets/orders_widget.dart';


class OrdersList extends StatelessWidget {
  const OrdersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (ctx, index) {
            return const Column(
              children: [
                OrdersWidget(),
                Divider(thickness: 3,),
              ],
            );
          }),
    );
  }
}
