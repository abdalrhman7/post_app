import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/app_theme.dart';
import 'features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'features/posts/presentation/bloc/posts/posts_bloc.dart';

import 'features/posts/presentation/screen/posts_page.dart';
import 'injection.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await initGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<PostsBloc>()..add(GetAllPostsEvent())),
        BlocProvider(create: (_) => sl<AddDeleteUpdatePostBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        title: 'Posts App',
        home: const PostsPage(),
      ),
    );
  }
}
