import 'package:bloc_network_api_practice/features/posts/bloc/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final PostsBloc postsBloc = PostsBloc();
  @override
  void initState() {
    postsBloc.add(PostsInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => postsBloc.add(PostsAddEvent()),
      ),
      body: BlocConsumer<PostsBloc, PostsState>(
        bloc: postsBloc,
        listenWhen: (previous, current) => current is PostsActionState,
        buildWhen: (previous, current) => current is! PostsActionState,
        listener: (context, state) {
          switch (state.runtimeType) {
            case PostsAddSuccessState:
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Center(
                    child: Text(
                  "Post addition successfully",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
                backgroundColor: Colors.green,
              ));
            case PostsAddFailureState:
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Center(
                    child: Text(
                  "Post addition failure",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
                backgroundColor: Colors.red,
              ));
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case PostsLoadingState:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case PostsFetchSuccessState:
              final successState = state as PostsFetchSuccessState;
              return ListView.builder(
                  itemCount: successState.posts.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.grey.shade200,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            (index + 1).toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  successState.posts[index].title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(successState.posts[index].body),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            case PostsFetchErrorState:
              return const Center(
                child: Text(
                  "Error fetching posts",
                  style: TextStyle(color: Colors.red),
                ),
              );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
