import 'package:coco_exp/app/models/base_model.dart';
import '/app/models/explore_icon_model.dart';
import '/app/models/segmentation_model.dart';

class ImageModel extends BaseModel {
  final String cocoUrl;
  final String flicrUrl;
  late List<String> captions;
  late List<SegmentationModel> segmentations;

  //this method executes to get explore icons-categories which are existed in segmentations of this image
  List<ExploreIconModel> getExploreIcons() {
    List<ExploreIconModel> icons = [];
    for (var seg in segmentations) {
      final iconExisted = icons.any((element) => element.id == seg.exploreId);
      if (!iconExisted) {
        final icon = ExploreIconModel(title: '', id: seg.exploreId);
        icons.add(icon);
      }
    }
    return icons;
  }

  ImageModel({
    required dynamic id,
    required this.cocoUrl,
    required this.flicrUrl,
  }) : super(id: id);
}
