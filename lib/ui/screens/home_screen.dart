import '/ui/presenters/home_screen_presenter.dart';
import '/ui/widgets/parent_item.dart';
import '/ui/widgets/selected_icons.dart';
import '/ui/widgets/suggestable_search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const route = '/home';

  @override
  Widget build(BuildContext context) {
    final HomeScreenPresenter presenter = Get.put(HomeScreenPresenter());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coco Explorer'),
        centerTitle: true,
      ),
      body: Obx(
        () {
          return presenter.shouldWaitStates
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : presenter.canShowSearch
                  ? ListView(
                      children: [
                        const SuggestableSearchField(),
                        const SelectedIcons(),
                        ElevatedButton(
                          onPressed: presenter.search,
                          child: const Text('Search'),
                        ),
                        ...presenter.exploreIconParents.map((parent) {
                          return ParentItem(parent: parent);
                        }).toList(),
                      ],
                    )
                  : const Center(
                      child: Text('Error'),
                    );
        },
      ),
    );
  }
}
