import 'package:flutter/material.dart';
import 'package:intro_app/app_localizations.dart';
import 'package:intro_app/data/data.dart';
import 'package:intro_app/models/normal_post.dart';
import 'package:intro_app/models/post_model.dart';
import 'package:intro_app/widgets/post_container.dart';

class ProfilePosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        brightness: Theme.of(context).brightness,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          AppLocalizations.of(context).translate("posts"),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final Post post = profilePosts[index];
              return PostContainer(post: post);
            }, childCount: posts.length),
          ),
        ],
      ),
    );
  }
}
