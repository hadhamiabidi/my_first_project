
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pfe/views/signup_page.dart';

class Login extends StatelessWidget {
  const Login ({ Key? key, required authType }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff154C79),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20)))
                  child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                       Container(alignment: Alignment.center,
                        child: Image.asset(
                            'assets/login1.png',
                             fit: BoxFit.cover,
                             height: 230,
                             width: 180,
                     )
                   ),
                   const SizedBox(
                       height: 40,

      )
      const Text('Username',
        style: TextStyle(fontSize: 20, color: Colors.white)),
      const TextField(
        decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(),
        hintText: 'Enter a username'


        ),

      ),
      const Text('Password',
      style: TextStyle(fontSize: 20, color: Colors.white)),
    const TextField(
    decoration: InputDecoration(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(),
    hintText: 'Enter a password'



    ),


      )
      const SizedBox(
    height: 55,
    ),
    Container(decoration: const BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    color: Colors.white
    ),
    height: 45,
    width: 90,
    child: const Center(

    )
      child:  Text(
          'Login',
      style: TextStyle(fontSize: 20, color: Colors.purple),


    )
      ),
    const SizedBox(height: 15,),
    Row(mainAxisAlignment: MainAxisAlignment.center,
    children: const [
       Text(
    'Dont have an account?',
    style: TextStyle(fontSize: 15, color: Colors.white)),
    InkWell(
      onTap: () {
        Get.to(const Signup());
    },
    )
    child: Text(
    'Signup',
    style: TextStyle(fontSize: 15, color: Colors.purple)),
    ],)



    const SizedBox(
    height: 55,
    ),
    Container(decoration: const BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    color: Colors.white
    ),
    height: 45,
    width: 90,
    child: const Center(

    )
    child:  Text(
    'Signup',
    style: TextStyle(fontSize: 20, color: Colors.purple),


    )
    ),
    const SizedBox(height: 15,),
    Row(mainAxisAlignment: MainAxisAlignment.center,
    children: const [
    Text(
    'Dont have an account?',
    style: TextStyle(fontSize: 15, color: Colors.white)),
    InkWell(
    onTap: () {
    Get.to(const Signup());
    },
    )
    child: Text(
    'Signup',
    style: TextStyle(fontSize: 15, color: Colors.purple))

    );
  }
}


