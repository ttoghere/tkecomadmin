// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:tkecomadmin/consts/consts_shelf.dart';

import '../responsive.dart';

class Header extends StatelessWidget {
  final String title;
  final bool showTextfield;
  const Header({
    Key? key,
    required this.title,
    required this.showTextfield,
    required this.fct,
  }) : super(key: key);

  final Function fct;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              fct();
            },
          ),
        if (Responsive.isDesktop(context))
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        if (Responsive.isDesktop(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        showTextfield
            ? Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    fillColor: Theme.of(context).cardColor,
                    filled: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    suffixIcon: InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(defaultPadding * 0.75),
                        margin: const EdgeInsets.symmetric(
                            horizontal: defaultPadding / 2),
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: const Icon(
                          Icons.search,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
