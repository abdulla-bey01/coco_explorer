import 'package:http/http.dart' as http;

//base network manager keeping base url. Can keep more data
abstract class INetworkManager {
  late final String baseUrl;

  final http.Client client = http.Client();

  INetworkManager({required this.baseUrl});
}
