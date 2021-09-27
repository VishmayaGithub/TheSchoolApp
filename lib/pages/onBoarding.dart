import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_school_app/helpers/colors.dart';
import 'package:my_school_app/helpers/custom_shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'LoginMenu.dart';
import 'package:my_school_app/components/on_boarding_components.dart';

class OnBoardingPage extends StatefulWidget {

  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  PageController _pageController = PageController(initialPage: 0);

  late int page;
  @override
  void initState() {
    super.initState();
    page = _pageController.initialPage;
  }

  Widget build(BuildContext context) {
    _navigateToLogin() async {
      await CustomSharedPreferences.saveUserOnBoarding(true);
      return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => LoginMenu(),
        ),
        (route) => false,
      );
    }

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Stack(
          children: [
            page < 2
                ? Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                        onPressed: _navigateToLogin,
                        child: Text(
                          'Skip',
                          style: GoogleFonts.poppins(
                            color: texting,
                            fontSize: 15,
                          ),
                        )))
                : Container(),
            PageView(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() => page = value);
              },
              children: [
                OnBoardingItem(
                  imagePath: 'assets/t_and_s.png',
                  text: _pageOneText(),
                ),
                OnBoardingItem(
                  imagePath: 'assets/upload.png',
                  text: _pageTwoText(),
                ),
                OnBoardingItem(
                  imagePath: 'assets/calendar.png',
                  text: _pageThreeText(),
                  hasButton: true,
                ),
              ],
            ),
            Visibility(
              visible: page < 2 ? true : false,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: 3,
                    effect: ExpandingDotsEffect(
                        activeDotColor: texting,
                        dotColor: texting,
                        dotHeight: 12,
                        dotWidth: 12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  RichText _pageOneText() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
              text: 'Share and ',
              style: GoogleFonts.poppins(
                color: texting,
                fontSize: 30,
              )),
          TextSpan(
            text: 'Receive ',
            style: GoogleFonts.poppins(
              color: texting,
              fontSize: 30,
              // fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: 'Homework ',
            style: GoogleFonts.poppins(
              color: texting,
              fontSize: 30,
            ),
          ),
          TextSpan(
            text: 'Instantly',
            style: GoogleFonts.poppins(
              color: texting,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  RichText _pageTwoText() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Upload ',
            style: GoogleFonts.poppins(
              color: texting,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
              text: 'to ',
              style: GoogleFonts.poppins(
                color: texting,
                fontSize: 30,
              )),
          TextSpan(
            text: 'Correct ',
            style: GoogleFonts.poppins(
              color: texting,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: 'your Homework ',
            style: GoogleFonts.poppins(
              color: texting,
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }

  RichText _pageThreeText() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Submit your ',
            style: GoogleFonts.poppins(
              color: texting,
              fontSize: 30,
              // fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
              text: 'homework ',
              style: GoogleFonts.poppins(
                color: texting,
                fontSize: 30,
              )),
          TextSpan(
            text: 'before the ',
            style: GoogleFonts.poppins(
              color: texting,
              fontSize: 30,
              // fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: 'Deadline ',
            style: GoogleFonts.poppins(
              color: texting,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
