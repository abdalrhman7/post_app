
import 'package:dartz/dartz.dart';
import 'package:post_app/features/posts/domain/repo/post_repo.dart';

import '../../../../core/error/failures.dart';
import '../entities/post.dart';

class AddPostUseCase{
  final PostsRepository repository;

  AddPostUseCase(this.repository);

  Future<Either<Failure, Unit>>  call(Post post) async{
    return await repository.addPost(post);
  }
}