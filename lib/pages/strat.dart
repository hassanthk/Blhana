import 'package:blhana_app/pages/modules/background.dart';
import 'package:flutter/material.dart';

class Strat extends StatelessWidget {
  const Strat({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BackGround(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(height: size.height * 0.08),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to',
                    style: TextStyle(fontSize: 28, color: Colors.white),
                  ),
                  SizedBox(width: size.width * 0.01),
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.008),
                    child: Text(
                      'BLHANA',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Edu',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              // SizedBox(height: size.height * 0.06),
              ClipOval(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: size.height * 0.25,
                  height: size.height * 0.25,
                  fit: BoxFit.fill,
                ),
              ),

              // SizedBox(height: size.height * 0.06),
              GestureDetector(
                child: Text(
                  'let\'s get stareted',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                onTap: () => Navigator.pushReplacementNamed(context, 'login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
