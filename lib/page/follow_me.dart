
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:speech_to_text_example/page/home_page.dart';

class FolloweMe extends StatefulWidget {
  const FolloweMe({Key? key}) : super(key: key);

  @override
  State<FolloweMe> createState() => _FolloweMeState();
}

class _FolloweMeState extends State<FolloweMe> {
  @override
  void initState() {
    Timer(const Duration(seconds: 9, microseconds: 50), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage())); 
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height * .7,
            width: size.width,
            child: Lottie.asset(
              'assets/followme.json',
              height: size.height,
              width: size.width,
              repeat: false,
              // reverse: true,
              animate: true,
            ),
          ),
          SizedBox(
            height: size.height * .3,
            width: size.width,
            child: Column(
              children:  [
                 const Text(
                  "Do You Want Someone Hear You ?",
                  style: TextStyle(
                    fontSize: 26,
                    color: Color.fromARGB(255, 3, 146, 156),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox( height: size.height * .05,),
                const Text(
                  "I'm here Just For You",
                  style: TextStyle(
                    fontSize: 26,
                    color: Color.fromARGB(255, 3, 146, 156),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                                SizedBox( height: size.height * .05,),

                const Text(
                  "Let's Talk, It's Free",
                  style: TextStyle(
                    fontSize: 26,
                    color: Color.fromARGB(255, 3, 146, 156),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
