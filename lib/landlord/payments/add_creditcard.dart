import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AddCreditcard extends StatefulWidget {
  const AddCreditcard({Key? key}) : super(key: key);

  @override
  State<AddCreditcard> createState() => _AddCreditcardState();
}

class _AddCreditcardState extends State<AddCreditcard> {
  final TextEditingController _cardnumberController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _cardholdernameController =
      TextEditingController();
  final TextEditingController _issuedateController = TextEditingController();
  final TextEditingController _expirydateController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Credit Card'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _globalKey,
              child: ListView(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _cardnumberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        label: Text('Card Number'),
                        hintText: '2736 5337 9263 8678'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _cvvController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: ('273'),
                        label: Text('CVV'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _cardholdernameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: ('Kwaku Siaw Lartey'),
                        label: Text('Card Holder\'s Name'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                        controller: _issuedateController,
                        keyboardType: TextInputType.none,
                        showCursor: false,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            hintText: ('DD/MM/YYYY'),
                            label: Text('Issue Date')),
                        onTap: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate:
                                      DateTime.now().add(Duration(days: 365)))
                              .then((value) {
                            setState(() {
                              _issuedateController.text =
                                  DateFormat.yMMMMd().format(value!);
                            });
                          });
                        },
                      )),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: TextFormField(
                        controller: _expirydateController,
                        keyboardType: TextInputType.none,
                        showCursor: false,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            hintText: ('DD/MM/YYYY'),
                            label: Text('Expiry Date')),
                        onTap: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate:
                                      DateTime.now().add(Duration(days: 365)))
                              .then((value) {
                            setState(() {
                              _expirydateController.text =
                                  DateFormat.yMMMMd().format(value!);
                            });
                          });
                        },
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.blue),
                        onPressed: () {},
                        child: Text(
                          'Pay',
                          style: TextStyle(color: Colors.white),
                        )),
                  )
                ],
              ),
            )));
  }
}
