import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CharacterDetail extends StatelessWidget {
  late String species;
  late String age;
  late String planet;
  late String profession;
  late String status;
  // late String firstApperance;
  late String urlToImage;
  late String relatives;
  late String voicedBy;
  late String name;
  CharacterDetail({
    required this.species,
    required this.age,
    required this.planet,
    required this.profession,
    required this.status,
    // required this.firstApperance,
    required this.urlToImage,
    required this.relatives,
    required this.voicedBy,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 200,
              child: Image(image: NetworkImage(urlToImage), fit: BoxFit.fill),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
              child: Text(
                name,
                style: GoogleFonts.mcLaren(
                  fontSize: 25,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
              child: Text(
                "Status : $status",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
              child: Text(
                "Age : $age",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
              child: Text(
                "Species : $species",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
              child: Text(
                "Planet : $planet",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
              child: Text(
                "Profession : $profession",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
            //   child: Text(
            //     "First Appearance : $firstApperance",
            //     style: TextStyle(
            //       fontSize: 15,
            //     ),
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
              child: Text(
                "Relatives : $relatives",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
              child: Text(
                "Voiced by : $voicedBy",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
