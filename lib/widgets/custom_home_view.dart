import 'package:flutter/material.dart';
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
              Tooltip(
                message: 'Log out',
                showDuration: const Duration(milliseconds: 500),
                child: IconButton(
                  onPressed: () async {
                    AlertDialog alert = AlertDialog(
                      backgroundColor: Colors.black,
                      shadowColor: Colors.grey.shade800,
                      title: const Text('Are you sure?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('No'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                              ..pop()
                              ..pop();
                          },
                          child: const Text('Yes'),
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
                ),
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
          itemCount: 4,
          itemBuilder: (context, index) {
            return const CustomPostWidget();
          },
        ),
      ],
    );
  }
}
