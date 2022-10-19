import '/data/dtos/explore_icon_dto.dart';
import '/data/remote/abstraction/api_based/i_coco_explore_icons_network_manager.dart';

//concret coco explore icon manager
class CocoExploreIconNetworkManager extends ICocoExploreIconNetworkManager {
  @override
  Future<List<ExploreIconDto>> getAll() async {
    await Future.delayed(const Duration(seconds: 2));
    return [];
  }
}
