import '/data/dtos/image_dto.dart';
import '/data/helpers/models/search_arguments.dart';

//provides all image managers with the functions or properties they need
abstract class IImageManager<T> {
  Future<List<T>> getImageIdsByExploreCategoryIds(SearchArguments arguments);
  Future<List<T>> getCaptionsOfImages(List<int> ids);
  Future<List<T>> getSegmentationsOfImages(List<int> ids);
  Future<List<T>> getDetailsOfImages(List<int> ids);
  Future<ImageListDto?> getPaginatedImages();
}
