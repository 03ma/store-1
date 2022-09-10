import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:store/Constants/Size.dart';
import 'package:store/main.dart';

class CompleteOrder extends StatefulWidget {
  const CompleteOrder({Key? key}) : super(key: key);

  @override
  State<CompleteOrder> createState() => _CompleteOrderState();
}

class _CompleteOrderState extends State<CompleteOrder> {
  var Name = '';
  var Phone = '';
  var Address = '';

  @override
  Widget build(BuildContext context) {
    var size = MSize(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          right: false,
          left: false,
          child: Column(
            children: [
              Container(
                  height: size.getHeight() * 0.1,
                  width: size.getWidth(),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin:
                              EdgeInsets.only(right: size.getWidth() * 0.05),
                          child: const Text('اكمال الطلب',
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
              SizedBox(height: size.getHeight() * 0.05),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: size.getWidth() * 0.93,
                    height: size.getHeight() * 0.133,
                    child: TextFormField(
                      onChanged: (value) => setState(() {
                        Name = value;
                      }),
                      maxLength: 36,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: 'الاسم',
                        hintStyle: const TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.black54),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.1),
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 1.2),
                        ),
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(right: size.getWidth() * 0.01),
                      child: Text(
                        '${Name.length}/36',
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 16),
                      ))
                ],
              ),
              SizedBox(height: size.getHeight() * 0.05),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.getWidth() * 0.035,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: size.getWidth() * 0.71,
                        height: size.getHeight() * 0.133,
                        child: TextFormField(
                          // textAlign: TextAlign.end,
                          onChanged: (value) => setState(() {
                            Phone = value;
                          }),
                          maxLength: 11,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                          ),
                          decoration: InputDecoration(
                            counterText: '',
                            hintText: 'رقم الهاتف',
                            hintStyle: const TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide:
                                  const BorderSide(color: Colors.black54),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.1),
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 1.2),
                            ),
                            labelStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      Container(
                          margin:
                              EdgeInsets.only(right: size.getWidth() * 0.01),
                          child: Text(
                            '${Phone.length}/11',
                            style: const TextStyle(
                                color: Colors.black54, fontSize: 16),
                          ))
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: size.getWidth() * 0.03),
                    width: size.getWidth() * 0.19,
                    height: size.getHeight() * 0.113,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: const Border(
                        right: BorderSide(color: Colors.black54, width: 1.5),
                        left: BorderSide(color: Colors.black54, width: 1.5),
                        top: BorderSide(color: Colors.black54, width: 1.5),
                        bottom: BorderSide(color: Colors.black54, width: 1.5),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      '+964',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.getHeight() * 0.05),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: size.getWidth() * 0.93,
                    height: size.getHeight() * 0.20,
                    child: TextFormField(
                      onChanged: (value) => setState(() {
                        Address = value;
                      }),
                      maxLength: 180,
                      maxLines: 3,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: 'العنوان',
                        hintStyle: const TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.black54),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.1),
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 1.2),
                        ),
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(right: size.getWidth() * 0.01),
                      child: Text(
                        '${Address.length}/180',
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 16),
                      ))
                ],
              ),
              SizedBox(height: size.getHeight() * 0.05),
              Container(
                width: size.getWidth() * 0.4,
                height: size.getHeight() * 0.085,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'شراء',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
