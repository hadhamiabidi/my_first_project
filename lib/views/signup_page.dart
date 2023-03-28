import 'package:flutter/material.dart';
class Signup extends StatelessWidget {
  const Signup({Key? key, required authType}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor:  const Color(0xff154C79),
      body: SafeArea(
        child: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
        child: Column(children: [
          Container(margin: const EdgeInsets.only(top: 30)),
            alignment: Alignment.center,
          child: const Text(
               'Signup',
            style: TextStyle(fontSize: 25, color: Colors.white),
    ),
    const SizedBox(
         height: 30,
    TextFormField(
    decoration: const InputDecoration(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(),
    hintText: 'Enter your username'),

    const SizedBox(
    height: 20,
    TextFormField(
    decoration: const InputDecoration(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(),
    hintText: 'Enter your e-mail'),

    const SizedBox(
    height: 20,
    TextFormField(
    decoration: const InputDecoration(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(),
    hintText: 'Enter your contact'),

    const SizedBox(
    height: 20,
    TextFormField(
    decoration: const InputDecoration(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(),
    hintText: 'Enter your password'),

    const SizedBox(
    height: 20,
    TextFormField(
    decoration: const InputDecoration(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(),
    hintText: 'confirm your password'),





    ],)



    );
  },

}