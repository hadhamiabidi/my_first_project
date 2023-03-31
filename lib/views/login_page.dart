
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pfe/controllers/login_controller.dart';
import 'package:pfe/views/signup_page.dart';

class LoginPage extends StatelessWidget {
  final _controller = LoginController();
  LoginPage ({ Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const  Color(0xff154C79),
      body: SafeArea(
        child: SingleChildScrollView(child: Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(alignment: Alignment.center,
              child: Image.asset('assets/logo.jpg',
              fit: BoxFit.cover,
              height: 230,
              width: 250,)
            ),
            const SizedBox(
              height: 40,
            ),

            const Text(
                'Username',
                style: TextStyle(fontSize: 20,
                    color: Colors.black)),
            const SizedBox(
              height: 25,
            ),
            const TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                hintText: 'Enter a username'),
              ),
            const SizedBox(
              height: 40,
            ),
            const Text(
                'Password',
                style: TextStyle(fontSize: 20,
                    color: Colors.black)),
            const SizedBox(
              height: 25,
            ),
            const TextField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  hintText: 'Enter a password'),
            ),
            const SizedBox(
              height: 55,
            ),
            Center(
              child: InkWell(
                onTap: (){
                  _controller.goToDashboard();
                },
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white
                  ),
                  height: 45,
                  width: 90,
                  child: const Center(
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 20, color: Color(0xff154C79)),

                    ),
                  ),

                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
               const Text(
                  'Dont have an account?',
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                InkWell(
                  onTap: (){
                    _controller.goToRegister();
                  },
                  child: const Text(
                    'Signup',
                    style: TextStyle(fontSize: 15, color: Colors.purple),


                  ),
                ),
              ],
            )



           
            



          ],
        ),),),
      ),
    );
  }
}