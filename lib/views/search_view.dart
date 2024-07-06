import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/cubits/fetch_all_users_cubit/fetch_all_users_cubit.dart';
import 'package:insta_app/cubits/fetch_all_users_cubit/fetch_all_users_states.dart';
import 'package:insta_app/cubits/fetch_user_data_cubit/fetch_user_data_cubit.dart';
import 'package:insta_app/helper/person_in_search.dart';
import 'package:insta_app/models/user_model.dart';
import 'package:insta_app/services/fetch_and_push_searched_people_service.dart';
import 'package:insta_app/services/fetch_user_data_service.dart';
import 'package:insta_app/views/profile_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});
  static String searchId = 'Search page';

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  QuerySnapshot<Map<String, dynamic>>? fetchedPersons;
  bool flag = false;
  bool flag2 = true;
  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    String? input;
    UserModel userModel =
        BlocProvider.of<FetchUserDataCubit>(context).userModel;
    return FutureBuilder<List<dynamic>?>(
        future: FetchAndPushSearchedPeopleService()
            .fetchAllSearched(currentUser: userModel),
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: SizedBox(
              height: hight,
              child: Column(
                children: [
                  SizedBox(
                    height: hight * 0.02,
                  ),
                  TextField(
                    onSubmitted: (value) async {
                      if (value != '') {
                        input = value;
                        flag = true;
                        try {
                          fetchedPersons =
                              await BlocProvider.of<FetchSearchedUsersCubit>(
                                      context)
                                  .fetchSearchedUsers(input!);
                          if (fetchedPersons!.docs.isNotEmpty) {
                            for (int i = 0;
                                i < fetchedPersons!.docs.length;
                                i++) {
                              await FetchAndPushSearchedPeopleService()
                                  .pushSerached(
                                currentUser: userModel,
                                searchedOne:
                                    UserModel.fromJson(fetchedPersons!.docs[i]),
                              );
                            }
                          }
                          setState(() {});
                        } catch (e) {
                          print(e.toString());
                        }
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(14),
                        ),
                        borderSide: BorderSide(
                          color: kWhite,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(14),
                        ),
                        borderSide: BorderSide(color: kPuple),
                      ),
                    ),
                    cursorColor: kPuple,
                  ),
                  SizedBox(
                    height: hight * 0.01,
                  ),
                  (snapshot.connectionState == ConnectionState.waiting)
                      ? const Padding(
                          padding: EdgeInsets.only(top: 18.0),
                          child: Center(
                            child: (CircularProgressIndicator(
                              color: kPink,
                            )),
                          ),
                        )
                      : (!flag && snapshot.hasData && snapshot.data!.isNotEmpty)
                          ? Expanded(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2.0),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                          style: TextButton.styleFrom(
                                              padding: const EdgeInsets.only(
                                                  right: 6, left: 6),
                                              minimumSize: const Size(30, 30),
                                              tapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap),
                                          onPressed: () async {
                                            AlertDialog alert = AlertDialog(
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 20, 20, 20),
                                              title: const Text(
                                                'Are you sure ?',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: const Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                      color: kWhite,
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    try {
                                                      Get.back();
                                                      await FetchAndPushSearchedPeopleService()
                                                          .removeSearchHistory(
                                                              currentUser:
                                                                  userModel);

                                                      setState(() {});
                                                    } catch (e) {
                                                      print(e.toString());
                                                    }
                                                  },
                                                  child: const Text(
                                                    'Delete',
                                                    style: TextStyle(
                                                      color: kPink,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                            await showDialog(
                                              context: context,
                                              builder: (context) => alert,
                                            );
                                          },
                                          child: const Text(
                                            'clear history',
                                            style: TextStyle(
                                              color: kPink,
                                              fontSize: 15,
                                            ),
                                          )),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      clipBehavior: Clip.none,
                                      itemCount:
                                          userModel.serachedPeople?.length ?? 0,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 10.0,
                                          ),
                                          child: Dismissible(
                                            key: UniqueKey(),
                                            direction:
                                                DismissDirection.endToStart,
                                            onDismissed: (direction) {},
                                            child: SizedBox(
                                              height: hight * 0.08,
                                              child: InkWell(
                                                // highlightColor: kBlack,
                                                borderRadius:
                                                    BorderRadius.circular(21),
                                                radius: 16,
                                                onTap: () async {
                                                  var user =
                                                      await FetchUserDataService()
                                                          .fetchUserData(
                                                    id: userModel
                                                            .serachedPeople![
                                                        index]['uid'],
                                                  );
                                                  Get.to(
                                                      () => ProfileView(
                                                            userModel: user,
                                                            bar: "Follow",
                                                          ),
                                                      curve: Curves
                                                          .easeInOutQuint);
                                                },
                                                child: PersonInSearch(
                                                  username:
                                                      userModel.serachedPeople![
                                                          index]['username'],
                                                  imageURL: userModel
                                                          .serachedPeople![
                                                      index]['profile image'],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : BlocBuilder<FetchSearchedUsersCubit,
                              FetchSearchedUsersStates>(
                              builder: (context, state) {
                                if ((state is SucceedState)) {
                                  return (fetchedPersons?.docs.isEmpty ?? false)
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                              top: hight * 0.38),
                                          child: const Center(
                                            child: Text(
                                              'user not found',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Expanded(
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: hight * 0.015,
                                              ),
                                              Expanded(
                                                child: ListView.builder(
                                                  itemCount: fetchedPersons
                                                          ?.docs.length ??
                                                      0,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        bottom: 10.0,
                                                      ),
                                                      child: Dismissible(
                                                        key: UniqueKey(),
                                                        direction:
                                                            DismissDirection
                                                                .endToStart,
                                                        onDismissed:
                                                            (direction) {},
                                                        child: SizedBox(
                                                          height: hight * 0.08,
                                                          child: InkWell(
                                                            highlightColor:
                                                                kBlack,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        21),
                                                            radius: 16,
                                                            onTap: () {
                                                              Get.to(
                                                                  () =>
                                                                      ProfileView(
                                                                        userModel:
                                                                            UserModel.fromJson(
                                                                          fetchedPersons!
                                                                              .docs[index],
                                                                        ),
                                                                        bar:
                                                                            "Follow",
                                                                      ),
                                                                  curve: Curves
                                                                      .easeIn);
                                                            },
                                                            child:
                                                                PersonInSearch(
                                                              username: fetchedPersons!
                                                                          .docs[
                                                                      index]
                                                                  ['username'],
                                                              imageURL: fetchedPersons!
                                                                          .docs[
                                                                      index][
                                                                  'profileImageURL'],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                } else {
                                  return (state is LoadingState)
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                            top: hight * 0.38,
                                          ),
                                          child:
                                              const CircularProgressIndicator(
                                            color: kPuple,
                                          ),
                                        )
                                      : (state is FailuireState)
                                          ? const Center(
                                              child: Text(
                                                  'oops, there somthing wrong'),
                                            )
                                          : const SizedBox();
                                }
                              },
                            ),
                ],
              ),
            ),
          );
        });
  }
}
