import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:insta_app/helper/post_widget.dart';

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
                  onPressed: () {},
                  icon: const Icon(
                    Icons.logout,
                    size: 26,
                  ))
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: hight * 0.20,
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
