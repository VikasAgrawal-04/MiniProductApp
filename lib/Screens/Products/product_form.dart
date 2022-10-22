import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';


class ProductForm extends StatefulWidget {
  const ProductForm({Key? key}) : super(key: key);

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController productName = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: productName,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: InputDecoration(
              hintText: "Product Name",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.add_box),
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
              controller: productPrice,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Price",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.currency_rupee),
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
              if(_formKey.currentState!.validate()){
                final prefs = await SharedPreferences.getInstance();
                final value = {
                  'productName': productName.text,
                  'productPrice': productPrice.text
                };
                 List<String> itemList = prefs.getStringList("items") ?? [];
                itemList.add(jsonEncode(value));
                await prefs.setStringList('items', itemList);
              }
              Navigator.pushReplacement(
                  context,MaterialPageRoute(
                builder: (context) {
                  return HomeScreen();
                },
              ),);
            },
            child: Text("Add Product".toUpperCase()),
          ),
        ],
      ),
    );
  }
}
