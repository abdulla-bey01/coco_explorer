import 'dart:async';
import '/app/commands/i_command.dart';
import '/app/helpers/enums/ui_side_state.dart';
import '/app/interactors/explore_icon_interactor.dart';
import '/ui/presenters/home_screen_presenter.dart';

class GetExploreIconsVsParentsCommand extends ICommand {
  @override
  FutureOr<bool> canExecute(Map? params) {
    return true;
  }

  @override
  void execute(Map? params) async {
    final HomeScreenPresenter homeScreenPresenter = params?['p'];
    try {
      homeScreenPresenter.getExploreIconsVsParentsState_ = UiSideState.waiting;
      final ExploreIconInteractor exploreIconInteractor =
          ExploreIconInteractor();
      final parents = await exploreIconInteractor.getParents();
      homeScreenPresenter.exploreIconParents.clear();
      homeScreenPresenter.exploreIconParents.addAll(parents);
      homeScreenPresenter.getExploreIconsVsParentsState_ =
          UiSideState.successfull;
    } catch (e) {
      homeScreenPresenter.getExploreIconsVsParentsState_ =
          UiSideState.unsuccessfull;
    }
  }
}
