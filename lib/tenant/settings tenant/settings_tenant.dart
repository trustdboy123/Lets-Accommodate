import 'package:flutter/material.dart';
import 'package:lets_accommodate/tenant/settings%20tenant/edit_profile_tenant.dart';

class SettingsTenant extends StatefulWidget {
  const SettingsTenant({Key? key}) : super(key: key);

  @override
  State<SettingsTenant> createState() => _SettingsTenantState();
}

class _SettingsTenantState extends State<SettingsTenant> {
  String dropdownValuemail = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
          actions: [
            TextButton(
                onPressed: () {},
                child: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1589317621382-0cbef7ffcc4c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80'),
                    radius: 100,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return EditProfileTenant();
                          }));
                        },
                        child: Text('Edit Profile')),
                  ),
                  Text(
                    'Bernice Mensah',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Icon(Icons.help),
                  Text(
                    'Need help?  Contact us',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    child: DropdownButton<String>(
                  alignment: AlignmentDirectional.centerStart,
                  value: dropdownValuemail,
                  icon: const Icon(Icons.arrow_drop_down),
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  underline: Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValuemail = newValue!;
                    });
                  },
                  items: <String>[
                    '',
                    'letsaccommodate@gmail.com',
                    'Facebook page - Lets Accommodate'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )),
              ),
            ],
          ),
        ));
  }
}
