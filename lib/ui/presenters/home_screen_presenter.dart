import '/app/commands/get_explore_icon_parents_command.dart';
import '/app/commands/i_command.dart';
import '/app/helpers/enums/ui_side_state.dart';
import '/app/models/explore_icon_model.dart';
import '/app/models/explore_icon_parent_model.dart';
import '/ui/presenters/abstraction/initializable.dart';
import '/ui/presenters/search_results_screen_presenter.dart';
import '/ui/screens/search_results_screen.dart';
import 'package:get/get.dart';

//presenter of home screen notifying ui when something is changed based on RxController
class HomeScreenPresenter extends RxController implements Initializable {
  HomeScreenPresenter() {
    initialize();
  }

  //return selected explore icon to show which icons is selected to search
  List<ExploreIconModel> getSelectedIcons() {
    List<ExploreIconModel> icons = [];
    for (var parent in _exploreIconParents) {
      final selectedIcons =
          parent.icons.where((element) => element.isSelected).toList();
      icons.addAll(selectedIcons);
    }
    return icons;
  }

  //return unselected explore icons to change source of search suggestions, if there is already selected icon, the icon will not be shown in suggestion
  List<ExploreIconModel> getUnselectedIcons() {
    List<ExploreIconModel> icons = [];
    for (var parent in _exploreIconParents) {
      final selectedIcons =
          parent.icons.where((element) => !element.isSelected).toList();
      icons.addAll(selectedIcons);
    }
    return icons;
  }

  //parent of explore icons, private because we should not change its reference to keep some speed, memory resources
  late final RxList<ExploreIconParentModel> _exploreIconParents;
  //getter of parent
  List<ExploreIconParentModel> get exploreIconParents => _exploreIconParents;

  //command to get explore icons and their parents
  late final ICommand getExploreIconVsParentsCommand;
  //keep get state of explore icons and parents for ui side
  late Rx<UiSideState> _getExploreIconsVsParentsState;
  UiSideState get getExploreIconsVsParentsState =>
      _getExploreIconsVsParentsState.value;
  set getExploreIconsVsParentsState_(UiSideState v) {
    _getExploreIconsVsParentsState.value = v;
    _getExploreIconsVsParentsState.refresh();
  }

  //can seperate bool like this if the ui side depends on property state more than one
  bool get canShowSearch =>
      getExploreIconsVsParentsState == UiSideState.successfull;

  bool get shouldWaitStates =>
      getExploreIconsVsParentsState == UiSideState.waiting;

  //select icon based on parent and icon id
  void _selectIconInsideParent({required String parent, required dynamic id}) {
    final parentObj =
        _exploreIconParents.firstWhere((element) => element.title == parent);
    final icon = parentObj.icons.firstWhere((element) => element.id == id);
    icon.isSelected = !icon.isSelected;
    _exploreIconParents.refresh();
  }

  //find parent based on icon
  void selectIcon({required ExploreIconModel icon}) {
    final parent = exploreIconParents.firstWhere(
        (element) => element.icons.any((element) => element.id == icon.id));
    _selectIconInsideParent(parent: parent.title, id: icon.id);
  }

  //this mehtod creates search result screen presenter, pass it to screen object, and push the screen to navigator stack
  void search() {
    SearchResultsScreenPresenter searchResultsScreenPresenter =
        SearchResultsScreenPresenter(getSelectedIcons());
    Get.to(() => SearchResultsScreen(presenter: searchResultsScreenPresenter));
  }

  //initalize data for this presenter
  @override
  void initialize([args]) {
    _exploreIconParents = <ExploreIconParentModel>[].obs;
    getExploreIconVsParentsCommand = GetExploreIconsVsParentsCommand();
    _getExploreIconsVsParentsState = UiSideState.default_.obs;
    getExploreIconVsParentsCommand.doExecute({'p': this});
  }
}
