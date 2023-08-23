import 'package:dartz/dartz.dart';
import 'package:post_app/features/posts/domain/repo/post_repo.dart';

import '../../../../core/error/failures.dart';
import '../entities/post.dart';

class DeletePostsUseCase{
  final PostsRepository repository;

  DeletePostsUseCase(this.repository);

  Future<Either<Failure, Unit>>  call(int postId) async{
    return await repository.deletePost(postId);
  }
}