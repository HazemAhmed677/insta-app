import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/cubits/fetch_all_users_cubit/fetch_all_users_cubit.dart';
import 'package:insta_app/cubits/fetch_all_users_cubit/fetch_all_users_states.dart';
import 'package:insta_app/helper/clear_history_helper.dart';
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
            height: hight * 0.018,
          ),
          (widget.currentUser!.serachedPeople!.isNotEmpty)
              // then show clear all bar
              ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 70.0),
                    child: Column(
                      children: [
                        ClearHistoryHelper(userModel: widget.currentUser!),
                        Expanded(
                          child: ListView.builder(
                            clipBehavior: Clip.none,
                            itemCount:
                                widget.currentUser!.serachedPeople!.length,
                            itemBuilder: (BuildContext context, int index) {
                              List searchedPeopleBefore =
                                  widget.currentUser!.serachedPeople!;
                              // ++++++++++++++++++++++++
                              // fetch searched user data
                              return StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection(kUsers)
                                      .doc(searchedPeopleBefore[index]['uid'])
                                      .snapshots(),
                                  builder: (context, snapshot2) {
                                    return (snapshot2.connectionState ==
                                            ConnectionState.waiting)
                                        ? const SizedBox()
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 4.0),
                                            child: Dismissible(
                                              key: UniqueKey(),
                                              direction:
                                                  DismissDirection.endToStart,
                                              onDismissed: (direction) {},
                                              child: SizedBox(
                                                height: hight * 0.08,
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(21),
                                                  radius: 16,
                                                  onTap: () {
                                                    Map<String, dynamic>
                                                        searchedUserMap =
                                                        snapshot2.data!.data()
                                                            as Map<String,
                                                                dynamic>;

                                                    UserModel searchedUser =
                                                        UserModel.fromJson(
                                                            searchedUserMap);

                                                    Get.to(
                                                      SafeArea(
                                                        child: (ProfileView(
                                                          currentUser: widget
                                                              .currentUser,
                                                          userModel:
                                                              searchedUser,
                                                        )),
                                                      ),
                                                    );
                                                  },
                                                  child: PersonInSearch(
                                                      currentUserID: widget
                                                          .currentUser!.uid,
                                                      searchedUser:
                                                          UserModel.fromJson(
                                                        snapshot2.data!.data(),
                                                      ),
                                                      username:
                                                          searchedPeopleBefore[
                                                                  index]
                                                              ['username'],
                                                      imageURL:
                                                          searchedPeopleBefore[
                                                                  index][
                                                              'profile image']),
                                                ),
                                              ),
                                            ),
                                          );
                                  });
                            },
                          ),
                        ),
                      ],
                    ),
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
