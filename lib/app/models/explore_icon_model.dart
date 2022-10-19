import '/app/helpers/mixins/selectable.dart';
import '/app/models/base_model.dart';

//Selectable add isSelected property to this class
class ExploreIconModel extends BaseModel with Selectable {
  final String title;
  String get sourceUrl => 'https://cocodataset.org/images/cocoicons/$id.jpg';

  ExploreIconModel({
    dynamic id,
    required this.title,
  }) : super(id: id);
}
