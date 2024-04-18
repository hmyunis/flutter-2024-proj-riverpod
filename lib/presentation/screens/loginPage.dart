import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp( const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginPage(),
    ));
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: const Color.fromARGB(255, 26, 35, 51),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          const SizedBox(height: 100,),
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Center(
                
                  child: Container(
                  width: 300.0,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 52, 51, 56),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                
                  ),
                  child:  Padding(padding: const EdgeInsets.all(20) ,
                  child: Column(children: [
                    const Row(children: [Text("Login",
                    style: TextStyle(fontSize: 30, color: Color.fromARGB(255, 192, 182, 182), fontWeight: FontWeight.bold,)),],),
                    const SizedBox(height: 20,),
                    Column(children: [Container(
                      height: 50,
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromARGB(255, 211, 202, 202))),
                      color: Color.fromARGB(255, 114, 113, 109),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                      
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: "User Name",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          
                        ),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    Container(
                      height: 50,
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromARGB(255, 211, 202, 202))),
                      color: Color.fromARGB(255, 114, 113, 109),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                      
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                                    
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                     Center(
                                    
                      child:Container(
                        width: 200,
                        child: ElevatedButton(onPressed: ()=>{},
                        
                        style: ElevatedButton.styleFrom(
                          backgroundColor:const Color.fromARGB(255, 40, 30, 82),
                          shape: const StadiumBorder(),
                        
                        ),
                        child: const Text("Submit",
                        style: TextStyle(color: Colors.white),)),
                      ),
                    
                      ),
                    ],),
                  const SizedBox(height: 20,),
                   const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Register",
                      style: TextStyle(color:Color.fromARGB(255, 192, 182, 182), fontWeight: FontWeight.w100),),
                       Text("Forget Password", style: TextStyle(color: Color.fromARGB(255, 192, 182, 182), fontWeight: FontWeight.w100),),
                    ],
                  )
                  ],),
                  ),
                  ),),
              ),
              
              Center(

                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 10, 250, 0),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(90, 132, 0, 255),
                      shape: BoxShape.circle
                    )),
                ),
              ),
              Center(

                child: Container(
                  padding: const EdgeInsets.fromLTRB(260, 330, 0, 0),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(90, 132, 0, 255),
                      shape: BoxShape.circle
                    )),
                ),
              )
                
          ]),
          const Expanded(
            child: SizedBox(height: 10,))
        ],),
      )
    );
  }
}
