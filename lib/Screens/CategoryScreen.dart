import 'package:flutter/material.dart';
import 'package:store/Constants/Colors.dart';
import 'package:store/Constants/Server.dart';
import 'package:store/Constants/Size.dart';
import 'package:store/Screens/HomeScreen.dart';
import 'package:store/Screens/Product.dart';

class CategoryScreen extends StatefulWidget {
  var category;
  var Products;
  CategoryScreen(this.category, this.Products);

  @override
  State<CategoryScreen> createState() =>
      CcategoryScreenState(category, Products);
}

class CcategoryScreenState extends State<CategoryScreen> {
  var category;
  var Products;
  var result;
  var isLoaded = false;
  CcategoryScreenState(this.category, this.Products);
  @override
  void initState() {
    super.initState();
    var temp = [];
    for (var i = 0; i < Products.length; i++) {
      if (category["_id"] == Products[i]['CategoryId']) {
        temp.add(Products[i]);
      }
    }
    setState(() {
      result = temp;
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MSize(context);
    return SafeArea(
      child: Scaffold(
        body: (isLoaded)
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: size.getHeight() * 0.1,
                      width: size.getWidth(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: size.getWidth() * 0.2),
                          Container(
                            width: size.getWidth() * 0.6,
                            alignment: Alignment.center,
                            child: Text(
                              category['CategoryName'],
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            width: size.getWidth() * 0.2,
                            child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.getHeight() * 0.02),
                    (result.length == 0)
                        ? Column(
                            children: [
                              SizedBox(
                                height: size.getHeight() * 0.14,
                              ),
                              Container(
                                child: Image.asset(
                                  'assets/images/CategoryEmpety.png',
                                  height: size.getHeight() * 0.33,
                                ),
                              ),
                              SizedBox(
                                height: size.getHeight() * 0.03,
                              ),
                              Container(
                                width: size.getWidth(),
                                alignment: Alignment.center,
                                child: Text(
                                  "لا يوجد منتجات لصالح هذه الشركة في الوقت الحالي",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          )
                        : GridView.custom(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            // scrollDirection: Axis.vertical,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            childrenDelegate: SliverChildListDelegate(
                              [
                                for (var i = 0; i < result.length; i++)
                                  Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: size.getWidth() * 0.02,
                                          vertical: size.getHeight() * 0.01),
                                      width: size.getWidth() * 0.36,
                                      height: size.getHeight() * 0.33,
                                      decoration: BoxDecoration(
                                        color: ProductColor,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.4),
                                              blurRadius: 10.0,
                                              offset: const Offset(0, 0))
                                        ],
                                      ),
                                      child: InkWell(
                                        onTap: (() => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductPage(result[i])),
                                            )),
                                        child: Column(
                                          children: [
                                            Container(
                                                child: ClipRRect(
                                              borderRadius: const BorderRadius
                                                      .only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(
                                                      10)), //add border radius
                                              child: Image.network(
                                                ProductImageUrl +
                                                    result[i]["ProductImage"],
                                                height: size.getHeight() * 0.2,
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
                                                result[i]["ProductName"],
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    height: 1.3,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: size.getHeight() *
                                                        0.024),
                                              ),
                                            ),
                                            SizedBox(
                                                height:
                                                    size.getHeight() * 0.01),
                                            Container(
                                              width: size.getWidth(),
                                              padding: EdgeInsets.fromLTRB(0, 0,
                                                  size.getHeight() * 0.005, 0),
                                              child: Text(
                                                (Price(result[i]['ProductPrice']
                                                        .toString()) +
                                                    ' \$'),
                                                style: const TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))
                              ],
                            ),
                          )
                  ],
                ),
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
