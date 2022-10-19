import '/data/abstraction/i_image_manager.dart';
import '/data/remote/abstraction/api_based/i_coco_network_manager.dart';

//base class for coco image network manager, saving coco network credential, etc, and image manager functionalities
abstract class ICocoImageNetworkManager extends ICocoNetworkManager
    implements IImageManager {}
