import '/app/models/explore_icon_model.dart';
import '/ui/presenters/home_screen_presenter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchfield/searchfield.dart';

class SuggestableSearchField extends StatefulWidget {
  const SuggestableSearchField({
    Key? key,
  }) : super(key: key);

  @override
  State<SuggestableSearchField> createState() => _SuggestableSearchFieldState();
}

class _SuggestableSearchFieldState extends State<SuggestableSearchField> {
  final FocusNode keyboardFocusNode = FocusNode();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final HomeScreenPresenter presenter = Get.find();
    return Obx(() {
      return SearchField<ExploreIconModel>(
        focusNode: keyboardFocusNode,
        controller: searchController,
        hint: 'search...',
        suggestions: presenter
            .getUnselectedIcons()
            .map(
              (icon) => SearchFieldListItem<ExploreIconModel>(
                icon.title,
                item: icon,
              ),
            )
            .toList(),
        onSuggestionTap: (v) {
          presenter.selectIcon(icon: v.item!);
          searchController.clear();
          keyboardFocusNode.unfocus();
        },
      );
    });
  }
}
