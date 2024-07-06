import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileGridView extends StatelessWidget {
  const ProfileGridView({super.key, required this.posts});
  final QuerySnapshot<Map<String, dynamic>>? posts;
  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      itemCount: posts?.size ?? 0,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.95,
        mainAxisSpacing: 3,
        crossAxisSpacing: 3,
      ),
      itemBuilder: (context, index) {
        return ClipRRect(
            child: Image.network(
          posts!.docs[index]['imageURL'],
          fit: BoxFit.cover,
        ));
      },
    );
  }
}
