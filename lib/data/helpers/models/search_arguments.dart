import 'dart:convert';

//helper for adding arguments to api request for image search
class SearchArguments {
  final List<int> categoryIds;
  final String? queryType;

  Map<String, dynamic> toMap() {
    return {
      'querytype': queryType,
      'category_ids': categoryIds,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  SearchArguments({required this.categoryIds, this.queryType});
}
