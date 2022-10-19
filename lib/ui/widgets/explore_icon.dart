import 'package:cached_network_image/cached_network_image.dart';
import '/app/models/explore_icon_model.dart';
import '/ui/presenters/home_screen_presenter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreIcon extends StatelessWidget {
  const ExploreIcon({
    Key? key,
    required this.icon,
    required this.parent,
  }) : super(key: key);

  final ExploreIconModel icon;
  final String parent;

  @override
  Widget build(BuildContext context) {
    final HomeScreenPresenter presenter = Get.find();

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: icon.isSelected ? Colors.green : Colors.transparent,
          width: 3,
        ),
      ),
      child: InkWell(
        onTap: () => presenter.selectIcon(
          icon: icon,
        ),
        child: CachedNetworkImage(
          imageUrl: icon.sourceUrl,
        ),
      ),
    );
  }
}
