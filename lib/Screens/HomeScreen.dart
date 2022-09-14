import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:store/Constants/Colors.dart';
import 'package:store/Constants/Server.dart';
import 'package:store/Constants/Size.dart';
import 'package:store/Screens/CategoryScreen.dart';
import 'package:store/Screens/Product.dart';

class HomeScreen extends StatefulWidget {
  var res;
  var Products;
  HomeScreen(this.res, this.Products);
  @override
  State<HomeScreen> createState() => _HomeScreenState(res, Products);
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> images = [
    "https://tech-echo.com/wp-content/uploads/2018/09/iphone-xr-specifications-585x265.jpg",
    "https://img.youm7.com/xlarge/201905130453315331.jpg"
  ];
  var activePage = 0;

  var res;
  var Products;

  _HomeScreenState(this.res, this.Products);
  bool _on = true;

  var DollarPrice = 1480;

  @override
  Widget build(BuildContext context) {
    var size = MSize(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(height: size.getHeight() * 0.01),
          carouselSlider(size),
          SizedBox(height: size.getHeight() * 0.05),
          GridView(
            scrollDirection: Axis.vertical, //default
            reverse: false,
            primary: false,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(5.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0,
            ),
            children: [
              for (var i = 0; i < res['Categories'].length; i++)
                InkWell(
                  onTap: () {
                    // CategoryScreen
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryScreen(
                                res['Categories'][i], Products)));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      CategoryImageUrl + res['Categories'][i]['CategoryImage'],
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: size.getHeight() * 0.05),
          Column(
            children: [
              Row(
                children: [
                  SizedBox(width: size.getWidth() * 0.05),
                  Container(
                    width: size.getWidth() * 0.3,
                    child: Text(
                      'الاكثر مبيعاً',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: size.getWidth() * 0.06,
                      ),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    child: Container(
                        width: 30,
                        height: 30,
                        child: (_on)
                            ? Image.asset('assets/images/money-1.png')
                            : Image.asset('assets/images/money.png')),
                    onTap: () {
                      setState(() {
                        _on = !_on;
                      });
                    },
                  ),
                  SizedBox(width: size.getWidth() * 0.05),
                ],
              ),
              Container(
                  width: double.infinity,
                  child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: size.getWidth() * 0.05),
                            for (var i = 0; i < res['topSell'].length; i++)
                              Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: size.getWidth() * 0.02,
                                      vertical: size.getHeight() * 0.02),
                                  width: size.getWidth() * 0.36,
                                  height: size.getHeight() * 0.25,
                                  decoration: BoxDecoration(
                                    color: ProductColor,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.4),
                                          blurRadius: 10.0,
                                          offset: const Offset(0, 0))
                                    ],
                                  ),
                                  child: InkWell(
                                    onTap: (() => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ProductPage(
                                                  res['topSell'][i])),
                                        )),
                                    child: Column(
                                      children: [
                                        Container(
                                            child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(
                                                  10)), //add border radius
                                          child: Image.network(
                                            ProductImageUrl +
                                                res['topSell'][i]
                                                    ["ProductImage"],
                                            height: size.getHeight() * 0.16,
                                            width: size.getWidth(),
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                                        SizedBox(
                                          height: size.getHeight() * 0.01,
                                        ),
                                        Container(
                                          width: size.getWidth(),
                                          padding: EdgeInsets.fromLTRB(0, 0,
                                              size.getHeight() * 0.005, 0),
                                          child: Text(
                                            res['topSell'][i]["ProductName"],
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                height: 1.3,
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                    size.getHeight() * 0.024),
                                          ),
                                        ),
                                        SizedBox(
                                            height: size.getHeight() * 0.01),
                                        Container(
                                          width: size.getWidth(),
                                          padding: EdgeInsets.fromLTRB(0, 0,
                                              size.getHeight() * 0.005, 0),
                                          child: Text(
                                            ((_on)
                                                ? Price(res['topSell'][i]
                                                            ['ProductPrice']
                                                        .toString()) +
                                                    ' \$'
                                                : Price((res['topSell'][i][
                                                                'ProductPrice'] *
                                                            1480)
                                                        .toString()) +
                                                    ' IQD'),
                                            style: const TextStyle(
                                                color: Colors.black54,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ))
                          ]))),
              SizedBox(height: size.getHeight() * 0.05),
              Container(
                  decoration: BoxDecoration(
                    color: ExchangeCardColor,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  height: size.getHeight() * 0.1,
                  margin:
                      EdgeInsets.symmetric(horizontal: size.getWidth() * 0.06),
                  child: Row(
                    // mainAxisAlignment,
                    children: [
                      Container(
                        width: size.getWidth() * 0.872 / 2,
                        // color: Colors.amber,
                        padding: EdgeInsets.fromLTRB(0, size.getHeight() * 0.01,
                            size.getWidth() * 0.03, 0),
                        child: Column(children: const [
                          Text(
                            'دولار امريكي',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Text('100 \$',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16))
                        ]),
                      ),
                      Container(
                        // color: Colors.red,

                        padding: EdgeInsets.symmetric(
                            vertical: size.getHeight() * 0.01),
                        // width: size.getWidth() * 0.88 / 3,
                        child: Center(
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white54,
                                    borderRadius: BorderRadius.circular(10)),
                                width: size.getWidth() * 0.008)),
                      ),
                      Container(
                        width: size.getWidth() * 0.872 / 2,
                        padding: EdgeInsets.symmetric(
                            vertical: size.getHeight() * 0.01),
                        child: Column(children: [
                          const Text(
                            'دينار عراقي',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Text(Price(100 * DollarPrice) + ' IQD',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16))
                        ]),
                      )
                    ],
                  ))
            ],
          ),
          SizedBox(height: size.getHeight() * 0.05),
        ],
      )),
    );
  }

  // Widget bulder(name, data, size) {}

  // List<Widget> childrenOFList(data, size, on) {}

  Widget carouselSlider(size) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
        onPageChanged: (index, reason) {
          setState(
            () {
              activePage = index;
            },
          );
        },
      ),
      items: images
          .map(
            (item) => InkWell(
              onTap: (() {
                print(item);
              }),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                width: size.getWidth() * 0.9,
                height: size.getHeight() * 0.1,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  child: Image.network(
                    item,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

dynamic Price(price) {
  var reverse = price.toString().split('').reversed.join('').trim();
  var temp = '';
  if (reverse.length > 3) {
    for (var i = 0; i < reverse.length; i++) {
      if (i % 3 == 0 && i != 0) {
        temp += ',' + reverse[i];
      } else {
        temp += reverse[i];
      }
    }
  } else {
    return price;
  }
  return temp.split('').reversed.join('');
}
