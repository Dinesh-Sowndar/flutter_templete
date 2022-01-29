import 'package:flutter/material.dart';
import 'package:flutter_templete/pages/register_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Intro extends StatefulWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  final controller = PageController();
  final storage = GetStorage();
  int pageCount = 0;
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 350,
            child: PageView(
              controller: controller,
              onPageChanged: (page) {
                setState(() {
                  pageCount = page;
                });
              },
              children: <Widget>[
                pageWidget(
                    "assets/images/app_icon/flutter.png",
                    "Intro screen 1",
                    "This is the content and design for app intro screen 1"),
                pageWidget(
                    "assets/images/app_icon/flutter.png",
                    "Intro screen 2",
                    "This is the content and design for app intro screen 2"),
                pageWidget(
                    "assets/images/app_icon/flutter.png",
                    "Intro screen 3",
                    "This is the content and design for app intro screen 3"),
              ],
            ),
          ),
          SmoothPageIndicator(
            controller: controller, // PageController
            count: 3,
            effect: const ExpandingDotsEffect(
              activeDotColor: Colors.green,
              dotWidth: 8.0,
              dotHeight: 8.0,
            ), // your preferred effect
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 44,
          width: MediaQuery.of(context).size.width / 2,
          child: RaisedButton(
            color: Colors.green,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            onPressed: () {
              if (pageCount == 2) {
                box.write('intro', true);
                Get.off(const RegisterPage());
              } else {
                controller.nextPage(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.ease);
              }
            },
            child: Text(
              pageCount == 2 ? "Get Started" : "Next",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget pageWidget(img, title, subTitle) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          img,
          height: 150,
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            subTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600]),
          ),
        ),
      ],
    );
  }
}
