import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lets_accommodate/auth/login_tenant.dart';
import 'package:lets_accommodate/managers/auth_manager.dart';
import 'package:lets_accommodate/tenant/categories_tenant.dart';
import 'package:lets_accommodate/tenant/index_view.dart';

class SignupTenant extends StatefulWidget {
  SignupTenant({Key? key}) : super(key: key);

  @override
  State<SignupTenant> createState() => _SignupTenantState();
}

class _SignupTenantState extends State<SignupTenant> {
  String dropdownValue = 'Male';
  GlobalKey<FormState> _globalKey = GlobalKey();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  String dropdownValueRegion = 'Select option';
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  bool _isLoading = false;

  final AuthManager _authManager = AuthManager();

  final emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Your Account',
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _globalKey,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              Card(
                child: TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    labelText: 'Full Name *',
                    labelStyle:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    hintText: 'Enter your full name',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    labelText: 'E-mail *',
                    labelStyle: TextStyle(fontWeight: FontWeight.w600),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    hintText: 'Enter your E-mail',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                child: TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    labelText: 'Password *',
                    labelStyle: TextStyle(fontWeight: FontWeight.w600),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    hintText: 'Enter your your location',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password should not be less than 6 characters';
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Gender *'),
              SizedBox(height: 5),
              DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_drop_down),
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                underline: Container(
                  height: 2,
                  color: Colors.black,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>[
                  'Male',
                  'Female',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _locationController,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Location/ Digital Address *',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  hintText: 'Enter your location/ Digital Address',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _numberController,
                keyboardType: TextInputType.number,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: 'Phone Number *',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  hintText: 'Enter your phone number',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  if (value.length < 10) {
                    return 'Please enter a complete number';
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _nationalityController,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  hintText: 'Ghanaian *',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your nationality';
                  }
                },
              ),
              Text('Region', style: TextStyle(fontWeight: FontWeight.bold)),
              DropdownButtonFormField(
                value: dropdownValueRegion,
                icon: const Icon(Icons.arrow_drop_down),
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValueRegion = newValue!;
                  });
                },
                items: <String>[
                  'Select option',
                  'Ashanti Region',
                  'Ahafo Region',
                  'Bono East',
                  'Central Region',
                  'Eastern Region',
                  'Greater Accra',
                  'Northern Region',
                  'North East',
                  'Oti Region',
                  'Savannah Region',
                  'Upper East Region',
                  'Upper West Region',
                  'Volta Region',
                  'Western Region',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : TextButton(
                        onPressed: () async {
                          if (_globalKey.currentState!.validate()) {
                            String name = _nameController.text;
                            String email = _emailController.text;
                            String password = _passwordController.text;
                            String location = _locationController.text;
                            String number = _numberController.text;
                            String nationality = _nationalityController.text;
                            String gender = dropdownValue.toString();
                            setState(() {
                              _isLoading = true;
                            });

                            bool isCreated = await _authManager.createNewUser(
                                name: name,
                                email: email,
                                password: password,
                                gender: gender,
                                location: location,
                                number: number,
                                nationality: nationality,
                                region: dropdownValueRegion.toString());

                            if (isCreated) {
                              setState(() {
                                _isLoading = false;
                              });

                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) {
                                return LoginTenant();
                              }), (route) => false);
                              Fluttertoast.showToast(
                                  msg: "$name, Please Login Now",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor:
                                      Color.fromARGB(255, 94, 196, 97),
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {
                              Fluttertoast.showToast(
                                  msg: _authManager.message,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          } else {
                            // validation failed
                            Fluttertoast.showToast(
                                msg: " Please Check all fields",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor:
                                    Color.fromARGB(255, 94, 196, 97),
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.blue),
                        child: Text(
                          'Create Account',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        )),
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
