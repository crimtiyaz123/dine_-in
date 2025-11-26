import 'package:dine_in/core/services/widget_support.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor:Color.fromARGB(255, 221, 224, 225),
      body: Container(
        margin: EdgeInsets.only(top: 30.0),
       
        child: Column(
         
          children: [
            Image.asset(
              'images/onboarding.png'
              ),
              SizedBox(height: 10.0,),
              Text("Welcome to Dine In",
              textAlign: TextAlign.center ,
               style: AppWidget.HeadlineTextFieldStyle()
               ),
               SizedBox(height:10),
               Text(
                "Order food easily from your  restaurant.\nFast, simple and smart dining experience.",
                textAlign: TextAlign.center,
                style: AppWidget.SimplelineTextFieldStyle(),
                ),
                SizedBox(height:30.0),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width/2,
                    decoration: BoxDecoration(color: Color.fromARGB(255, 7, 237, 157),
                    borderRadius: BorderRadius.circular(30)
                    ),
                    
                    child: Center(
                      child: Text(" Get Started", 
                      textAlign: TextAlign.center,
                      style:  TextStyle(fontSize: 20,  fontWeight: FontWeight.bold, color:  Colors.white),
                      ),
                    ),
                  ),
                )
            // Add your onboarding content here
          ],
        ),
      ),
    );
  }
}