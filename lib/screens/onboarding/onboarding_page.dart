import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walleto/data/model/onboarding.dart';
import 'package:walleto/main.dart';
import 'package:walleto/screens/main_menu_page.dart';
import 'package:walleto/screens/onboarding/size_config.dart';
import 'package:walleto/shared/theme.dart';

class OnBoardingPage extends StatefulWidget {
  static const routeName = '/on_boarding_page';
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int currentPage = 0;
  PageController _pageController = PageController(initialPage: 0);

  AnimatedContainer dotIndicator(index) {
    return AnimatedContainer(
      margin: EdgeInsets.only(right: 5),
      duration: Duration(milliseconds: 400),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
          color: currentPage == index ? kBlackPrimary : kWhiteColor,
          shape: BoxShape.circle),
    );
  }

  Future setSeenonboard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    seenOnboard = await prefs.setBool('seenOnboard', true);
  }

  @override
  void initState(){
    super.initState();
    setSeenonboard();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeV = SizeConfig.blockSizeV!;

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 9,
                child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                      });
                    },
                    itemCount: onboardingContents.length,
                    itemBuilder: (context, index) => Column(
                          children: [
                            SizedBox(height: sizeV * 5),
                            Text(
                              onboardingContents[index].title,
                              style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 19),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: sizeV * 5),
                            Container(
                                height: sizeV * 50,
                                child: Image.asset(
                                  onboardingContents[index].image,
                                  fit: BoxFit.contain,
                                )),
                          ],
                        )),
              ),
              Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      currentPage == onboardingContents.length -1
                          ? MyTextButton(
                        buttonName: 'AYO KITA MULAI!',
                        bgColor: kBlueColor,
                        onPressed: (){
                          Navigator.pushReplacementNamed(
                              context, MainMenuPage.routeName);
                        },
                      )
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          OnBoardNavBtn(
                              name: 'SKIP',
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>
                                  MainMenuPage()));
                              }),
                          Row(
                              children: List.generate(onboardingContents.length,
                                  (index) => dotIndicator(index))),
                          OnBoardNavBtn(
                              name: 'NEXT',
                              onPressed: (){
                                _pageController.nextPage(
                                    duration: Duration(milliseconds: 400),
                                    curve: Curves.easeInOut);
                              })
                        ],
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }
}

class MyTextButton extends StatelessWidget{
  const MyTextButton ({ Key? key,
    required this.buttonName,
    required this.onPressed,
    required this.bgColor,}) : super (key:key);

  final String buttonName;
  final VoidCallback onPressed;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: SizeConfig.blockSizeH! * 15.5,
        width: SizeConfig.blockSizeH! * 100,
        child: TextButton(
          onPressed: onPressed,
          child: Text(
              buttonName,
              style : whiteTextStyle.copyWith(
                  fontSize: 16, fontWeight: FontWeight.bold)),
          style: TextButton.styleFrom(backgroundColor: bgColor),
        ),
      ),
    );
  }
}


class OnBoardNavBtn extends StatelessWidget {
  const OnBoardNavBtn({
    Key? key,
    required this.name,
    required this.onPressed,
  }) : super(key: key);
  final String name;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(10),
        splashColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(name,
              style: blackTextStyle.copyWith(
                  fontSize: 13, fontWeight: FontWeight.bold))),
        );
  }
}
