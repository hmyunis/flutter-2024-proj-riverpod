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
        color: const Color.fromARGB(255, 26, 35, 51),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          const SizedBox(height: 100,),
          Expanded(child: Container(
            decoration: const BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.all(Radius.circular(60))

            ),
            child:  Padding(padding: const EdgeInsets.all(20) ,
            child: Column(children: [
              const SizedBox(height: 60,),
              Container(
              decoration: const BoxDecoration(
                boxShadow: [BoxShadow(color: Color.fromARGB(255, 145, 131, 131), blurRadius: 20, offset: Offset(0, 10))]
              ),
            )],),
            ),
            ))
        ],),
      )
    );
  }
}