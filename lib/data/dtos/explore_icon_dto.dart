import 'base_dto.dart';

class ExploreIconDto extends BaseDto {
  final String name;
  final String parent;
  ExploreIconDto({dynamic id, required this.name, required this.parent})
      : super(id: id);
}
