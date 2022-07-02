// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/modules/login/views/widgets/divider_or.dart';
import 'package:hallo_doctor_client/app/modules/login/views/widgets/label_button.dart';
import 'package:hallo_doctor_client/app/modules/login/views/widgets/title_app.dart';
import 'package:hallo_doctor_client/app/modules/widgets/submit_button.dart';
import '../../../utils/MyLocaleController.dart';
import '../controllers/login_controller.dart';
// Get.find<MyLocaleController>().changeLang('es');

class LoginView extends GetView<LoginController> {
  final List locale = [
    {'name': 'ENGLISH', 'locale': 'en'},
    {'name': 'Arabic', 'locale': 'ar'},
    {'name': 'French', 'locale': 'fr'},
    {'name': 'Spanish', 'locale': 'es'},
    {'name': 'Default', 'locale': 'def'},
  ];
  ChangeLanguageAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {},
    );
    AlertDialog alert = AlertDialog(
      title: const Text('Choose Your Language'),
      content: Container(
          width: double.maxFinite,
          child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Text(locale[index]['name']),
                    onTap: () {
                      Get.find<MyLocaleController>()
                          .changeLang(locale[index]['locale']);
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.blue,
                );
              },
              itemCount: locale.length)),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(MyLocaleController());
    var height = Get.height;
    final node = FocusScope.of(context);
    return Scaffold(
        appBar: null,
        body: SafeArea(
          child: Container(
            height: height,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // ignore: deprecated_member_use
                            RaisedButton(
                              elevation: 0,
                              onPressed: () {
                                ChangeLanguageAlertDialog(context);
                              },
                              color: Color(0xFFF9F9F9),
                              textColor: Colors.blue,
                              child: Row(
                                children: <Widget>[
                                  Text('Change language'.tr),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(Icons.language)
                                ],
                              ),
                            ), // TextButton.icon(
                          ],
                        ),
                        SizedBox(height: height * .1),
                        TitleApp(),
                        SizedBox(height: 50),
                        Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: controller.loginFormKey,
                          child: Column(
                            children: [
                              TextFormField(
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () {
                                  node.nextFocus();
                                },
                                validator: ((value) {
                                  if (value!.length < 3) {
                                    return 'Name must be more than two characters'
                                        .tr;
                                  } else {
                                    return null;
                                  }
                                }),
                                onSaved: (username) {
                                  controller.username = username ?? '';
                                },
                                decoration: InputDecoration(
                                    hintText: 'Email',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        )),
                                    fillColor: Colors.grey[200],
                                    filled: true),
                              ),
                              SizedBox(height: 30),
                              GetBuilder<LoginController>(
                                builder: (controller) => TextFormField(
                                  obscureText: controller.passwordVisible,
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                      hintText: 'Password',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          )),
                                      fillColor: Colors.grey[200],
                                      filled: true,
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                            controller.passwordVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Colors.blue[300]),
                                        onPressed: () {
                                          controller.passwordIconVisibility();
                                        },
                                      )),
                                  validator: ((value) {
                                    if (value!.isEmpty) {
                                      return 'Password cannot be empty'.tr;
                                    } else {
                                      return null;
                                    }
                                  }),
                                  onSaved: (password) {
                                    controller.password = password ?? '';
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed('/forgot-password');
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Forgot Password ?'.tr,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        SizedBox(height: height * .020),
                        submitButton(
                            onTap: () {
                              controller.login();
                            },
                            text: 'Login'.tr),
                        SizedBox(
                          height: 10,
                        ),
                        DividerOr(),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: Get.width,
                          height: 50,
                          child: SignInButton(
                            Buttons.Google,
                            onPressed: () {
                              controller.loginGoogle();
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        LabelButton(
                          onTap: () {
                            // ChangeLanguageAlertDialog(context);

                            Get.toNamed('/register');
                            // Get.find<MyLocaleController>().changeLang('es');
                          },
                          title: 'Don\'t have an account, '.tr,
                          subTitle: 'Register'.tr,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
