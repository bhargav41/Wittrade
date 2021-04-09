import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rental/Screens/Loading.dart';
import 'package:rental/Screens/ProductScreen/home/Home_Screen.dart';
import 'package:rental/Screens/search.dart';
import 'package:rental/Screens/sell_page.dart';
import 'package:rental/screens/coming_soon.dart';
import 'package:rental/screens/product_page.dart';
import 'package:rental/screens/profile_page.dart';
import 'package:rental/services/home_service.dart';

import 'package:search_app_bar/search_app_bar.dart';
import 'package:search_app_bar/filter.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'Login/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.white70,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future items;
  /*Widget buildFloatingSearchBar() {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Search for products and more',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      maxWidth: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [

        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Colors.accents.map((color) {
                return Container(height: 112, color: color);
              }).toList(),
            ),
          ),
        );
      },
    );
  }*/

  @override
  void initState() {
    super.initState();
    items = HomeService().getItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Search for Products',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: Search());
            },
          ),
        ],
        //searcher: bloc,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 250.0,
                child: GestureDetector(
                  child: Image.asset(
                    'assets/car model.PNG',
                    fit: BoxFit.fill,
                  ),
                  onTap: () {
                    print('car image pressed');
                  },
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: FDottedLine(
                      color: Colors.pink[400],
                      strokeWidth: 3.0,
                      dottedLength: 13.0,
                      space: 5.0,
                      corner: FDottedLineCorner.all(8.0),
                      child: Row(
                        children: [
                          FlatButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()));
                            },
                            child: Text(
                              'Buy',
                              style: TextStyle(
                                  fontSize: 17.0,
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Text(
                            "|",
                            style: TextStyle(fontSize: 17.0),
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Sell()));
                            },
                            child: Text(
                              'Sell',
                              style: TextStyle(
                                  fontSize: 17.0,
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Text(
                            "|",
                            style: TextStyle(fontSize: 17.0),
                          ),
                          VerticalDivider(
                            width: 10,
                            color: Colors.black,
                          ),
                          FlatButton(
                            onPressed: () {},
                            child: Text(
                              'Rent',
                              style: TextStyle(
                                  fontSize: 17.0,
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Container(
                width: MediaQuery.of(context).size.width,
                child: GestureDetector(
                  child: Image.asset('assets/ad.PNG', fit: BoxFit.fill),
                  onTap: () {
                    print('ad image pressed');
                  },
                ),
              ),
              FutureBuilder(
                  future: items,
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? CarouselSlider(
                            options: CarouselOptions(
                              height: 330.0,
                              enlargeCenterPage: true,
                            ),
                            items: snapshot.data.map<Widget>((item) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 7.0),
                                    decoration: BoxDecoration(
                                      color: Colors.pink[400],
                                    ),
                                    child: Card(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Product(value: item.id)));
                                        },
                                        child: Column(
                                          children: [
                                            Flexible(
                                              flex: 2,
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    2,
                                                child: Image.network(
                                                  '${item.url}',
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 7.0),
                                            Flexible(
                                              flex: 1,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 10.0, 0, 0),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                          "₹ ${item.price}",
                                                          style: TextStyle(
                                                              fontSize: 35.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                  Row(
                                                    children: [
                                                      SizedBox(width: 12.0),
                                                      Container(
                                                        child: Text(
                                                          "${item.name}",
                                                          style: TextStyle(
                                                              fontSize: 20.0,
                                                              color: Colors
                                                                  .grey[800],
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          )
                        : Center(
                            child: Loading(),
                          );
                  })
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 250.0,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://i.pinimg.com/originals/c0/8b/15/c08b15e60170108718a77565b552fc86.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileUI2()));
              },
              title: Text('Profile',
                  style: TextStyle(
                    fontSize: 15.0,
                    letterSpacing: 1.5,
                  )),
              leading: Icon(Icons.person, color: Colors.black, size: 30.0),
            ),
            SizedBox(height: 15.0),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Coming_Soon()));
              },
              title: Text('Wishlist',
                  style: TextStyle(
                    fontSize: 15.0,
                    letterSpacing: 2.0,
                  )),
              leading: Icon(Icons.favorite, color: Colors.black, size: 30.0),
            ),
            SizedBox(height: 15.0),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Coming_Soon()));
              },
              title: Text('Cart',
                  style: TextStyle(
                    fontSize: 15.0,
                    letterSpacing: 2.0,
                  )),
              leading:
                  Icon(Icons.shopping_cart, color: Colors.black, size: 30.0),
            ),
            SizedBox(height: 15.0),
            ListTile(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Sell()));
              },
              title: Text('Sell',
                  style: TextStyle(
                    fontSize: 15.0,
                    letterSpacing: 1.0,
                  )),
              leading: Icon(
                Icons.attach_money,
                color: Colors.black,
                size: 30.0,
              ),
            ),
            SizedBox(height: 15.0),
            ListTile(
              onTap: () async {
                FlutterSecureStorage storage = new FlutterSecureStorage();
                await storage.deleteAll();
                Navigator.pushReplacement(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ));
              },
              title: Text('Log Out',
                  style: TextStyle(
                    fontSize: 15.0,
                    letterSpacing: 2.0,
                  )),
              leading: Icon(Icons.exit_to_app, color: Colors.black, size: 30.0),
            ),
          ],
        ),
      ),
    );
  }
}
