import 'package:cached_network_image/cached_network_image.dart';
import '/app/models/image_model.dart';
import '/app/models/segmentation_model.dart';
import 'package:flutter/material.dart';
import '../helpers/models/custom_image_with_sizes.dart';
import 'segmentation_painter.dart';

class SearchResultItem extends StatefulWidget {
  const SearchResultItem({
    super.key,
    required this.image,
    required this.getImageAndSize,
  });
  final ImageModel image;
  final Function getImageAndSize;

  @override
  State<SearchResultItem> createState() => _SearchResultItemState();
}

class _SearchResultItemState extends State<SearchResultItem> {
  late List<SegmentationModel> selectedExploreIconSegments;
  dynamic selectedIconId;
  @override
  void initState() {
    super.initState();
    selectedExploreIconSegments = [];
  }

  @override
  Widget build(BuildContext context) {
    final exploreIcons = widget.image.getExploreIcons();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder<SizedImage>(
          future: widget.getImageAndSize(widget.image.cocoUrl),
          builder: (context, snapshot) {
            return snapshot.data == null || !snapshot.hasData
                ? const Center(child: CircularProgressIndicator())
                : CustomPaint(
                    willChange: true,
                    //use foregroundPainter to draw segment onto the image
                    foregroundPainter: SegmentationPainter(
                      segmentations: selectedExploreIconSegments,
                      originalSize: snapshot.data?.originalSize,
                    ),
                    child: Image(
                      image: snapshot.data!.image,
                    ),
                  );
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: SizedBox(
            height: 80,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: exploreIcons.length,
              itemBuilder: (ctx, index) {
                final icon = exploreIcons[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: GestureDetector(
                    onTapDown: (d) {
                      selectedExploreIconSegments = widget.image.segmentations
                          .where((element) => element.exploreId == icon.id)
                          .toList();
                      selectedIconId = icon.id;
                      setState(() {});
                    },
                    onTapUp: (d) {
                      selectedExploreIconSegments = [];
                      selectedIconId = null;
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: (selectedIconId != null &&
                                selectedIconId == icon.id)
                            ? Border.all(
                                color: Colors.green,
                                width: 3,
                              )
                            : null,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: icon.sourceUrl,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        ...widget.image.captions.map((caption) {
          return Text(caption);
        }).toList(),
      ],
    );
  }
}
