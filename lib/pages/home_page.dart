import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_templete/controllers/post_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _current = 0;

  var banners = [
    "assets/images/apple.png",
    "assets/images/apple.png",
    "assets/images/apple.png",
    "assets/images/apple.png",
    "assets/images/apple.png",
  ];

  @override
  void initState() {
    super.initState();
    // controller.fetchPosts();
     Get.put(PostController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 22,
                            backgroundImage:
                                AssetImage("assets/images/apple.png"),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Welcome",
                                style: TextStyle(fontSize: 10),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Randy",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Icon(Icons.notifications)
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 0.8,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  height: 160,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
                items: banners
                    .map((img) => Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0)),
                              image: DecorationImage(
                                image: AssetImage(img),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                for (var i = 0; i < banners.length; i++)
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.green),
                          color:
                              _current == i ? Colors.green : Colors.transparent,
                        )),
                  ),
              ]),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text(
                    "Upcoming Games",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              
            GetBuilder<PostController>(
              // init: PostController(),
                  builder: (value) {
                  return value.loading ? Center(child: CircularProgressIndicator(),) : ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: 12,
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          // duration: const Duration(milliseconds: 800),
              
                          child: FlipAnimation(
                            duration: const Duration(milliseconds: 500),
                            delay: const Duration(milliseconds: 200),
              
                            // horizontalOffset: 40,
                            // verticalOffset: -50.0,
                            // duration: Duration(seconds: 2),
              
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                child: Text(value.posts[index].title!),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green[400],
                                  // boxShadow: [
                                  //   BoxShadow(color: Colors.green, spreadRadius: 3),
                                  // ],
                                ),
                                height: 100,
                              ),
                            ),
                          ),
                        );
                      });
                }
              )
           
            ],
          ),
        ));
  }
}
