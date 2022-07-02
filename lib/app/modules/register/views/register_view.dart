import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/modules/login/views/widgets/divider_or.dart';
import 'package:hallo_doctor_client/app/modules/login/views/widgets/label_button.dart';
import 'package:hallo_doctor_client/app/modules/login/views/widgets/title_app.dart';
import 'package:hallo_doctor_client/app/modules/widgets/submit_button.dart';
import 'package:hallo_doctor_client/app/utils/helpers/validation.dart';

import '../../../utils/MyLocaleController.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
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

    final height = MediaQuery.of(context).size.height;
    final node = FocusScope.of(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: height,
          child: Stack(
            children: <Widget>[
      
              Positioned(
                top: -MediaQuery.of(context).size.height * .15,
                right: -MediaQuery.of(context).size.width * .4,
                child: Container(),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: controller.formkey,
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
                        // SizedBox(height: height * .2),
                        TitleApp(),
                        SizedBox(
                          height: 50,
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () {
                            node.nextFocus();
                          },
                          validator: ((value) {
                            if (value!.length < 6) {
                              return 'Name must be  6 or more characters'.tr;
                            } else {
                              return null;
                            }
                          }),
                          onSaved: (username) {
                            controller.username = username!;
                          },
                          decoration: InputDecoration(
                              hintText: 'Username',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  )),
                              fillColor: Colors.grey[200],
                              filled: true),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () {
                            node.nextFocus();
                          },
                          validator: ((value) {
                            return Validation().validateEmail(value);
                          }),
                          onSaved: (email) {
                            controller.email = email!;
                          },
                          decoration: InputDecoration(
                              hintText: 'Email',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  )),
                              fillColor: Colors.grey[200],
                              filled: true),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GetBuilder<RegisterController>(
                            builder: (controller) => TextFormField(
                                  obscureText: controller.passwordVisible,
                                  textInputAction: TextInputAction.done,
                                  onEditingComplete: () {
                                    node.nextFocus();
                                  },
                                  validator: ((value) {
                                    if (value!.length < 3) {
                                      return 'Password must be more thand four characters'
                                          .tr;
                                    } else {
                                      return null;
                                    }
                                  }),
                                  onSaved: (password) {
                                    controller.password = password!;
                                  },
                                  decoration: InputDecoration(
                                      hintText: 'Password',
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                            controller.passwordVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Colors.blue[300]),
                                        onPressed: () {
                                          controller.passwordIconVisibility();
                                        },
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          )),
                                      fillColor: Colors.grey[200],
                                      filled: true),
                                )),
                        SizedBox(
                          height: 20,
                        ),
                        submitButton(
                            onTap: () {
                              controller.signUpUser();
                            },
                            text: 'Register Now'.tr),
                        SizedBox(height: height * .01),
                        DividerOr(),
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
                        LabelButton(
                          onTap: () {},
                          title: 'Already have an account ?'.tr,
                          subTitle: 'Login'.tr,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(top: 40, left: 0, child: BackButton()),
            ],
          ),
        ),
      ),
    );
  }
}
