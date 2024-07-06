import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/cubits/fetch_all_users_cubit/fetch_all_users_cubit.dart';
import 'package:insta_app/cubits/fetch_all_users_cubit/fetch_all_users_states.dart';
import 'package:insta_app/helper/person_in_search.dart';
import 'package:insta_app/models/user_model.dart';

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
                try {
                  fetchedPersons =
                      await BlocProvider.of<FetchSearchedUsersCubit>(context)
                          .fetchSearchedUsers(input!);
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
            BlocBuilder<FetchSearchedUsersCubit, FetchSearchedUsersStates>(
              builder: (context, state) {
                return (state is SucceedState)
                    ? (fetchedPersons?.docs.isEmpty ?? false)
                        ? Padding(
                            padding: EdgeInsets.only(top: hight * 0.38),
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
                              itemCount: fetchedPersons?.docs.length ?? 0,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 22.0),
                                  child: PersonInSearch(
                                    user: UserModel.fromJson(
                                      fetchedPersons!.docs[index],
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
                                child: Text('oops, there somthing wrong'),
                              )
                            : const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
