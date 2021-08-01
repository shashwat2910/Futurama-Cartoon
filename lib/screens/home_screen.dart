import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:futurama_cartoon/api/data.dart';
import 'package:futurama_cartoon/api/model.dart';
import 'package:futurama_cartoon/res/custom_colors.dart';
import 'package:futurama_cartoon/utils/authentication.dart';
import 'package:futurama_cartoon/widgets/character-detail.dart';

import 'login_screen.dart';

import 'package:google_fonts/google_fonts.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  late User _user;
  bool _isSigningOut = false;

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SignInScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  bool isloading = false;
  List<Article> articles = [];
  Character character = Character();
  getandSetData() async {
    await character.getChracterDetails();
    articles = character.articles;
    setState(() {
      isloading = true;
    });
  }

  @override
  void initState() {
    _user = widget._user;
    getandSetData();
    super.initState();
  }

  late PageController pageController;
  Duration pageTurnDuration = Duration(milliseconds: 500);
  Curve pageTurnCurve = Curves.ease;
  void goForward() {
    pageController.nextPage(duration: pageTurnDuration, curve: pageTurnCurve);
  }

  void goBack() {
    pageController.previousPage(
        duration: pageTurnDuration, curve: pageTurnCurve);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(
          "Futurama Cartoon",
          style: GoogleFonts.mcLaren(),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _user.photoURL != null
                ? CircleAvatar(
                    radius: 25,
                    child: ClipOval(
                      child: Material(
                        color: CustomColors.firebaseGrey.withOpacity(0.3),
                        child: Image.network(
                          _user.photoURL!,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  )
                : ClipOval(
                    child: Material(
                      color: CustomColors.firebaseGrey.withOpacity(0.3),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Icon(
                          Icons.person,
                          size: 25,
                          color: CustomColors.firebaseGrey,
                        ),
                      ),
                    ),
                  ),
            SizedBox(height: 20),
            SizedBox(height: 20),
            _isSigningOut
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.redAccent,
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        _isSigningOut = true;
                      });
                      await Authentication.signOut(context: context);
                      setState(() {
                        _isSigningOut = false;
                      });
                      Navigator.of(context)
                          .pushReplacement(_routeToSignInScreen());
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        'Sign Out',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: GestureDetector(
          onHorizontalDragEnd: (dragEndDetails) {
            if (dragEndDetails.primaryVelocity! < 0) {
              // Page forwards
              print('Move page forwards');
              goForward();
            } else if (dragEndDetails.primaryVelocity! > 0) {
              // Page backwards
              print('Move page backwards');
              goBack();
            }
          },
          child: isloading
              ? PageView.builder(
                  physics: ClampingScrollPhysics(),
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    return CharacterDetail(
                      species: articles[index].species,
                      age: articles[index].age,
                      planet: articles[index].planet,
                      profession: articles[index].profession,
                      status: articles[index].status,
                      // firstApperance: articles[index].firstApperance,
                      urlToImage: articles[index].urlToImage,
                      relatives: articles[index].relatives,
                      voicedBy: articles[index].voicedBy,
                      name: articles[index].name,
                    );
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
