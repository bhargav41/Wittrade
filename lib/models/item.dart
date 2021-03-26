import 'package:flutter/material.dart';

import '../constants.dart';

class Item {
  final String name;
  final int price;
  final String url;
  final String id;
  final String description;
  final String sellerContact;

  Item(
      {@required this.name,
      @required this.price,
      @required this.url,
      @required this.id,
      @required this.description,
      @required this.sellerContact});

  factory Item.fromJson({@required Map<String, dynamic> data}) {
    return Item(
        name: data["name"] as String,
        price: data["price"] as int,
        url: "https://$api/uploads//${(data["productImage"].substring(8))}",
        id: data["_id"] as String,
        sellerContact: data['sellerContact'] as String,
        description: data["description"] as String);
  }
}
