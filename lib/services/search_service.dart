import 'package:rental/models/item.dart';
import 'package:flutter/material.dart';

import 'product_service.dart';

class SearchService {
  Future<List<Item>> getSearchItemsAll() async {
    List<Item> items = await ProductService().getAllItems();
    return items;
  }

  Future<List<Item>> getItemByQuery({@required String query}) async {
    List<Item> items = await getSearchItemsAll();
    List<Item> result = [];
    items.forEach((item) => {
          if (item.name.toLowerCase().contains(query.toLowerCase()))
            {result.add(item)}
        });
    return result;
  }
}
