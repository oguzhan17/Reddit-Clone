import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:reddit_clone/constants/text_style.dart';
import 'package:reddit_clone/repositories/post_repository.dart';

import '../bloc/post_cubit.dart';
import '../bloc/post_state.dart';
import '../core/extension/context_extension.dart';

class BlocPostView extends StatefulWidget {
  static const String id = 'BlocPostView';

  @override
  _BlocPostViewState createState() => _BlocPostViewState();
}

class _BlocPostViewState extends State<BlocPostView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostCubit(SamplePostRepository()),
      child: buildScaffold(),
    );
  }

  Scaffold buildScaffold() => Scaffold(
        appBar: AppBar(
          title: Text('Reddit'),
          backgroundColor: Colors.deepOrange,
        ),
        body: BlocConsumer<PostCubit, PostState>(
          listener: (context, state) {
            if (state is PostError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is PostInitial) {
              context.read<PostCubit>().getPost();
              return SizedBox.shrink();
            } else if (state is PostLoading) {
              return buildPostLoading();
            } else if (state is PostCompleted) {
              return buildPostList(state);
            } else {
              final error = state as PostError;
              return Text(error.message);
            }
          },
        ),
      );

  ListView buildPostList(PostCompleted state) {
    return ListView.builder(
      itemBuilder: (context, index) => Column(
        children: [
          SizedBox(
            height: context.lowValueH,
          ),
          Text(
            state.response[index].title,
            style: titleTextStyle,
          ),
          state.response[index].description != null
              ? buildDescriptionText(context, state, index)
              : SizedBox.shrink(),
          state.response[index].thumbnail != null
              ? buildThumbnail(context, state, index)
              : SizedBox.shrink(),
        ],
      ),
      itemCount: state.response.length,
    );
  }

  Padding buildThumbnail(BuildContext context, PostCompleted state, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.lowValueH),
      child: CachedNetworkImage(
        imageUrl: state.response[index].thumbnail,
        width: context.dynamicWidth(1),
        height: context.dynamicHeight(0.4),
        fit: BoxFit.cover,
      ),
    );
  }

  Align buildDescriptionText(
      BuildContext context, PostCompleted state, int index) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: context.highValueW),
        child: Text(
          state.response[index].description,
          style: descriptionTextStyle,
        ),
      ),
    );
  }

  Center buildPostLoading() {
    return Center(
      child: Lottie.asset('lib/assets/loading.json'),
    );
  }
}
