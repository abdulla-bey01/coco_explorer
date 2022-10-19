import 'dart:convert';
import '/data/abstraction/i_keep_image_ids_for_pagination.dart';
import '/data/dtos/image_dto.dart';
import '/data/helpers/mixins/i_paginated.dart';
import '/data/helpers/models/search_arguments.dart';
import '/data/remote/abstraction/api_based/i_coco_image_network_manager.dart';
import 'package:flutter/foundation.dart';

//concret coco image network manager controlling pagination and provide the app with image-search
class CocoImageNetworkManager extends ICocoImageNetworkManager
    with IPaginated, IKeepImageIdsForPagination {
  CocoImageNetworkManager() {
    //set 5 as default page size for image manager
    pageSize = 5;
    //initial page number for pahination
    pageNumber = 1;
    //all image ids returning from search request
    imageIds = [];
  }
  //get image ids of search, and add the result to main list
  @override
  Future<List> getImageIdsByExploreCategoryIds(
      SearchArguments arguments) async {
    pageNumber = 1;
    imageIds = <int>[];
    final url = Uri.parse(baseUrl);
    final response = await client.post(
      url,
      headers: headers,
      body: arguments.toJson(),
    );
    if (response.statusCode == ok) {
      final responseBody = json.decode(response.body);
      debugPrint(
          'responseBody of getImagesByExploreCategoryIds: $responseBody');
      final ids = responseBody;
      final tempList = List<int>.from(ids);
      addAllIds(tempList);
      return ids;
    } else {
      throw Exception(
        'Images can not be fetched, look at ${runtimeType.toString()} - getImageIdsByExploreCategoryIds',
      );
    }
  }

  //return paginated search results
  @override
  Future<ImageListDto?> getPaginatedImages() async {
    //create empty dto to return non-nullable object. Used this twice in this method
    final emptyDto = ImageListDto(
      details: [],
      captions: [],
      segmentations: [],
    );
    //if no result found, return empty dto
    if (imageIds.isEmpty) {
      return emptyDto;
    }
    List<int> ids = [];
    //choose image ids we will use for next page results
    int forStarts = pageNumber * pageSize - pageSize;
    int forEnds = pageNumber * pageSize;
    forEnds = imageIds.length < forEnds ? imageIds.length : forEnds;
    for (int i = forStarts; i < forEnds; i++) {
      final idExisted = ids.any((element) => element == imageIds[i]);
      if (!idExisted) {
        ids.add(imageIds[i]);
      }
    }
    //
    if (ids.isEmpty) {
      return emptyDto;
    }
    debugPrint('pageNumber: $pageNumber, pageSize: $pageSize, imageIds: $ids');
    //get dall image details
    final imageDetails = await getDetailsOfImages(ids);
    //get all captions
    final imageCaptions = await getCaptionsOfImages(ids);
    //get all segmentations
    final imageSegmentations = await getSegmentationsOfImages(ids);
    //create dto providing details
    final dto = ImageListDto(
      details: imageDetails,
      captions: imageCaptions,
      segmentations: imageSegmentations,
    );
    //increase page number for to search next result for next pagination ask
    pageNumber += 1;
    return dto;
  }

  @override
  Future<List> getCaptionsOfImages(List<int> ids) async {
    final url = Uri.parse(baseUrl);
    final response = await client.post(
      url,
      headers: headers,
      body: json.encode({
        'querytype': 'getCaptions',
        'image_ids': ids,
      }),
    );
    if (response.statusCode == ok) {
      final responseBody = response.body;
      debugPrint('responseBody of getCaptionsOfImages: $responseBody');
      return json.decode(responseBody);
    } else {
      throw Exception(
        'Images can not be fetched, look at ${runtimeType.toString()} - getCaptionsOfImages',
      );
    }
  }

  @override
  Future<List> getDetailsOfImages(List<int> ids) async {
    final url = Uri.parse(baseUrl);
    final response = await client.post(
      url,
      headers: headers,
      body: json.encode({
        'querytype': 'getImages',
        'image_ids': ids,
      }),
    );
    if (response.statusCode == ok) {
      final responseBody = json.decode(response.body);
      debugPrint('responseBody of getDetailsOfImages: $responseBody');
      final ids = responseBody;
      return ids;
    } else {
      throw Exception(
        'Images can not be fetched, look at ${runtimeType.toString()} - getDetailsOfImages',
      );
    }
  }

  @override
  Future<List> getSegmentationsOfImages(List<int> ids) async {
    final url = Uri.parse(baseUrl);
    final response = await client.post(
      url,
      headers: headers,
      body: json.encode({
        'querytype': 'getInstances',
        'image_ids': ids,
      }),
    );
    if (response.statusCode == ok) {
      final responseBody = response.body;
      debugPrint('responseBody of getSegmentationsOfImages: $responseBody');
      return json.decode(responseBody);
    } else {
      throw Exception(
        'Images can not be fetched, look at ${runtimeType.toString()} - getSegmentationsOfImages',
      );
    }
  }
}
