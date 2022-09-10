import 'package:flutter/material.dart';
import 'package:store/Constants/Size.dart';

class CategoryScreen extends StatefulWidget {
  var category;
  CategoryScreen(this.category);

  @override
  State<CategoryScreen> createState() => CcategoryScreenState(category);
}

class CcategoryScreenState extends State<CategoryScreen> {
  var category;
  CcategoryScreenState(this.category);
  @override
  Widget build(BuildContext context) {
    var size = MSize(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
              SizedBox(height: size.getHeight() * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
