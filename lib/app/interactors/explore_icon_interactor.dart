import '/app/mapping/concrency/explore_icon_mapper.dart';
import '/app/models/explore_icon_model.dart';
import '/app/models/explore_icon_parent_model.dart';
import '/data/abstraction/i_explore_icon_manager.dart';
import '/data/dtos/explore_icon_dto.dart';
import 'package:get/get.dart';

//using to work with ExploreIcon data (bussines side)
class ExploreIconInteractor {
  //get all explore icons
  Future<List<ExploreIconModel>> getAll() async {
    //get manager of explore icons from Get di container, it can be local or remote source
    final exploreIconManager = Get.find<IExploreIconManager>();
    //get explore icon dtos
    final dtos = await exploreIconManager.getAll();
    //create mapper to convert data transfer object dto to application models
    final mapper = ExploreIconMapper();
    //map dtos to app models
    final icons = dtos.map((e) => mapper.toModel(e)).toList();
    return icons;
  }

  //get parents of icons with themselves
  Future<List<ExploreIconParentModel>> getParents() async {
    //get manager of explore icons from Get di container, it can be local or remote source
    final exploreIconManager = Get.find<IExploreIconManager>();
    //get all icons
    final dtos = await exploreIconManager.getAll() as List<ExploreIconDto>;
    //create parent list to seperate icons by parents
    List<ExploreIconParentModel> parents = [];
    //create mapper to convert data transfer object dto to application models
    final mapper = ExploreIconMapper();
    //
    for (var dto in dtos) {
      //check it there is parent in parent list
      final parentFromList =
          parents.firstWhereOrNull((element) => element.title == dto.parent);
      //if there is not parent with this title, create it and add icons as its children
      if (parentFromList == null) {
        ExploreIconParentModel parent = ExploreIconParentModel(
          title: dto.parent,
          icons: [
            mapper.toModel(dto),
          ],
        );
        //add parent to parent list
        parents.add(parent);
      } else {
        //if parent is existed in parent list, add icon to the parent's children
        parentFromList.icons.add(mapper.toModel(dto));
      }
    }
    return parents;
  }
}
