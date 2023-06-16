// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_null_comparison
// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tkecomadmin/inner_screens/edit_products.dart';

import 'package:tkecomadmin/services/global_method.dart';

import '../services/utils.dart';
import 'text_widget.dart';

class ProductWidget extends StatefulWidget {
  final String id;

  const ProductWidget({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  String title = "";
  String productCat = "";
  String? imageUrl;
  String price = '0.0';
  double salePrice = 0.0;
  bool isOnSale = false;
  bool isPiece = false;
  @override
  void initState() {
    super.initState();
    getProductsData();
  }

  Future<void> getProductsData() async {
    try {
      final DocumentSnapshot productsDoc = await FirebaseFirestore.instance
          .collection('products')
          .doc(widget.id)
          .get();
      if (productsDoc == null) {
        return;
      } else {
        setState(() {
          title = productsDoc.get('title');
          productCat = productsDoc.get('productCategoryName');
          imageUrl = productsDoc.get('imageUrl');
          price = productsDoc.get('price');
          salePrice = productsDoc.get('salePrice');
          isOnSale = productsDoc.get('isOnSale');
          isPiece = productsDoc.get('isPiece');
        });
      }
    } catch (error) {
      GlobalMethods.warningDialog(
          subtitle: '$error',
          context: context,
          title: "An error occured",
          fct: () {
            Navigator.of(context).pop();
          });
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;

    final color = Utils(context).color;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor.withOpacity(0.6),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => EditProductScreen(
                  id: widget.id,
                  title: title,
                  price: price,
                  salePrice: salePrice,
                  productCat: productCat,
                  imageUrl: imageUrl == null
                      ? 'https://www.lifepng.com/wp-content/uploads/2020/11/Apricot-Large-Single-png-hd.png'
                      : imageUrl!,
                  isOnSale: isOnSale,
                  isPiece: isPiece,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Image.network(
                        imageUrl == null
                            ? 'https://scontent.fadb2-1.fna.fbcdn.net/v/t1.6435-9/97118022_963873147398208_5016586750223450112_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=x16ePQxHmUgAX_Lxxdr&_nc_ht=scontent.fadb2-1.fna&oh=00_AfDLg4iJ1gKodFaw6pfYru0ChFQ3DHxlphY7yrHMqhTRqg&oe=64B25578'
                            : imageUrl!
                        // width: screenWidth * 0.12,
                        ,
                        height: size.width * 0.12,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Spacer(),
                    PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          onTap: () {},
                          value: 1,
                          child: const Text('Edit'),
                        ),
                        PopupMenuItem(
                          onTap: () {},
                          value: 2,
                          child: const Text(
                            'Delete',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    TextWidget(
                      text: isOnSale
                          ? '\$${salePrice.toStringAsFixed(2)}'
                          : '\$$price',
                      color: color,
                      textSize: 18,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Visibility(
                        visible: true,
                        child: Text(
                          '\$$price',
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: color),
                        )),
                    const Spacer(),
                    TextWidget(
                      text: isPiece ? "1Piece" : '1Kg',
                      color: color,
                      textSize: 18,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                TextWidget(
                  text: title,
                  color: color,
                  textSize: 24,
                  isTitle: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
