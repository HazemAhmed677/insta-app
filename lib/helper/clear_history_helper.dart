import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/models/user_model.dart';
import 'package:insta_app/services/fetch_and_push_searched_people_service.dart';

class ClearHistoryHelper extends StatefulWidget {
  const ClearHistoryHelper({super.key, required this.userModel});
  final UserModel userModel;
  @override
  State<ClearHistoryHelper> createState() => _ClearHistoryHelperState();
}

class _ClearHistoryHelperState extends State<ClearHistoryHelper> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.only(right: 14, left: 14),
                      minimumSize: const Size(30, 30),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                  onPressed: () async {
                    AlertDialog alert = AlertDialog(
                      backgroundColor: const Color.fromARGB(255, 20, 20, 20),
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
                                      currentUser: widget.userModel!);
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'Clear history',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      const Icon(
                        Icons.cancel_outlined,
                        color: kPink,
                        size: 20,
                      )
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
