import '/ui/presenters/home_screen_presenter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectedIcons extends StatelessWidget {
  const SelectedIcons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeScreenPresenter presenter = Get.find();

    return Obx(() {
      return Wrap(
        children: presenter.getSelectedIcons().map((icon) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              child: Chip(label: Text(icon.title)),
              onTap: () => presenter.selectIcon(icon: icon),
            ),
          );
        }).toList(),
      );
    });
  }
}
