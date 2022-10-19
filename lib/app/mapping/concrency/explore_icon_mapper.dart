import '/app/mapping/abstraction/mapper.dart';
import '/app/models/explore_icon_model.dart';
import '/data/dtos/explore_icon_dto.dart';

//ExploreIconMapper map data between icon dto(data source) and icon model(app)
class ExploreIconMapper implements Mapper<ExploreIconModel, ExploreIconDto> {
  //convert model to dto
  @override
  ExploreIconDto toDto(ExploreIconModel m) {
    return ExploreIconDto(id: m.id, name: m.title, parent: '');
  }

  //convert dto to model
  @override
  ExploreIconModel toModel(ExploreIconDto d) {
    return ExploreIconModel(id: d.id, title: d.name);
  }
}
