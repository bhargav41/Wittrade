import 'dart:developer' as developer;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rental/constants.dart';
import 'package:rental/models/item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class ProductService {
  Future<Item> getProductById({@required String id}) async {
    var uri = Uri.https(api, "/products/$id", {"q": "{http}"});
    var response = await http.get(uri);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      Map<String, dynamic> data = jsonDecode(response.body);
      Item item = Item.fromJson(data: data['product']);
      return item;
    } else {
      throw Exception(
        "Item Not Found",
      );
    }
  }

  Future<List<Item>> getAllItems() async {
    var url = Uri.https(api, "/products", {"q": "http"});
    http.Response response = await http.get(url);
    List<Item> items = [];
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      developer.log("$data", name: "ProductService");
      data["products"]
          .forEach((item) => {items.add(Item.fromJson(data: item))});
    }
    developer.log("$items", name: "ProductService");
    return items;
  }

  Future<void> sellItem(
      {@required String name,
      @required String price,
      @required String title,
      @required String description,
      @required File image}) async {
    FlutterSecureStorage storage = new FlutterSecureStorage();
    Uri uri = Uri.https(api, '/products');
    developer.log('API URI : ${uri.toString()}', name: 'ProductService');
    String token = await storage.read(key: 'token');
    var request = http.MultipartRequest('POST', uri)
      ..headers.addAll({
        "Content-Type": "application/form-data",
        "Authorization": "Bearer $token"
      })
      ..fields.addAll({
        'name': name,
        'price': price,
        'title': title,
        'description': description,
      })
      ..files.add(await http.MultipartFile.fromPath('productImage', image.path,
          contentType:
              MediaType.parse('${lookupMimeType(image.path.toString())}')));
    developer.log('Request : $request', name: 'ProductService');
    http.Response response =
        await http.Response.fromStream(await request.send());
    developer.log('Response : ${response.body}', name: 'ProductService');
  }
}
