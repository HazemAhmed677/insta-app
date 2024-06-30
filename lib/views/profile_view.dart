import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/helper/profile_grid_view.dart';
import 'package:insta_app/helper/profile_helper.dart';
import 'package:insta_app/widgets/custom_ink_well.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  static String profileId = 'Search page';
  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return CustomScrollView(
      physics: const BouncingScrollPhysics(
          decelerationRate: ScrollDecelerationRate.fast),
      slivers: [
        SliverToBoxAdapter(
            child: SizedBox(
          height: 0.045 * hight,
        )),
        SliverToBoxAdapter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage(kImage),
                    radius: 40,
                  ),
                  SizedBox(
                    height: 0.01 * hight,
                  ),
                  const Text(
                    'Name',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const ProfileHelper(
                number: '5',
                text: 'posts',
              ),
              const ProfileHelper(
                number: '11',
                text: 'Followers',
              ),
              const ProfileHelper(
                number: '26',
                text: 'Following',
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 0.02 * hight,
          ),
        ),
        SliverToBoxAdapter(
          child: CustomInkWell(
            color: kPink,
            text: 'Edit profile',
            onTap: () {},
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 0.02 * hight,
          ),
        ),
        ProfileGridView()
      ],
    );
  }
}
