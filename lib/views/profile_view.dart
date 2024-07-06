import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/helper/profile_grid_view.dart';
import 'package:insta_app/helper/profile_helper.dart';
import 'package:insta_app/models/user_model.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key, this.userModel});
  static String profileId = 'Search page';
  final UserModel? userModel;
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBlack,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: CustomScrollView(
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
                        CircleAvatar(
                          backgroundImage: (widget.userModel!.profileImageURL !=
                                  null)
                              ? NetworkImage(widget.userModel!.profileImageURL!)
                              : null,
                          radius: 40,
                        ),
                        SizedBox(
                          height: 0.01 * hight,
                        ),
                        Text(
                          widget.userModel!.username,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
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
                child: SizedBox(
                  height: 0.062 * hight,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: kPink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Edit profile',
                      style: TextStyle(
                        fontSize: 20,
                        color: kWhite,
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 0.02 * hight,
                ),
              ),
              const ProfileGridView()
            ],
          ),
        ),
      ),
    );
  }
}
