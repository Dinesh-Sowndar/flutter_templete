import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_templete/pages/tabs_page.dart';
import 'package:flutter_templete/utils/form_validation.dart';
import 'package:flutter_templete/widgets/toast.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? mobile, name, email, pass, cpass;
  bool showPass1 = true;
  bool showPass2 = true;
  GlobalKey<FormState> _key = GlobalKey();
  bool _validate = false;
  FocusNode node1 = FocusNode();
  FocusNode node2 = FocusNode();
  FocusNode node3 = FocusNode();
  FocusNode node4 = FocusNode();
  FocusNode node5 = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    node1.dispose();
    node2.dispose();
    node3.dispose();
    node4.dispose();
    node5.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Image.asset(
              'assets/images/apple.png',
              height: 150,
            ),
            const SizedBox(
              height: 30,
            ),
            const Text("SIGNUP",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: _key,
              autovalidateMode: _validate ? AutovalidateMode.always : AutovalidateMode.disabled ,
              // autovalidate: _validate,
              child: formUI(),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              //  height:100,
              width: double.infinity,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 14)),
                onPressed: () {
                  register();
                },
                child: const Text('Register'),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an Account?",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    ));
  }

  Widget formUI() {
    return Column(
      children: [
        TextFormField(
          focusNode: node1,
          validator: (value) => validateRequired(value, "Name"),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          onSaved: (data) {
            name = data;
          },
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(top: 4, bottom: 4),
            prefixIcon: Icon(Icons.person_outline),
            labelText: 'Name',
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          inputFormatters: [LengthLimitingTextInputFormatter(10)],
          focusNode: node2,
          textInputAction: TextInputAction.next,
          validator: (value) => validateMobile(value),
          onSaved: (data) {
            mobile = data;
          },
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            prefixText: '+91',
            contentPadding: EdgeInsets.only(top: 4, bottom: 4),
            prefixIcon: Icon(Icons.phone_android),
            labelText: 'Mobile Number',
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          focusNode: node3,
          onSaved: (data) {
            email = data;
          },
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          validator: validateEmail,
          decoration: InputDecoration(
            fillColor: Colors.grey[200],
            filled: true,
            contentPadding: const EdgeInsets.only(top: 2, bottom: 2, left: 10),
            // prefixIcon: Icon(Icons.email_outlined),
            labelText: 'Email',
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.green),
              borderRadius: BorderRadius.circular(5.7),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.yellow),
              borderRadius: BorderRadius.circular(5.7),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          focusNode: node4,
          obscureText: showPass1,
          onSaved: (data) {
            pass = data;
          },
          textInputAction: TextInputAction.next,
          validator: (value) => validateRequired(value, "Password"),
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock),
              labelText: 'Password',
              contentPadding: const EdgeInsets.only(top: 4, bottom: 4),
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      showPass1 = !showPass1;
                    });
                  },
                  icon: Icon(Icons.remove_red_eye,
                      color: showPass1 ? Colors.green : Colors.grey))),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          focusNode: node5,
          onSaved: (data) {
            cpass = data;
          },
          textInputAction: TextInputAction.done,
          validator: (value) => validateRequired(value, "Confirm Password"),
          obscureText: showPass2,
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock),
              labelText: 'Confirm Password',
              contentPadding: const EdgeInsets.only(top: 4, bottom: 4),
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      showPass2 = !showPass2;
                    });
                  },
                  icon: Icon(Icons.remove_red_eye,
                      color: showPass2 ? Colors.green : Colors.grey))),
        )
      ],
    );
  }

  register() {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();

      node1.unfocus();
      node2.unfocus();
      node3.unfocus();
      node4.unfocus();
      node5.unfocus();

      if (pass == cpass) {
        print(name);
        print(mobile);
        print(email);
        print(pass);
        Get.to(TabsPage);
      } else {
        showErrorMessage("Password not Matching");
      }
    } else {
      setState(() {
        _validate = true;
      });
    }
  }
}
