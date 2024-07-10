import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/cubits/fetch_all_users_cubit/fetch_all_users_cubit.dart';
import 'package:insta_app/cubits/fetch_all_users_cubit/fetch_all_users_states.dart';
import 'package:insta_app/helper/person_in_search.dart';
import 'package:insta_app/models/user_model.dart';
import 'package:insta_app/services/fetch_and_push_searched_people_service.dart';
import 'package:insta_app/views/profile_view.dart';
import 'package:insta_app/widgets/custom_search_text_field.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key, this.currentUser});
  final UserModel? currentUser;
  static String searchId = 'Search page';

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  String input = '';
  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: Column(
        children: [
          SizedBox(
            height: hight * 0.01,
          ),
          CustomSearchTextField(
            onSubmitted: (value) {
              input = value;
            },
          ),
          SizedBox(
            height: hight * 0.01,
          ),
          (widget.currentUser!.serachedPeople!.isNotEmpty)
              ? Expanded(
                  child: ListView.builder(
                    // shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.currentUser!.serachedPeople!.length,
                    itemBuilder: (BuildContext context, int index) {
                      List searchedPeopleBefore =
                          widget.currentUser!.serachedPeople!;
                      // ++++++++++++++++++++++++
                      // fetch searched user data
                      return FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection(kUsers)
                              .doc(searchedPeopleBefore[index]['uid'])
                              .get(),
                          builder: (context, snapshot2) {
                            return InkWell(
                              onTap: () {
                                Map<String, dynamic> currentUserMap,
                                    searchedUserMap;
                                searchedUserMap = snapshot2.data!.data()
                                    as Map<String, dynamic>;

                                UserModel searchedUser =
                                    UserModel.fromJson(searchedUserMap);

                                Get.to(
                                  SafeArea(
                                    child: (ProfileView(
                                      currentUser: widget.currentUser,
                                      userModel: searchedUser,
                                    )),
                                  ),
                                );
                              },
                              child: PersonInSearch(
                                  username: searchedPeopleBefore[index]
                                      ['username'],
                                  imageURL: searchedPeopleBefore[index]
                                      ['profileImageURL']),
                            );
                          });
                    },
                  ),
                )
              : (widget.currentUser!.serachedPeople!.isEmpty)
                  ? Padding(
                      padding: EdgeInsets.only(top: hight * 0.38),
                      child: const Center(
                        child: Text(
                          'No searching yet',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    )
                  : const Text('There somthing wrong'),
        ],
      ),
    );
  }
}
