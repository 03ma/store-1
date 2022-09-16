import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:store/Constants/Server.dart';
import 'package:store/Constants/Size.dart';
import 'package:http/http.dart' as http;
import 'package:store/Screens/BottomNavigationBar.dart';

class CompleteOrder extends StatefulWidget {
  const CompleteOrder({Key? key}) : super(key: key);

  @override
  State<CompleteOrder> createState() => _CompleteOrderState();
}

class _CompleteOrderState extends State<CompleteOrder> {
  var Name = '';
  var Phone = '';
  var Address = '';
  var isCompleted = false;

  void MakeOrder() async {
    final token = GetStorage();
    var UserID = await token.read('USER_ID');
    var box = await Hive.openBox('Carts');
    var temp = await box.values.toList();
    var Products = [];

    for (var i = 0; i < temp.length; i++) {
      var Color = [];
      for (var j = 0; j < temp[i].length; j++) {
        Color.add({"color": temp[i][j]['Color']});
      }
      Products.add({
        "quantity": temp[i].length,
        "ProductID": temp[i][0]['ID'].toString(),
        "Colors": Color
      });
    }
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(url + '/order/new'));
    request.body = json.encode({
      "buyerName": Name,
      "buyerPhone": '0' + Phone,
      "buyerAddress": Address,
      'buyerId': UserID,
      "products": Products
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(Uri.parse(url + '/order/new'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    var size = MSize(context);
    return SafeArea(
      right: false,
      left: false,
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
                          margin:
                              EdgeInsets.only(right: size.getWidth() * 0.05),
                          child: Text('اكمال الطلب',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 24 * textScaleFactor,
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
                                        if (!isCompleted)
                                          Navigator.pop(context);
                                        else
                                          Navigator.of(context).pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                  builder: (context) => SafeArea(
                                                      child:
                                                          BottomNavigationBarScreen())),
                                              (Route<dynamic> route) => false);
                                      }),
                                )
                              ]),
                        )
                      ])),
              SizedBox(height: size.getHeight() * 0.05),
              Container(
                width: size.getWidth() * 0.93,
                height: size.getHeight() * 0.133,
                child: TextFormField(
                  onChanged: (value) => setState(() {
                    Name = value;
                  }),
                  maxLength: 36,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24 * textScaleFactor,
                  ),
                  decoration: InputDecoration(
                    counterText: '',
                    hintText: 'الاسم',
                    hintStyle: TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                        fontSize: 20 * textScaleFactor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.black54),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.1),
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 1.2),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 15 * textScaleFactor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.getHeight() * 0.05),
              Container(
                height: size.getHeight() * 0.133,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.getWidth() * 0.035,
                    ),
                    Container(
                      width: size.getWidth() * 0.71,
                      height: size.getHeight() * 0.1,
                      child: TextFormField(
                        onChanged: (value) => setState(() {
                          Phone = value;
                        }),
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24 * textScaleFactor,
                        ),
                        decoration: InputDecoration(
                          counterText: '',
                          hintText: 'رقم الهاتف',
                          hintStyle: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.bold,
                            fontSize: 20 * textScaleFactor,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.black54),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.1),
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 1.2),
                          ),
                          labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 15 * textScaleFactor,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: size.getWidth() * 0.03),
                      width: size.getWidth() * 0.19,
                      height: size.getHeight() * 0.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: const Border(
                          right: BorderSide(color: Colors.black54, width: 1.2),
                          left: BorderSide(color: Colors.black54, width: 1.2),
                          top: BorderSide(color: Colors.black54, width: 1.2),
                          bottom: BorderSide(color: Colors.black54, width: 1.2),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '+964',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 22 * textScaleFactor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
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
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24 * textScaleFactor,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: 'العنوان',
                        hintStyle: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.bold,
                            fontSize: 20 * textScaleFactor),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.black54),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.1),
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 1.2),
                        ),
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15 * textScaleFactor,
                        ),
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(right: size.getWidth() * 0.01),
                      child: Text(
                        '${Address.length}/180',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16 * textScaleFactor,
                        ),
                      ))
                ],
              ),
              SizedBox(height: size.getHeight() * 0.05),
              InkWell(
                onTap: (() async {
                  if (Phone.length == 10 &&
                      Name.length > 3 &&
                      Address.length > 6 &&
                      !isCompleted) {
                    MakeOrder();
                    isCompleted = true;
                    var box = await Hive.openBox('Carts');
                    box.clear();
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.SUCCES,
                      headerAnimationLoop: false,
                      animType: AnimType.TOPSLIDE,
                      title: 'تم ارسال طلبك',
                      desc: 'سيتم الاتصال بك في اقرب وقت',
                      dismissOnTouchOutside: false,
                      btnOk: WillPopScope(
                          onWillPop: () async {
                            return false;
                          },
                          child: InkWell(
                            onTap: (() => Navigator.of(context)
                                .pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => SafeArea(
                                            child:
                                                BottomNavigationBarScreen())),
                                    (Route<dynamic> route) => false)),
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: size.getWidth() * 0.2),
                              height: size.getHeight() * 0.06,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10)),
                              alignment: Alignment.center,
                              child: Text('اغلاق',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24 * textScaleFactor,
                                      fontWeight: FontWeight.bold)),
                            ),
                          )),
                    ).show();
                  } else if (!isCompleted) {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      headerAnimationLoop: false,
                      animType: AnimType.TOPSLIDE,
                      title: 'يرجى ادخال المعلومات كاملة',
                      dismissOnTouchOutside: false,
                      btnOkText: 'اغلاق',
                      btnOk: InkWell(
                        onTap: (() => Navigator.pop(context)),
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: size.getWidth() * 0.2),
                          height: size.getHeight() * 0.06,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10)),
                          alignment: Alignment.center,
                          child: Text('اغلاق',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24 * textScaleFactor,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      btnOkOnPress: () {},
                    ).show();
                  } else {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      headerAnimationLoop: false,
                      animType: AnimType.TOPSLIDE,
                      title: 'حدث خطأ ما',
                      dismissOnTouchOutside: false,
                      btnOkText: 'اغلاق',
                      btnOk: InkWell(
                        onTap: (() => Navigator.pop(context)),
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: size.getWidth() * 0.2),
                          height: size.getHeight() * 0.06,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10)),
                          alignment: Alignment.center,
                          child: Text('اغلاق',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24 * textScaleFactor,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      btnOkOnPress: () {},
                    ).show();
                  }
                }),
                child: Container(
                  width: size.getWidth() * 0.4,
                  height: size.getHeight() * 0.085,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'شراء',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26 * textScaleFactor,
                      fontWeight: FontWeight.w500,
                    ),
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

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
