import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/cubits/fetch_user_data_cubit/fetch_user_data_cubit.dart';
import 'package:insta_app/models/post_model.dart';
import 'package:insta_app/models/user_model.dart';
import 'package:insta_app/views/add_comment_view.dart';

class CustomPostWidget extends StatefulWidget {
  const CustomPostWidget({super.key, required this.postModel});
  final PostModel postModel;
  @override
  State<CustomPostWidget> createState() => _CustomPostWidgetState();
}

class _CustomPostWidgetState extends State<CustomPostWidget> {
  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    UserModel userModel =
        BlocProvider.of<FetchUserDataCubit>(context).userModel;
    String imageURL = widget.postModel.imageURL;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: (userModel.profileImageURL != null)
                  ? NetworkImage(userModel.profileImageURL!)
                  : null,
              radius: 30,
            ),
            SizedBox(
              width: 0.03 * width,
            ),
            Row(
              children: [
                Text(
                  userModel.username,
                  style: const TextStyle(
                    color: kWhite,
                    fontSize: 18,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 4.0),
                  child: Icon(
                    Icons.verified,
                    size: 16,
                    color: Colors.blue,
                  ),
                ),
              ],
            )
          ],
        ),
        SizedBox(
          height: 0.025 * hight,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image.network(imageURL),
        ),
        SizedBox(
          height: hight * 0.025,
        ),
        Row(
          children: [
            IconButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(10, 20),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () async {
                isLiked = !isLiked;

                var list = await FirebaseFirestore.instance
                    .collection(kPosts)
                    .where('likes')
                    .get();

                setState(() {});
              },
              icon: (isLiked)
                  ? const Icon(
                      Icons.favorite,
                      color: kPink,
                      size: 28,
                    )
                  : const Icon(
                      Icons.favorite_outline,
                      size: 28,
                    ),
            ),
            SizedBox(
              width: width * 0.03,
            ),
            IconButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(20, 10),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () {},
              icon: const Icon(
                Icons.comment,
                size: 27,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 0.01 * hight,
        ),
        Text(
          (widget.postModel.likes.length != 1)
              ? "${widget.postModel.likes.length.toString()} likes"
              : "${widget.postModel.likes.length.toString()} like",
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 0.009 * hight,
        ),
        Row(
          children: [
            Text(
              userModel.username,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 2.0),
              child: Icon(
                Icons.verified,
                size: 16,
                color: Colors.blue,
              ),
            ),
            (widget.postModel.desciption != null)
                ? Text(
                    " ${widget.postModel.desciption!}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
        SizedBox(
          height: 0.012 * hight,
        ), ////
        SizedBox(
          height: hight * 0.04,
          width: width * 0.3,
          child: TextButton(
            style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                backgroundColor:
                    WidgetStateProperty.all<Color>(Colors.transparent),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    side: BorderSide(
                      color: Colors.grey.shade500,
                    ), // White outline border
                  ),
                )),
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) =>
                      const AddCommentView(), // Replace with your second screen widget
                  transitionDuration: const Duration(milliseconds: 40),
                  transitionsBuilder: (_, a, __, c) =>
                      FadeTransition(opacity: a, child: c),
                ),
              );
            },
            child: const Text(
              'Add comment...',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 0.032 * hight,
        ),
      ],
    );
  }
}
