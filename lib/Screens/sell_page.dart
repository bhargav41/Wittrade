// ignore: avoid_web_libraries_in_flutter

import 'dart:io';
import 'dart:ui';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rental/services/product_service.dart';

import '../constants.dart';

AppBar buildAppBar(context) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: IconButton(
      icon: SvgPicture.asset("assets/icons/back.svg"),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  );
}

class Sell extends StatefulWidget {
  @override
  _SellState createState() => _SellState();
}

class _SellState extends State<Sell> {
  final _name = TextEditingController();
  final _price = TextEditingController();
  final _title = TextEditingController();
  final _description = TextEditingController();

  File _image;
  Future getImagefromcamera() async {
    PickedFile image = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      _image = File(image.path);
    });
  }

  Future getImagefromGallery() async {
    PickedFile image =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 10.0),
          Center(
            child: Text(
              "Sell Your Stuff!",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 200.0,
              child: Center(
                child: _image == null
                    ? Text(
                        "No Image is picked",
                        style: TextStyle(color: Colors.grey[500]),
                      )
                    : Image.file(_image),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: 50.0,
                child: FlatButton(
                  color: Colors.pink[400],
                  onPressed: getImagefromcamera,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "Camera",
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 50.0,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Colors.pink[400],
                  onPressed: getImagefromGallery,
                  child: Row(
                    children: [
                      Icon(
                        Icons.image,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "Gallery",
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30.0),
          Column(
            children: [
              Container(
                width: 200.0,
                child: TextFormField(
                  controller: _price,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(labelText: 'Enter selling price'),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                color: Colors.grey[200],
                width: MediaQuery.of(context).size.width / 1.05,
                height: 50.0,
                child: TextField(
                  controller: _name,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Give your item a Name',
                      hintStyle: TextStyle(color: Colors.grey[500])),
                  cursorHeight: 30.0,
                  cursorWidth: 3.0,
                  cursorColor: Colors.pink[400],
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                color: Colors.grey[200],
                width: MediaQuery.of(context).size.width / 1.05,
                height: 200.0,
                child: TextField(
                  controller: _description,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Describe your item',
                      hintStyle: TextStyle(color: Colors.grey[500])),
                  cursorHeight: 30.0,
                  cursorWidth: 3.0,
                  cursorColor: Colors.pink[400],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.05,
                  height: 50.0,
                  child: RaisedButton.icon(
                    onPressed: () async {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Posting your awesome product')));
                      try {
                        await ProductService().sellItem(
                            name: _name.text,
                            price: _price.text,
                            title: _title.text,
                            description: _description.text,
                            image: _image);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Your awesome product is up for sale!!!')));
                        Navigator.pop(context);
                      } catch (e) {
                        developer.log('Error : $e', name: 'SellPage');
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Oops! An error occured')));
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    label: Text(
                      'Sell',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        letterSpacing: 2.0,
                      ),
                    ),
                    icon: Icon(
                      Icons.attach_money,
                      color: Colors.white,
                    ),
                    textColor: Colors.white,
                    splashColor: Colors.red[800],
                    color: Colors.pink[400],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
