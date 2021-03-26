import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';
import 'package:rental/Screens/Loading.dart';
import 'package:rental/services/product_service.dart';
import 'package:search_app_bar/search_app_bar.dart';
import 'package:search_app_bar/filter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rental/models/item.dart';

class Product extends StatefulWidget {
  String value;
  Product({this.value});

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  Future<Item> product;
  @override
  void initState() {
    super.initState();
    developer.log('ID : ${widget.value}', name: 'ProductPage');
    product = ProductService().getProductById(id: widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<Item>(
            future: product,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                developer.log('Snapshot : ${snapshot.data}',
                    name: 'ProductPage');
              }
              return !snapshot.hasData
                  ? Center(child: Loading())
                  : ListView(
                      children: [
                        Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.network(
                                    snapshot.data.url.toString(),
                                    fit: BoxFit.fill,
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.fromLTRB(10.0, 10.0, 0, 0),
                                  child: FloatingActionButton(
                                    child: Icon(Icons.arrow_back),
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black,
                                    elevation: 20.0,
                                    onPressed: () => {Navigator.pop(context)},
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                                  child: Text(
                                    "₹ ${snapshot.data.price}",
                                    style: TextStyle(
                                        fontSize: 39.0,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                                  child: Text(
                                    "${snapshot.data.name}",
                                    style: TextStyle(
                                        fontSize: 24.0,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30.0),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                                  child: Text(
                                    "Description",
                                    style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.0),
                            Container(
                                child: Row(
                                  children: [
                                    Text(
                                      "${snapshot.data.description}",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        height: 1.5,
                                        color: Color(0xFF6F8398),
                                        fontSize: 17.0,
                                      ),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.all(16)),
                            SizedBox(height: 20.0),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 20.0),
                              child: SizedBox(
                                width: 155.0,
                                height: 65.0,
                                child: RoundedButtonWithIcon(
                                  onPressed: () async {
                                    developer.log(
                                        'Phone Number : ${snapshot.data.sellerContact}',
                                        name: 'ProductPage');
                                    String number =
                                        'tel:${snapshot.data.sellerContact}';
                                    if (await canLaunch(number)) {
                                      await launch(number);
                                    }
                                  },
                                  icon: Icons.call,
                                  title: "  Contact Seller",
                                  buttonColor: Colors.pink[400],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
            }),
      ),
    );
  }
}
