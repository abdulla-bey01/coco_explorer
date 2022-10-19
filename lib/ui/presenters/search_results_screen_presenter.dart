import '/ui/helpers/mixins/image_size_calculator.dart';
import '/app/commands/i_command.dart';
import '/app/commands/search_images_command.dart';
import '/app/helpers/enums/ui_side_state.dart';
import '/app/models/explore_icon_model.dart';
import '/app/models/image_model.dart';
import '/ui/presenters/abstraction/initializable.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

//presenter of search screen, accepting selected icons for search
class SearchResultsScreenPresenter extends RxController
    with ImageSizeCalculator
    implements Initializable {
  SearchResultsScreenPresenter(this.searchIcons) {
    initialize();
  }

  //selected icons
  final List<ExploreIconModel> searchIcons;
  //command of search
  late final ICommand searchCommand;
  //search results
  late final RxList<ImageModel> _resultImages;
  List<ImageModel> get images => _resultImages;

  //controller of result listview
  late final ScrollController _scrollController;
  ScrollController get scrollController => _scrollController;
  //search request state
  late Rx<UiSideState> _requestState;
  set requestState_(v) {
    _requestState.value = v;
  }

  UiSideState get requestState => _requestState.value;

  //method to laod more search result based on same selected icons
  void _loadMoreImagesOnSameSearch() {
    searchCommand.doExecute({'p': this, 'lm': true});
  }

  @override
  void initialize([args]) {
    _resultImages = <ImageModel>[].obs;
    _requestState = UiSideState.default_.obs;
    searchCommand = SearchImagesCommand();
    searchCommand.doExecute({'p': this, 'lm': false});
    _scrollController = ScrollController();
    //load more result if user is arrived to end of listview
    _scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        _loadMoreImagesOnSameSearch();
      }
    });
  }
}
