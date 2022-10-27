import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';
import '../login_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);


  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final textController = TextEditingController();
  final passController = TextEditingController();
  bool _isObscure = true;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textController.dispose();
    super.dispose();
  }
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
              cursorColor: kPrimaryColor,
              obscureText: _isObscure,
              decoration: InputDecoration(
                hintText: "Your password",
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility: Icons.visibility_off
                  ),
                  onPressed: (){
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
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
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
              child: Text(
                "Login".toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpScreen();
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
