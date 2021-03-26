import 'package:flutter/material.dart';
import 'package:rental/Screens/ProductScreen/Products.dart';

import 'package:rental/constants.dart';
import 'package:rental/models/item.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final Function press;
  const ItemCard({
    Key key,
    this.item,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(0.0),
              // For  demo we use fixed height  and width
              // Now we dont need them
              // height: 180,
              // width: 160,
              decoration: BoxDecoration(
                color: Colors.pink[50],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: "${item.id}",
                child: Image.network(item.url),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
            child: Text(
              // products is out demo list
              item.name,
              style: TextStyle(color: kTextLightColor),
            ),
          ),
          Text(
            "\₹${item.price}",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
