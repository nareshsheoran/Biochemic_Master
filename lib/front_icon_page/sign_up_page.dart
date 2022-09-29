import 'package:biochemic_master/Shared/constant.dart';
import 'package:biochemic_master/Shared/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController =
  TextEditingController(text: "user1@gmail.com");
  TextEditingController passwordController =
  TextEditingController(text: "123456");
  TextEditingController confirmPasswordController =
  TextEditingController(text: "123456");
  bool showPassword = false;
  bool showCnPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 50,
                      backgroundImage: Images.logoImg,
                    ),
                    const Text("Sign up", style: TextStyle(fontSize: 24)),
                    const SizedBox(height: 10),
                    Row(
                      children: const [
                        SizedBox(width: 6),
                        Text(
                          "Email",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: emailController,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(16),
                          hintText: 'Enter Email',
                          helperMaxLines: 2,
                          hintMaxLines: 2,
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(
                                  width: 1, color: Constant.primaryColor)),
                          border: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Constant.primaryColor))),


                      validator: (String? value) {
                        return GetUtils.isEmail(value!)
                            ? null
                            : "Please Enter an email";
                      },
                      // validator: (value) {
                      //   if (value == null) {
                      //     return "Please Enter Email";
                      //   }
                      //   return null;
                      // }
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: const [
                        SizedBox(width: 6),
                        Text(
                          "Password",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                        obscureText: !showPassword,
                        controller: passwordController,
                        textCapitalization: TextCapitalization.sentences,
                        inputFormatters: [LengthLimitingTextInputFormatter(20)],
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: const Icon(Icons.remove_red_eye),
                                onPressed: () =>
                                    setState(
                                            () => showPassword = !showPassword),
                                color: Constant.primaryColor),
                            focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(
                                    width: 1, color: Constant.primaryColor)),
                            border: const OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Constant.primaryColor)),
                            contentPadding: const EdgeInsets.all(16),
                            hintText: 'Enter Password'),
                        // validator: (value) {
                        //   if (value == null) {
                        //     return "Please Enter Password";
                        //   }
                        //   return null;
                        // }
                      validator: (String? value) {
                        return GetUtils.isLengthGreaterOrEqual(value, 8)
                            ? null
                            : "Please Enter a proper password of 8 or more characters";
                      },),
                    const SizedBox(height: 10),
                    Row(
                      children: const [
                        SizedBox(width: 6),
                        Text(
                          "Password",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                        obscureText: !showCnPassword,
                        controller: confirmPasswordController,
                        textCapitalization: TextCapitalization.sentences,
                        inputFormatters: [LengthLimitingTextInputFormatter(20)],
                        decoration: InputDecoration(
                            focusColor: Constant.primaryColor,
                            hoverColor: Constant.primaryColor,
                            suffixIcon: IconButton(
                                icon: const Icon(Icons.remove_red_eye),
                                onPressed: () =>
                                    setState(
                                            () =>
                                        showCnPassword = !showCnPassword),
                                color: Constant.primaryColor),
                            contentPadding: const EdgeInsets.all(16),
                            hintText: 'Enter Confirm Password',
                            focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(
                                    width: 1, color: Constant.primaryColor)),
                            border: const OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Constant.primaryColor))),
                        validator: (value) {
                          if (value == null) {
                            return "Please Enter Confirm Password";
                          }
                          return null;
                        }),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: ElevatedButton(
                            onPressed: () async {
                              // login(context);
                              if (_formKey.currentState!.validate()) {
                                emailController.text = "user1@gmail.com";
                                passwordController.text = "123456";
                                // await Navigator.pushNamed(
                                //     context, AppRoutes.DashboardScreen);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Constant.primaryColor),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 8),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, AppRoutes.LoginPage);
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                          children: const <TextSpan>[
                            TextSpan(
                              text: "Login",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal),
                            )
                          ],
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
