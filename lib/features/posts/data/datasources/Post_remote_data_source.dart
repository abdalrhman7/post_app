import 'package:dartz/dartz.dart';
import 'package:post_app/core/error/exception.dart';
import 'package:post_app/features/posts/data/models/post_model.dart';
import 'package:dio/dio.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> deletePost(int postId);
  Future<Unit> updatePost(PostModel postModel);
  Future<Unit> addPost(PostModel postModel);
}

const BASE_URL = 'https://jsonplaceholder.typicode.com/';
const postsUrl = "${BASE_URL}posts/";

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final Dio dio;

  PostRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await dio.get(postsUrl,
        options: Options(headers: {'Content_type': 'application/json'}));

    if (response.statusCode == 200) {

      return List<PostModel>.from((response.data as List)
          .map((e) => PostModel.fromJson(e)));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final body = {
      'title': postModel.title,
      'body': postModel.body,
    };
    final response = await dio.post(postsUrl, data: body);

    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response = await dio.delete('$postsUrl$postId',
        options: Options(headers: {'Content_type': 'application/json'}));

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final postId = postModel.id.toString();
    final body = {
      'title': postModel.title,
      'body': postModel.body,
    };

    final response = await dio.patch('$postsUrl${postModel.id}', data: body);

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  List<PostModel> getPostsList(Map<String, dynamic> data) {
    List<PostModel> posts = [];

    posts.add(PostModel.fromJson(data));

    return posts;
  }
}
