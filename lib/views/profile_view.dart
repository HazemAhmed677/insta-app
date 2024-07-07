import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:insta_app/constants.dart';
import 'package:insta_app/cubits/follow_and_unfollow_cubit/follow_and_unfollow_cubit.dart';
import 'package:insta_app/cubits/follow_and_unfollow_cubit/follow_and_unfollow_states.dart';

import 'package:insta_app/helper/profile_grid_view.dart';
import 'package:insta_app/helper/profile_helper.dart';
import 'package:insta_app/models/user_model.dart';
import 'package:insta_app/services/fetch_user_posts_fo_profile.dart';

class ProfileView extends StatefulWidget {
  ProfileView({
    super.key,
    this.userModel,
    this.bar,
    this.onPressed,
    this.flag,
  });
  static String profileId = 'Search page';
  final UserModel? userModel;
  final String? bar;
  final void Function()? onPressed;
  bool? flag;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: BlocBuilder<FollowAndUnfollowCubit, FollowAndUnfollowStates>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: kBlack,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  future: FetchUserPostsForProfile()
                      .fetchUserPostsFoProfile(uid: widget.userModel!.uid),
                  builder: (context, snapshot) {
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
                                  CircleAvatar(
                                    backgroundImage: (widget
                                                .userModel!.profileImageURL !=
                                            null)
                                        ? CachedNetworkImageProvider(
                                            widget.userModel!.profileImageURL!)
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
                              ProfileHelper(
                                number: snapshot.data?.size.toString() ?? '0',
                                text: 'posts',
                              ),
                              ProfileHelper(
                                number: widget.userModel!.followers!.length
                                    .toString(),
                                text: 'Followers',
                              ),
                              ProfileHelper(
                                number: widget.userModel!.following!.length
                                    .toString(),
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
                            height: 0.055 * hight,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    (FirebaseAuth.instance.currentUser!.uid ==
                                            widget.userModel!.uid)
                                        ? Colors.blue
                                        : (widget.userModel!.followers!
                                                .contains(FirebaseAuth
                                                    .instance.currentUser!.uid))
                                            ? Colors.grey
                                            : kPink,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: widget.onPressed,
                              child: Text(
                                (FirebaseAuth.instance.currentUser!.uid ==
                                        widget.userModel!.uid)
                                    ? 'Edit profile'
                                    : (widget.userModel!.followers!.contains(
                                            FirebaseAuth
                                                .instance.currentUser!.uid))
                                        ? 'Unfollow'
                                        : 'Follow',
                                style: const TextStyle(
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
                        (snapshot.connectionState == ConnectionState.waiting)
                            ? SliverToBoxAdapter(
                                child: Padding(
                                  padding: EdgeInsets.only(top: hight * 0.28),
                                  child: const Center(
                                    child: Text(
                                      'Loading',
                                      style: TextStyle(
                                        fontFamily: 'PlaywriteMX',
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : (snapshot.hasData)
                                ? ProfileGridView(
                                    posts: snapshot.data,
                                  )
                                : const SliverToBoxAdapter(
                                    child: SizedBox(),
                                  ),
                      ],
                    );
                  }),
            ),
          );
        },
      ),
    );
  }
}
