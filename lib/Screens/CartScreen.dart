import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:store/Constants/Colors.dart';
import 'package:store/Constants/Server.dart';
import 'package:store/Constants/Size.dart';
import 'package:store/Screens/CompleteOrder.dart';
import 'package:store/Screens/HomeScreen.dart';
import 'package:store/Screens/Orders.dart';

class CartScreen extends StatefulWidget {
  var Products;
  CartScreen(this.Products);

  @override
  State<CartScreen> createState() => _CartScreenState(Products);
}

class _CartScreenState extends State<CartScreen> {
  var Result;

  Future<void> getData() async {
    var box = await Hive.openBox('Carts');

    var temp = await box.values.toList();

    setState(() {
      Result = temp;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  void addOne(IDS, Product) async {
    var box = await Hive.openBox('Carts');
    var temp = await box.values.toList();
    for (var i = 0; i < temp.length; i++) {
      if (temp[i][0]['ID'] == IDS[0]['ID']) {
        temp[i].add({
          'ID': IDS[0]['ID'].toString(),
          'Color': Product['Colors'][0]['ColorHex']
        });
        await box.clear();
        for (var j = 0; j < temp.length; j++) {
          await box.add(temp[j]);
        }
        setState(() {
          Result = box.values.toList();
        });
        break;
      }
    }
  }

  void UpdateColor(ID, index, hex) async {
    var box = await Hive.openBox('Carts');
    var temp = await box.values.toList();
    for (var i = 0; i < temp.length; i++) {
      if (temp[i][0]['ID'] == ID) {
        temp[i][index] = {'Color': hex, 'ID': ID};
        await box.clear();
        for (var j = 0; j < temp.length; j++) {
          await box.add(temp[j]);
        }
        setState(() {
          Result = box.values.toList();
        });
        break;
      }
    }
  }

  void deleteOne(IDS) async {
    var box = await Hive.openBox('Carts');
    var temp = await box.values.toList();
    for (var i = 0; i < temp.length; i++) {
      if (temp[i][0]['ID'] == IDS[0]['ID']) {
        if (temp[i].length > 1) {
          temp[i].removeAt(temp[i].length - 1);
          await box.clear();
          for (var j = 0; j < temp.length; j++) {
            await box.add(temp[j]);
          }

          setState(() {
            Result = box.values.toList();
          });
          break;
        } else {
          await box.deleteAt(i);
          setState(() {
            Result = box.values.toList();
          });
        }
      }
    }
  }

  var Products;
  _CartScreenState(this.Products);
  @override
  Widget build(BuildContext context) {
    var size = MSize(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: (Result != null)
            ? SingleChildScrollView(
                child: Column(children: [
                Container(
                    height: size.getHeight() * 0.1,
                    width: size.getWidth(),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(right: size.getWidth() * 0.05),
                            child: const Text('سلة التسوق',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500)),
                          ),
                          Container(
                            width: size.getWidth() * 0.3,
                            height: size.getHeight() * 0.05,
                            child: Row(children: [
                              InkWell(
                                child: Container(
                                    height: size.getHeight() * 0.05,
                                    width: size.getWidth() * 0.1,
                                    child: SvgPicture.asset(
                                      'assets/icons/truck.svg',
                                      color: Colors.black,
                                    )),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Orders()));
                                },
                              ),
                              SizedBox(width: size.getWidth() * 0.02),
                              Container(
                                  height: size.getHeight() * 0.04,
                                  padding: EdgeInsets.only(
                                      bottom: size.getHeight() * 0.002),
                                  width: size.getWidth() * 0.1,
                                  child: SvgPicture.asset(
                                    'assets/icons/UnselectedBag.svg',
                                    color: Colors.blue,
                                  )),
                            ]),
                          )
                        ])),
                (Result.length == 0)
                    ? Column(
                        children: [
                          SizedBox(height: size.getHeight() * 0.07),
                          Container(
                            width: size.getWidth(),
                            height: size.getHeight() * 0.4,
                            alignment: Alignment.center,
                            child: Image.asset('assets/images/CartEmpety.png'),
                          ),
                          const Text(
                            "لا توجد منتجات في عربة التسوق",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    : Container(),
                for (var i = 0; i < Result.length; i++)
                  InkWell(
                    onTap: () {
                      var Product;
                      for (var j = 0; j < Products.length; j++) {
                        if (Products[j]['_id'].toString() ==
                            Result[i][0]['ID'].toString()) {
                          Product = Products[j];
                          break;
                        }
                      }
                      showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          backgroundColor: Colors.white,
                          builder: (context) {
                            return SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    height: size.getHeight() * 0.08,
                                    width: size.getWidth(),
                                    alignment: Alignment.centerRight,
                                    padding: EdgeInsets.only(
                                      right: size.getWidth() * 0.02,
                                    ),
                                    child: Text(
                                      "الوان المنتج",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 21,
                                      ),
                                    ),
                                  ),
                                  for (var j = 0; j < Result[i].length; j++)
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: size.getHeight() * 0.01,
                                          bottom: size.getHeight() * 0.01),
                                      width: size.getWidth(),
                                      height: size.getHeight() * 0.08,
                                      child: Row(
                                        children: [
                                          Container(
                                              width: size.getWidth() * 0.8,
                                              height: size.getHeight() * 0.08,
                                              child: ColorsView(
                                                  Product,
                                                  size,
                                                  Result[i][j]['Color']
                                                      .toString(),
                                                  j)),
                                          Container(
                                            alignment: Alignment.center,
                                            width: size.getWidth() * 0.2,
                                            height: size.getHeight() * 0.08,
                                            child: Text(
                                                ' - ' + (j + 1).toString(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 23,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          )
                                        ],
                                      ),
                                    ),
                                  SizedBox(
                                    height: size.getHeight() * 0.08,
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    child: Container(
                      height: size.getHeight() * 0.18,
                      margin: EdgeInsets.symmetric(
                          horizontal: size.getWidth() * 0.05,
                          vertical: size.getHeight() * 0.01),
                      width: size.getWidth() * 0.9,
                      child: ProductWidget(Result[i], size),
                    ),
                  ),
                (Result.length > 0)
                    ? InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CompleteOrder()));
                        },
                        child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: size.getHeight() * 0.03),
                            height: size.getHeight() * 0.1,
                            width: size.getWidth() * 0.85,
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(14)),
                            alignment: Alignment.center,
                            child: const Text(
                              'اكمال الطلب',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.white),
                            )),
                      )
                    : Container()
              ]))
            : const Center(child: CircularProgressIndicator()));
  }

  Widget ColorsView(product, size, _color, index) {
    var color;
    for (var i = 0; i < product['Colors'].length; i++) {
      if (product['Colors'][i]['ColorHex'] == _color) {
        color = i;
        break;
      }
    }
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (var i = 0; i < product['Colors'].length; i++)
              InkWell(
                onTap: (() => setState(() {
                      UpdateColor(product['_id'], index,
                          product['Colors'][i]['ColorHex']);
                      color = i;
                    })),
                child: Container(
                    height: size.getHeight() * 0.07,
                    width: size.getHeight() * 0.07,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(
                        horizontal: size.getWidth() * 0.02),
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            blurRadius: 10.0,
                            offset: const Offset(0, 0))
                      ],
                      borderRadius: BorderRadius.circular(100),
                      color: Color(int.parse("0xFF" +
                          product['Colors'][i]['ColorHex'].substring(1))),
                    ),
                    child: (color == i)
                        ? Icon(Icons.check,
                            color: (i < product['Colors'].length - 1)
                                ? Color(int.parse("0xFF" +
                                    product['Colors'][i + 1]['ColorHex']
                                        .substring(1)))
                                : Color(int.parse("0xFF" +
                                    product['Colors'][i - 1]['ColorHex']
                                        .substring(1))))
                        : Container()),
              )
          ],
        ),
      );
    });
  }

  Widget ProductWidget(IDS, size) {
    var Product;
    var sum = IDS.length;
    for (var i = 0; i < Products.length; i++) {
      if (Products[i]['_id'].toString() == IDS[0]['ID'].toString()) {
        Product = Products[i];
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
                    Product['ProductName'],
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
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
                            width: (size.getWidth() -
                                    size.getWidth() * 0.1 -
                                    size.getWidth() * 0.37) *
                                0.54,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    child: Container(
                                      width: size.getHeight() * 0.05,
                                      height: size.getHeight() * 0.05,
                                      decoration: BoxDecoration(
                                          color: ProductColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      alignment: Alignment.center,
                                      child: Icon(Icons.add, size: 30),
                                    ),
                                    onTap: (() => addOne(IDS, Product)),
                                  ),
                                  Container(
                                    // margin: EdgeInsets.symmetric(horizontal: ),
                                    width: size.getHeight() * 0.05,
                                    height: size.getHeight() * 0.05,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.blueAccent,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      sum.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => deleteOne(IDS),
                                    child: Container(
                                      width: size.getHeight() * 0.05,
                                      height: size.getHeight() * 0.05,
                                      decoration: BoxDecoration(
                                          color: ProductColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      alignment: Alignment.center,
                                      child: const Icon(
                                        Icons.remove,
                                        color: Colors.black,
                                        size: 28,
                                      ),
                                    ),
                                  )
                                ])),
                        Container(
                          padding: EdgeInsets.only(
                              top: 3, left: size.getWidth() * 0.023),
                          width: (size.getWidth() -
                                  size.getWidth() * 0.1 -
                                  size.getWidth() * 0.37) *
                              0.46,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            Price(sum * Product['ProductPrice']) + ' \$',
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
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
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  ProductImageUrl + Product['ProductImage'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ));
  }
}
