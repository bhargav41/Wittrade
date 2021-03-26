import 'dart:convert';

import 'package:rental/constants.dart';
import "package:rental/models/item.dart";
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class HomeService {
  Future<List<Item>> getItems() async {
    var url = Uri.https(api, "/products", {"q": "http"});
    http.Response response = await http.get(url);
    List<Item> items = [];
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      developer.log("$data", name: "HomeService");
      data["products"]
          .forEach((item) => {items.add(Item.fromJson(data: item))});
    }
    developer.log("$items", name: "HomeService");
    return items;
  }
}
