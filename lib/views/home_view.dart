import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/widgets/bottom_navigation_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static String homeViewId = 'Home view page';
  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBlack,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Insta',
                style: TextStyle(fontFamily: 'PlaywriteMX', fontSize: 40),
              ),
              SizedBox(
                height: hight * 0.20,
              ),
              const CircleAvatar(
                backgroundImage: AssetImage(kImage),
                maxRadius: 34,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 10, itemBuilder: (context, index) {}),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(),
      ),
    );
  }
}
