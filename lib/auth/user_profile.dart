import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:biochemic_master/Shared/constant.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  TextEditingController passwordController = TextEditingController();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Constant.primaryColor,
        centerTitle: true,
        title: const Text("My Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.width / 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 62,
                      backgroundImage: Images.logoImg)
                ],
              ),
              const SizedBox(height: 24),
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Text("Name",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w800))),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Constant.primaryColor)),
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          Constant.name,
                          style: const TextStyle(fontSize: 16),
                        ))),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Text("Email",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Constant.primaryColor)),
                    child: Padding(

                        padding: const EdgeInsets.all(16.0),
                        child: Text(Constant.email,
                            style: const TextStyle(fontSize: 16)))),
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Text("Password",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w800))),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                child: TextFormField(
                    obscureText: !showPassword,
                    controller: passwordController,
                    textCapitalization: TextCapitalization.sentences,
                    inputFormatters: [LengthLimitingTextInputFormatter(20)],
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          icon: const Icon(Icons.remove_red_eye),
                          onPressed: () =>
                              setState(() => showPassword = !showPassword),
                          color: Constant.primaryColor),
                      contentPadding: const EdgeInsets.all(16),
                      hintText: 'Enter Password',
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Constant.primaryColor)),
                      disabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(
                              width: 1, color: Constant.primaryColor)),
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(
                              width: 1, color: Constant.primaryColor)),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(
                              width: 1, color: Constant.primaryColor)),
                      // errorBorder: const OutlineInputBorder(
                      //      borderRadius: BorderRadius.all(Radius.circular(4)),
                      //      borderSide:
                      //          BorderSide(width: 1, color: Constant.primaryColor)),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return "Please Enter Password";
                      }
                      return null;
                    }),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        primary: Constant.primaryColor),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      child: Text(
                        'Update',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
