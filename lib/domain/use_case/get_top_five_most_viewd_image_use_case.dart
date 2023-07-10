import 'package:image_search_7day/core/result.dart';
import 'package:image_search_7day/domain/model/photo.dart';
import 'package:image_search_7day/domain/respository/photo_repository.dart';

class GetTopFiveMoseViewdImageUseCase {
  final PhotoRepository _repository;

  GetTopFiveMoseViewdImageUseCase(this._repository);

  Future<Result<List<Photo>>> execute(String query) async {
    try {
      final photos = await _repository.getPhotos(query);
      photos.sort((a, b) => -a.views.compareTo(b.views));

      return Result.success(photos.take(5).toList());
    } catch (err) {
      return const Result.error('에러가 발생했습니다.');
    }
  }
}
