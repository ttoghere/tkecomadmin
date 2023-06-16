// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tkecomadmin/services/utils.dart';

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
    final Color color = Utils(context).color;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("products").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data!.docs.isNotEmpty) {
              return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: isInMain && snapshot.data!.docs.length > 4
                    ? 4
                    : snapshot.data!.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: childAspectRatio,
                    crossAxisSpacing: defaultPadding,
                    mainAxisSpacing: defaultPadding),
                itemBuilder: (context, index) {
                  final access = snapshot.data!.docs[index];
                  final id = access["id"];
                  return ProductWidget(
                    id: id,
                  );
                },
              );
            }
          } else {
            return const Center(
              child: Text("Your store is empty"),
            );
          }
          return const Center(
            child: Text(
              "Something went wrong",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          );
        });
  }
}
