import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:store/Constants/Server.dart';
import 'package:store/Constants/Size.dart';
import 'package:http/http.dart' as http;
import 'package:store/Screens/HomeScreen.dart';

class Orders extends StatefulWidget {
  var Products;
  Orders(this.Products);

  @override
  State<Orders> createState() => _OrdersState(Products);
}

class _OrdersState extends State<Orders> {
  var Products;
  _OrdersState(this.Products);
  var orders;
  var isLoaded = false;
  Future<void> GetData() async {
    final token = GetStorage();
    var UserID = await token.read('USER_ID');
    var response = await http
        .get(Uri.parse(url + '/order/getbyid?buyerId=' + UserID.toString()));

    if (response.statusCode == 200) {
      setState(() {
        orders = json.decode(response.body);
        isLoaded = true;
        print(orders);
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    super.initState();

    GetData();
  }

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    var size = MSize(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
                height: size.getHeight() * 0.1,
                width: size.getWidth(),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: size.getWidth() * 0.05),
                        child: const Text('الطلبات السابقة',
                            style: TextStyle(
                                color: Color.fromRGBO(33, 150, 243, 1),
                                fontSize: 24,
                                fontWeight: FontWeight.w500)),
                      ),
                      Container(
                        width: size.getWidth() * 0.3,
                        height: size.getHeight() * 0.05,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: size.getHeight() * 0.05,
                                width: size.getWidth() * 0.1,
                                child: IconButton(
                                    icon: const Icon(
                                      Icons.arrow_back_ios_new,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }),
                              )
                            ]),
                      )
                    ])),
            (!isLoaded)
                ? Container(
                    height: size.getHeight() * 0.9,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator())
                : orders['order'].length > 0
                    ? Container(
                        child: Column(
                        children: [],
                      ))
                    : Container(
                        height: size.getHeight() * 0.9,
                        width: size.getWidth(),
                        child: Column(
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.only(top: size.getHeight() * 0.1),
                              height: size.getHeight() * 0.4,
                              child: Image.asset('assets/images/NoOrder.png'),
                            ),
                            Text(
                              'لم تقم بشراء اي منتج من قبل',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 22 * textScaleFactor,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
          ],
        )),
      ),
    );
  }

  Widget Product(id, size, index, textScaleFactor) {
    var product;
    for (var i = 0; i < Products.length; i++) {
      if (Products[i]['_id'] == id) {
        product = Products[i];
        break;
      }
    }
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(top: 3, left: size.getWidth() * 0.023),
                  alignment: Alignment.topLeft,
                  width: (size.getWidth() -
                      size.getWidth() * 0.1 -
                      size.getWidth() * 0.37),
                  height: (size.getHeight() * 0.18) / 2,
                  child: Text(
                    product['ProductName'],
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20 * double.parse(textScaleFactor.toString()),
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                    width: (size.getWidth() -
                        size.getWidth() * 0.1 -
                        size.getWidth() * 0.37),
                    height: (size.getHeight() * 0.18) / 2,
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          width: (size.getWidth() -
                                  size.getWidth() * 0.1 -
                                  size.getWidth() * 0.37) *
                              0.54,
                          child: IconButton(
                            icon: const Icon(Icons.favorite,
                                size: 30, color: Colors.red),
                            onPressed: (() => print(index)),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 3, left: size.getWidth() * 0.023),
                          width: (size.getWidth() -
                                  size.getWidth() * 0.1 -
                                  size.getWidth() * 0.37) *
                              0.46,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            Price(product['ProductPrice']) + ' \$',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16 *
                                    double.parse(textScaleFactor.toString()),
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            Container(
              width: size.getWidth() * 0.37,
              height: size.getHeight(),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  ProductImageUrl + product['ProductImage'],
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ));
  }
}
