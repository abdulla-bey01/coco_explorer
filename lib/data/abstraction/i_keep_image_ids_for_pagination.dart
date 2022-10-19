import 'package:flutter/foundation.dart';

//can add keeping image ids functionlaity to classes it need(keep dry)
mixin IKeepImageIdsForPagination {
  late List<int> imageIds;
  void addAllIds(List<int> news) {
    for (var imageId in news) {
      final idExisted = imageIds.any((element) => element == imageId);
      if (!idExisted) {
        imageIds.add(imageId);
      }
    }
  }
}
