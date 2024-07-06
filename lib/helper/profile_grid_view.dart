import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/services/fetch_user_posts_fo_profile.dart';

class ProfileGridView extends StatelessWidget {
  const ProfileGridView({super.key, required this.uid});
  final String uid;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: FetchUserPostsForProfile().fetchUserPostsFoProfile(uid: uid),
      builder: (context, snapshot) {
        return (snapshot.hasData)
            ? SliverGrid.builder(
                itemCount: snapshot.data?.size ?? 0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.95,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                ),
                itemBuilder: (context, index) {
                  return ClipRRect(
                      child: Image.network(
                    snapshot.data!.docs[index]['imageURL'],
                    fit: BoxFit.cover,
                  ));
                },
              )
            : (snapshot.connectionState == ConnectionState.waiting)
                ? const Text(
                    'Loading',
                    style: TextStyle(fontFamily: 'PlaywriteMX'),
                  )
                : const SliverToBoxAdapter(
                    child: SizedBox(),
                  );
      },
    );
  }
}
