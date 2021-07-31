import 'package:flutter/material.dart';
import 'package:futurama_cartoon/res/custom_colors.dart';
import 'package:futurama_cartoon/utils/authentication.dart';
import 'package:futurama_cartoon/widgets/google_sign_in_button.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Futurama Cartoon',
                      style: GoogleFonts.dancingScript(
                        color: CustomColors.firebaseYellow,
                        fontSize: 40,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        child: Image(
                          image: AssetImage('assets/futurama.jpg'),
                          fit: BoxFit.fill,
                        )),
                  ],
                ),
              ),
              FutureBuilder(
                future: Authentication.initializeFirebase(context: context),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error initializing Firebase');
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return GoogleSignInButton();
                  }
                  return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      CustomColors.firebaseOrange,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
