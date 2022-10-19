import 'package:flutter/foundation.dart';

//can add keeping image ids functionlaity to classes it need(keep dry)
mixin IKeepImageIdsForPagination {
  late List<int> imageIds;
  void addAllIds(List<int> news) {
    debugPrint(
        'lentgh of image ids in pagination mixin start: ${imageIds.length}');
    for (var imageId in news) {
      final idExisted = imageIds.any((element) => element == imageId);
      if (!idExisted) {
        imageIds.add(imageId);
      }
    }
    debugPrint(
        'lentgh of image ids in pagination mixin end: ${imageIds.length}');
  }
}
