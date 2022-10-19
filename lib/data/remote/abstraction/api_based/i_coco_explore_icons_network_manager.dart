import '/data/abstraction/i_explore_icon_manager.dart';
import '/data/remote/abstraction/api_based/i_coco_network_manager.dart';

//base class for coco explore icon network manager, saving coco network credential, etc, and explore icon manager functionalities
abstract class ICocoExploreIconNetworkManager extends ICocoNetworkManager
    implements IExploreIconManager {}
