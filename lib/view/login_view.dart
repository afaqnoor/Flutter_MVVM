// ignore_for_file: prefer_final_fields, unused_field, avoid_print, unused_local_variable, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:mvvm/resourses/components/round_button.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passFocusNode = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    emailFocusNode.dispose();
    passFocusNode.dispose();
    _obscurePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  maxLength: 70,
                  focusNode: emailFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  onFieldSubmitted: (value) {
                    Utils.fieldFocusChange(
                        context, emailFocusNode, passFocusNode);
                  },
                  decoration: InputDecoration(
                    counterText: '',
                    counterStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(Icons.email),
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15.0),
                    isDense: true,
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter Email',
                    errorStyle: const TextStyle(color: Colors.orange),
                    hintStyle: const TextStyle(
                        fontSize: 13, color: Color.fromARGB(175, 60, 60, 60)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.orange),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.orange,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ValueListenableBuilder(
                    valueListenable: _obscurePassword,
                    builder: (context, value, child) {
                      return TextFormField(
                        maxLength: 50,
                        focusNode: passFocusNode,
                        obscuringCharacter: "*",
                        obscureText: _obscurePassword.value,
                        controller: passController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_open),
                          counterText: '',
                          counterStyle: const TextStyle(color: Colors.white),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(top: 5.0, right: 15),
                            child: InkWell(
                                onTap: () {
                                  _obscurePassword.value =
                                      !_obscurePassword.value;
                                },
                                child: Icon(_obscurePassword.value
                                    ? Icons.visibility_off_sharp
                                    : Icons.visibility_sharp)),
                          ),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15.0),
                          isDense: true,
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Enter Password',
                          errorStyle: const TextStyle(color: Colors.orange),
                          hintStyle: const TextStyle(
                              fontSize: 13,
                              color: Color.fromARGB(175, 60, 60, 60)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.orange),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 2, color: Colors.orange),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      );
                    }),
                SizedBox(
                  height: height * .085,
                ),
                RoundButton(
                  title: 'Login',
                  loading: _authViewModel.loading,
                  onPress: () {
                    if (emailController.text.isEmpty) {
                      Utils.flushBar('please enter email', context);
                    } else if (passController.text.isEmpty) {
                      Utils.flushBar('please enter passwprd', context);
                    } else if (passController.text.length < 6) {
                      Utils.flushBar('please enter 6 digit passwprd', context);
                    } else {
                      Map data = {
                        'email': emailController.text.toString(),
                        'password': passController.text.toString()
                      };
                      _authViewModel.loginApi(data, context);
                      print('apis hit');
                    }
                  },
                ),
                SizedBox(
                  height: height * .02,
                ),
                InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.signUp);
                    },
                    child: const Text.rich(TextSpan(children: [
                      TextSpan(text: "Don't have a account?  "),
                      TextSpan(
                          text: 'SignUp', style: TextStyle(color: Colors.blue))
                    ]))),
              ],
            ),
          ),
        ));
  }
}
