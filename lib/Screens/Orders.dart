import 'package:flutter/material.dart';
import 'package:store/Constants/Size.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    var size = MSize(context);
    return SafeArea(
      child: Scaffold(
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
                                color: Colors.blue,
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
          ],
        )),
      ),
    );
  }
}
