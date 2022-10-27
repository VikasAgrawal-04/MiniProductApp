import 'dart:convert';
import 'package:flutter_auth/Screens/home.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey= GlobalKey<FormState>();
  final textController = TextEditingController();
  final passController = TextEditingController();
  bool _isObscure = true;
  Future<void> login (email, password) async
  {
    //prepare the data as a Map
    Map data = {
      'email': email,
      'password': password
    };
    var response;
    print("object");
    //make a POST request to perform the login
    try{
      response = await http.post(Uri.parse(Uri.encodeFull("https://reqres.in/api/login")),
          body: data,
          encoding: Encoding.getByName("utf-8")
      );
      print("aaa");

      if(response.statusCode == 200) {
        print("object22");

        return response;

      }
      else{
        if(response.statusCode==401){
          showToast("Invalid Password!,Please try again");
        }else if(response.statusCode==404){
          showToast("Invalid Email!,Please try again");
        }else if(response.statusCode==203){
          showToast("Password should be more than 8 and less than 16 character");
        }
        return null;
      }
    }
    catch(e){
      print("jjjj");
      showToast("Error4: $e");
      return null;
    }

  }
  void showToast(String message) {

    //use the scaffold messenger to show the snackbar
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: textController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
              validator: (value) {
                if(value == null || value.isEmpty) return "This field is required";
                return null;
              },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: passController,
              textInputAction: TextInputAction.done,
              obscureText: _isObscure,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Your password",
                suffixIcon: IconButton(
                  icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
              validator: (value) {
                if(value == null || value.isEmpty) return "This field is required";
                return null;
              },
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: () async {
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                login(textController.text,passController.text);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HomeScreen();
                    },
                  ),
                );
              }
            },
            child: Text("Sign Up".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
          const SizedBox(height: defaultPadding),
          Text("OR"),
          Divider(
            color: Colors.black54,
          ),
          // ElevatedButton(
          //   onPressed: () {},
          //   child: Text("Sign Up With Google"),
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: Colors.grey,
          //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))
          //     ),
          // )

          SizedBox(
            height: 50,
            width: 50,
            child: TextButton(
              onPressed: () {},
              child: Image.asset('assets/icons/google.png'),
            ),
          ),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
