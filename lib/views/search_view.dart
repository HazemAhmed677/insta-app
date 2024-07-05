import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/cubits/fetch_all_users_cubit/fetch_all_users_cubit.dart';
import 'package:insta_app/cubits/fetch_all_users_cubit/fetch_all_users_states.dart';
import 'package:insta_app/helper/person_in_search.dart';
import 'package:insta_app/models/user_model.dart';
import 'package:insta_app/services/fetch_searched_users.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});
  static String searchId = 'Search page';

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    String? input;
    return BlocBuilder<FetchSearchedUsersCubit, FetchSearchedUsersStates>(
      builder: (context, state) {
        return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
            future: BlocProvider.of<FetchSearchedUsersCubit>(context)
                .fetchSearchedUsers(input ?? "HZM_1"),
            builder: (context, snapshot) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: hight,
                    child: Column(
                      children: [
                        SizedBox(
                          height: hight * 0.02,
                        ),
                        TextField(
                          onSubmitted: (value) {
                            input = value;
                            setState(() {});
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
                        (snapshot.hasData && state is SucceedState)
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: snapshot.data?.docs.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return PersonInSearch(
                                      user: UserModel.fromJson(
                                          snapshot.data!.docs[index]),
                                    );
                                  },
                                ),
                              )
                            : (snapshot.connectionState ==
                                    ConnectionState.waiting)
                                ? const CircularProgressIndicator(
                                    color: kPuple,
                                  )
                                : (snapshot.hasError)
                                    ? const Text('ther something wrong')
                                    : (snapshot.data == null)
                                        ? const SizedBox()
                                        : const Center(
                                            child: Text(
                                              'user not found',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 20,
                                              ),
                                            ),
                                          )
                      ],
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}
