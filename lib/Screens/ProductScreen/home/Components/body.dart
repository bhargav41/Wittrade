import 'package:flutter/material.dart';
import 'package:rental/constants.dart';
import 'package:rental/Screens/ProductScreen/Products.dart';
import 'package:rental/Screens/ProductScreen/details/details.dart';
import 'package:rental/models/item.dart';
import 'package:rental/services/product_service.dart';
import 'package:rental/Screens/product_page.dart' as productPage;

import '../../../Loading.dart';
import 'categorries.dart';
import 'item_card.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Image.asset(
          "./assets/images/conceptrart.png",
          //fit: BoxFit.cover,
        ), //Categories(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: FutureBuilder<List<Item>>(
                future: ProductService().getAllItems(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                        itemCount: snapshot.data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: kDefaultPaddin,
                          crossAxisSpacing: kDefaultPaddin,
                          childAspectRatio: 0.80,
                        ),
                        itemBuilder: (context, index) => ItemCard(
                              item: snapshot.data[index],
                              press: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => productPage.Product(
                                            value: snapshot.data[index].id,
                                          ))),
                            ));
                  } else {
                    return Center(child: Loading());
                  }
                }),
          ),
        ),
      ],
    );
  }
}
