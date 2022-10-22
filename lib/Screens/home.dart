import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Products/product_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String,dynamic> dict = {};
  List<String> itemList=[];
  @override
  void initState() {
    super.initState();
    getList();
  }
  Future<void> getList() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
       itemList = prefs.getStringList("items") ?? [];
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50,left: 15,right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap:(){

                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                      },

                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(color: Colors.black12,borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Icon(Icons.arrow_back_ios),
                        ),
                      ),
                    ),

                    Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(color: Colors.greenAccent,borderRadius: BorderRadius.circular(10)),
                        child: Center(child: Icon(Icons.search))
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15,top: 10,bottom: 10),
                child: Row(
                  children: [
                    Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text('Hi-Fi Shop & Service',
                            style: TextStyle(color: Colors.black,
                                fontSize: 20,fontWeight: FontWeight.bold),),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 0,bottom: 5,top: 10),
                          child: Text('Audio shop on Rustveli Ave 57.',
                            style: TextStyle(color: Colors.grey,fontSize: 12),),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 0,bottom: 10),
                          child: Text('This Shop Offers both product. ',
                            style: TextStyle(color:Colors.grey,fontSize: 12),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text('Product',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                        Text(' 41',style: TextStyle(color: Colors.grey,fontSize: 15
                        ),),
                      ],
                    ),
                    Text('Show all',style: TextStyle(color: Colors.blue,fontSize: 10,fontWeight: FontWeight.bold),)

                  ],

                ),
              ),
              ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: itemList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final map = jsonDecode(itemList[index]);

                    return listTile(
                      name:map['productName'],
                      price: map['productPrice']
                    );
                  }),
            ],
          ),
        ],

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ProductScreen();
              },
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),

    );
  }
  Widget listTile({required String name, required String price}){
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 130,
                width: 170,
                decoration: BoxDecoration(color: Colors.black12,borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 10,right: 8),
                      child: Icon(Icons.delete_outline),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Center(
                          child: SvgPicture.asset('assets/icons/headphones.svg',height: 50,width: 50,)
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5,top: 8,),
                child: Text(name,style: TextStyle(fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5,top: 5),
                child: Text(price,style: TextStyle(color: Colors.grey)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
