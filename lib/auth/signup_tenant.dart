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
              Text('Full name'),
              SizedBox(height: 5),
              Card(
                child: TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    label: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    hintText: 'Enter your full name',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter you full name';
                    }
                    return null;
                  },
                ),
              
              ),
              SizedBox(
                height: 10,
              ),
              Text('E-mail'),
              SizedBox(height: 5),
              Card(
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    label: Icon(Icons.email),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    hintText: 'Enter your E-mail',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  ),
                  validator: (value) {
                    if (!emailRegExp.hasMatch(value!)) {
                      return 'Enter a valid email!';
                    }

                    if (value.isEmpty) {
                      return 'Please enter an email address';
                    }
                  },
                ),
               
              ),
              SizedBox(
                height: 10,
              ),
              Text('Password'),
              SizedBox(height: 5),
              Card(
                child: TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    label: Icon(Icons.lock),
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
              Text('Gender'),
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
              Text('Location/Digital Address'),
              SizedBox(height: 5),
              Card(
                child: TextFormField(
                  controller: _locationController,
                  keyboardType: TextInputType.streetAddress,
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    hintText: 'Enter your location/ Digital Address',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your location';
                    }
                  },
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
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  hintText: 'Enter your phone number',
                  labelText: 'Phone Number',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your Phonenumber";
                  }
                  if (value.length < 10) {
                    return 'Please enter a complete number';
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text('Nationality'),
              SizedBox(height: 5),
              Card(
                child: TextFormField(
                  controller: _nationalityController,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    hintText: 'Ghanaian',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Nationality';
                    }
                  
                },
                ),
                
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
                            String name = _nameController.text.trim();
                            String email = _emailController.text.trim();
                            String phone = _numberController.text.trim();
                            String password = _passwordController.text.trim();
                            String location = _locationController.text;
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
                                number: phone,
                                nationality: nationality);

                            if (isCreated) {
                              setState(() {
                                _isLoading = false;
                              });
                              // navigatorKey.currentState!.pushAndRemoveUntil(
                              //     MaterialPageRoute(builder: (context) {
                              //   return CategoriesTenant();
                              // }), (route) => false);
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context) {
                                return IndexView();
                              }), (route) => false);

                              Fluttertoast.showToast(
                                  msg: "$name, Welcome to Lets Accommodate",
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
                                msg: "Please check all fields",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
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
