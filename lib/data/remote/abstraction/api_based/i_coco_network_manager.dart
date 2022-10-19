import '/app/helpers/models/map_element.dart';
import '/data/remote/abstraction/main/i_network_manager.dart';

//keeps coco network credentials and something for coco network, all coco network manager need to extend from this class
abstract class ICocoNetworkManager extends INetworkManager {
  ICocoNetworkManager()
      : super(
          baseUrl:
              'https://us-central1-open-images-dataset.cloudfunctions.net/coco-dataset-bigquery',
        );

  late Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Map<String, String> buildAndGetHeaders(
      {List<MapElement> additionalHeaders = const []}) {
    for (var element in additionalHeaders) {
      headers.putIfAbsent(element.key, () => element.value);
    }
    return headers;
  }

  final int ok = 200;
  final int created = 201;
  final int notFound = 404;
}
