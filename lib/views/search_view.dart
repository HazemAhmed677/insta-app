import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/route_manager.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/cubits/fetch_all_users_cubit/fetch_all_users_cubit.dart';
import 'package:insta_app/cubits/fetch_all_users_cubit/fetch_all_users_states.dart';
import 'package:insta_app/cubits/fetch_user_data_cubit/fetch_user_data_cubit.dart';
import 'package:insta_app/helper/person_in_search.dart';
import 'package:insta_app/models/user_model.dart';
import 'package:insta_app/services/fetch_and_push_searched_people_service.dart';
import 'package:insta_app/views/profile_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});
  static String searchId = 'Search page';

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  QuerySnapshot<Map<String, dynamic>>? fetchedPersons;
  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    String? input;
    UserModel userModel =
        BlocProvider.of<FetchUserDataCubit>(context).userModel;
    bool flag = false;
    return FutureBuilder(
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
                                    searchedOne: UserModel.fromJson(
                                        fetchedPersons!.docs[i]));
                          }
                        }
                        setState(() {});
                      } catch (e) {
                        print(e.toString());
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
                    height: hight * 0.025,
                  ),
                  (!flag && snapshot.hasData)
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: userModel.serachedPeople?.length ?? 0,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 10.0,
                                ),
                                child: Dismissible(
                                  key: UniqueKey(),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (direction) {},
                                  child: SizedBox(
                                    height: hight * 0.08,
                                    child: InkWell(
                                      highlightColor: kBlack,
                                      borderRadius: BorderRadius.circular(21),
                                      radius: 16,
                                      onTap: () {
                                        Get.to(
                                            () => ProfileView(
                                                userModel: userModel
                                                    .serachedPeople![index]),
                                            curve: Curves.easeInOutQuint);
                                      },
                                      child: PersonInSearch(
                                        username: userModel
                                            .serachedPeople![index]['username'],
                                        imageURL:
                                            userModel.serachedPeople![index]
                                                ['profile image'],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : BlocBuilder<FetchSearchedUsersCubit,
                          FetchSearchedUsersStates>(
                          builder: (context, state) {
                            return (state is SucceedState)
                                ? (fetchedPersons?.docs.isEmpty ?? false)
                                    ? Padding(
                                        padding:
                                            EdgeInsets.only(top: hight * 0.38),
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
                                        child: ListView.builder(
                                          itemCount:
                                              fetchedPersons?.docs.length ?? 0,
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
                                                    highlightColor: kBlack,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            21),
                                                    radius: 16,
                                                    onTap: () {
                                                      Get.to(
                                                          () => ProfileView(
                                                                userModel: UserModel.fromJson(
                                                                    fetchedPersons!
                                                                            .docs[
                                                                        index]),
                                                              ),
                                                          curve: Curves
                                                              .easeInOutQuint);
                                                    },
                                                    child: PersonInSearch(
                                                      username: fetchedPersons!
                                                              .docs[index]
                                                          ['username'],
                                                      imageURL: fetchedPersons!
                                                              .docs[index]
                                                          ['profileImageURL'],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                : (state is LoadingState)
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                          top: hight * 0.38,
                                        ),
                                        child: const CircularProgressIndicator(
                                          color: kPuple,
                                        ),
                                      )
                                    : (state is FailuireState)
                                        ? const Center(
                                            child: Text(
                                                'oops, there somthing wrong'),
                                          )
                                        : const SizedBox();
                          },
                        ),
                ],
              ),
            ),
          );
        });
  }
}
