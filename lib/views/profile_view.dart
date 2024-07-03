import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/cubits/fetch_user_data_cubit/fetch_user_data_cubit.dart';
import 'package:insta_app/helper/profile_grid_view.dart';
import 'package:insta_app/helper/profile_helper.dart';
import 'package:insta_app/models/user_model.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});
  static String profileId = 'Search page';

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late UserModel user;
  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    user = BlocProvider.of<FetchUserDataCubit>(context).userModel;
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
                    backgroundImage: (user.profileImageURL != null)
                        ? NetworkImage(user.profileImageURL!)
                        : null,
                    radius: 40,
                  ),
                  SizedBox(
                    height: 0.01 * hight,
                  ),
                  Text(
                    user.username,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
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
    );
  }
}
