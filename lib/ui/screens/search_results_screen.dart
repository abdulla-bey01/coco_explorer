import '/app/helpers/enums/ui_side_state.dart';
import '/ui/presenters/search_results_screen_presenter.dart';
import '/ui/widgets/search_result_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({super.key, required this.presenter});
  static const route = '/searcj-results';
  final SearchResultsScreenPresenter presenter;

  @override
  Widget build(BuildContext context) {
    if (presenter.requestState == UiSideState.unsuccessfull) {
      Future.delayed(Duration.zero).then((value) {
        Get.showSnackbar(const GetSnackBar(
          titleText: Text('Images can not be loaded'),
        ));
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
      ),
      body: Obx(() {
        return Stack(
          children: [
            SafeArea(
              child: LayoutBuilder(
                builder: (context, c) {
                  return SizedBox(
                    height: c.maxHeight,
                    width: c.maxWidth,
                    child: presenter.images.isEmpty &&
                            presenter.requestState != UiSideState.waiting
                        ? const Center(
                            child: Text('no data found'),
                          )
                        : ListView.builder(
                            controller: presenter.scrollController,
                            itemCount: presenter.images.length,
                            itemBuilder: (ctx, index) {
                              final image = presenter.images[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 32.0),
                                child: SearchResultItem(
                                  image: image,
                                  getImageAndSize: presenter.getImageAndSize,
                                ),
                              );
                            },
                          ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: presenter.requestState == UiSideState.waiting
                  ? const CircularProgressIndicator()
                  : const SizedBox.shrink(),
            ),
          ],
        );
      }),
    );
  }
}
