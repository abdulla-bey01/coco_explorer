import '/data/dtos/base_dto.dart';

class ImageListDto extends BaseDto {
  final List details;
  final List captions;
  final List segmentations;

  ImageListDto({
    required this.details,
    required this.captions,
    required this.segmentations,
  });
}
