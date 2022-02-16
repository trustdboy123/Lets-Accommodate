import 'package:flutter/material.dart';
import 'package:lets_accommodate/auth/login_landlord.dart';

class SignupLandlord extends StatefulWidget {
  const SignupLandlord({Key? key}) : super(key: key);

  @override
  State<SignupLandlord> createState() => _SignupLandlordState();
}

class _SignupLandlordState extends State<SignupLandlord> {
  String dropdownValue = 'Male';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Your Account',
        ),
      ),
      body: SafeArea(
        child: Form(
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              Text('Full name'),
              SizedBox(height: 5),
              Card(
                child: TextFormField(
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
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('E-mail'),
              SizedBox(height: 5),
              Card(
                child: TextFormField(
                  keyboardType: TextInputType.text,
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
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Password'),
              SizedBox(height: 5),
              Card(
                child: TextFormField(
                  keyboardType: TextInputType.text,
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
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Gender'),
              SizedBox(height: 5),
              Card(
                  child: DropdownButton<String>(
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
              )),
              SizedBox(
                height: 10,
              ),
              Text('Location/Digital Address'),
              SizedBox(height: 5),
              Card(
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
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
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Phone Number'),
              SizedBox(height: 5),
              Card(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    hintText: 'Enter your phone number',
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
              Text('Nationality'),
              SizedBox(height: 5),
              Card(
                child: TextFormField(
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
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const LoginLandlord();
                      }));
                    },
                    style: TextButton.styleFrom(backgroundColor: Colors.blue),
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
