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
              backgroundImage: NetworkImage(imageURL),
              maxRadius: 34,
            ),
            SizedBox(
              width: 0.035 * width,
            ),
            Text(
              userModel.username,
              style: const TextStyle(
                color: kWhite,
                fontSize: 22,
              ),
            )
          ],
        ),
        SizedBox(
          height: 0.02 * hight,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(imageURL),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            IconButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(10, 10),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {
                  isLiked = !isLiked;
                  setState(() {});
                },
                icon: Icon(
                  Icons.favorite,
                  color: (isLiked) ? kPink : null,
                  size: 28,
                )),
            const SizedBox(
              width: 10,
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
                  size: 26,
                ))
          ],
        ),
        SizedBox(
          height: 0.016 * hight,
        ),
        Text(
          widget.postModel.likes?.length.toString() ?? '0',
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        (widget.postModel.desciption != null)
            ? Text(
                widget.postModel.desciption!,
                style: const TextStyle(
                  fontSize: 18,
                ),
              )
            : const SizedBox(),
        TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.only(left: 1, right: 4),
            minimumSize: const Size(50, 30),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
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
            'Add comment',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ),
        SizedBox(
          height: 0.02 * hight,
        ),
      ],
    );
  }
}
