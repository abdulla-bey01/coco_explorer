import 'dart:convert';
import '/app/models/image_model.dart';
import '/app/models/segmentation_model.dart';
import '/data/abstraction/i_image_manager.dart';
import '/data/helpers/models/search_arguments.dart';
import 'package:get/get.dart';

//
class SearchInteractor {
  Future<List<ImageModel>> searchWithQueryType(List<int> explorIconeIds,
      {bool loadMore = true}) async {
    //get image manager from Get di container
    final IImageManager searchManager = Get.find();
    //check it is need to load more or not, if load more is false, this means developer need to get new images based on new search icon ids
    if (!loadMore) {
      //create argument object
      final arguments = SearchArguments(
          categoryIds: explorIconeIds, queryType: 'getImagesByCats');
      //get image ids to keep it inside of data side
      await searchManager.getImageIdsByExploreCategoryIds(arguments);
    }
    //
    //part of joining server data to unique model
    //get paginated items(image data - caption, segments, details)
    final result = await searchManager.getPaginatedImages();
    //if no image found, return empty list
    if (result == null) return [];
    //if there is an image, create image list
    List<ImageModel> images = [];
    //seperate image details based on result we get from remote or local source
    for (var detail in result.details) {
      //create image object
      ImageModel img = ImageModel(
        id: detail['id'],
        cocoUrl: detail['coco_url'],
        flicrUrl: detail['flickr_url'],
      );
      //
      //add captions of image
      img.captions = [];
      //get captions of image to set it into image
      final captionsDynamicList = result.captions
          .where((element) => element['image_id'] == img.id)
          .map((e) => e['caption'])
          .toList();
      final captions = List<String>.from(captionsDynamicList);
      img.captions.addAll(captions);
      //
      //add segmentation of image
      img.segmentations = [];
      //
      //get segmenttation of image from all segmentations
      final segmentationsData = result.segmentations
          .where((element) => element['image_id'] == img.id);
      for (var segmentation in segmentationsData) {
        //
        //create segmentation object based on explore icon
        SegmentationModel segment = SegmentationModel(
          segments: [],
          exploreId: segmentation['category_id'],
        );
        final decodedSegmentations = segmentation['segmentation'] != null
            ? json.decode(segmentation['segmentation'])
            : json.decode(segmentation['counts']);
        //
        //add segmentations to explore icon
        if (decodedSegmentations is List) {
          for (var segmentListElement in decodedSegmentations) {
            segment.segments.add(List<num>.from(segmentListElement));
          }
        } else {
          segment.segments.add(List<num>.from(decodedSegmentations['counts']));
        }
        img.segmentations.add(segment);
      }
      images.add(img);
    }
    return images;
  }
}
