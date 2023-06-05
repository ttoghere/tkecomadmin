// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:tkecomadmin/widgets/widgets_shelf.dart';

import '../consts/consts_shelf.dart';

class ProductGrid extends StatelessWidget {
  final int crossAxisCount;
  final double childAspectRatio;
  final bool isInMain;
  const ProductGrid({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
    this.isInMain = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: isInMain ? 4 : 20,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: childAspectRatio,
          crossAxisSpacing: defaultPadding,
          mainAxisSpacing: defaultPadding),
      itemBuilder: (context, index) {
        return const ProductWidget();
      },
    );
  }
}
