import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';
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
    TextEditingController textEditingController = TextEditingController();
    String input;
    return FutureBuilder(
        future: FetchSearchedUsers().fetchSearchedUsers('HZM_1'),
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: hight * 0.02,
                  ),
                  TextField(
                    onSubmitted: (value) {
                      input = value;
                    },
                    controller: textEditingController,
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
                  (snapshot.hasData)
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return PersonInSearch(
                                user: UserModel.fromJson(
                                    snapshot.data!.docs[index]),
                              );
                            },
                          ),
                        )
                      : (snapshot.connectionState == ConnectionState.waiting)
                          ? Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: hight * 0.34),
                              child: const CircularProgressIndicator(
                                color: kPuple,
                              ),
                            )
                          : (snapshot.hasError)
                              ? Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0.34 * hight),
                                  child: const Text('ther something wrong'),
                                )
                              : (snapshot.data == null)
                                  ? const SizedBox()
                                  : Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: hight * 0.34),
                                      child: const Text(
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
          );
        });
  }
}
