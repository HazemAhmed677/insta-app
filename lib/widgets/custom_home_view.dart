import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:insta_app/helper/post_widget.dart';
import 'package:insta_app/views/sign_in_view.dart';

class CustomHomeView extends StatelessWidget {
  const CustomHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Insta',
                style: TextStyle(
                  fontFamily: 'PlaywriteMX',
                  fontSize: 36,
                ),
              ),
              IconButton(
                onPressed: () async {
                  AlertDialog alert = AlertDialog(
                    title: const Text('Are you sure?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                            ..pop()
                            ..pop();
                        },
                        child: const Text('yes'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('no'),
                      ),
                    ],
                  );
                  return await showDialog(
                    context: context,
                    builder: (context) => alert,
                  );
                },
                icon: const Icon(
                  Icons.logout,
                  size: 26,
                ),
                tooltip: 'Log out',
              )
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: hight * 0.18,
          ),
        ),
        SliverList.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return const CustomPostWidget();
          },
        ),
      ],
    );
  }
}
