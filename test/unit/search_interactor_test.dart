import 'package:coco_exp/app/interactors/search_interactor.dart';
import 'package:coco_exp/data/abstraction/i_image_manager.dart';
import 'package:coco_exp/data/remote/concrency/coco_image_network_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  late SearchInteractor searchInteractor;
  setUp(() {
    searchInteractor = SearchInteractor();
    Get.put<IImageManager>(CocoImageNetworkManager());
  });
  test('category service testing', () async {
    final results = await searchInteractor.searchWithQueryType([10, 11]);
    expect(results, isNotNull);
  });
}
