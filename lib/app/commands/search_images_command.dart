import 'dart:async';
import '/app/commands/i_command.dart';
import '/app/helpers/enums/ui_side_state.dart';
import '/app/interactors/search_interactor.dart';
import '/ui/presenters/search_results_screen_presenter.dart';

class SearchImagesCommand extends ICommand {
  @override
  FutureOr<bool> canExecute(Map? params) {
    return true;
  }

  @override
  void execute(Map? params) async {
    final SearchInteractor searchInteractor = SearchInteractor();
    final SearchResultsScreenPresenter searchResultsScreenPresenter =
        params?['p'];
    try {
      searchResultsScreenPresenter.requestState_ = UiSideState.waiting;
      final exploreIconIds = searchResultsScreenPresenter.searchIcons
          .map<int>((e) => e.id)
          .toList();
      final loadMore = params?['lm'];
      final images = await searchInteractor.searchWithQueryType(exploreIconIds,
          loadMore: loadMore);
      if (!loadMore) {
        searchResultsScreenPresenter.images.clear();
      }
      searchResultsScreenPresenter.images.addAll(images);
      searchResultsScreenPresenter.requestState_ = UiSideState.successfull;
    } catch (e) {
      searchResultsScreenPresenter.requestState_ = UiSideState.unsuccessfull;
    }
  }
}
