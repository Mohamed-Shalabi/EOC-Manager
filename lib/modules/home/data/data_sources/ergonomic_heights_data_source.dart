import '../models/ergonomic_height_model.dart';

abstract class ErgonomicHeightsDataSource {
  static int get minUserHeight => heights.first.userHeightInCm;

  static int get maxUserHeight => heights.last.userHeightInCm;

  static int get _minChairHeight => heights.first.chairHeightInCm;

  static int get _maxChairHeight => heights.last.chairHeightInCm;

  static bool isInsideRange(int chairHeight) {
    return chairHeight >= _minChairHeight && chairHeight <= _maxChairHeight;
  }

  static const List<ErgonomicHeightModel> heights = [
    ErgonomicHeightModel(
      userHeightInCm: 150,
      chairHeightInCm: 35,
      monitorHeightInCm: 104,
    ),
    ErgonomicHeightModel(
      userHeightInCm: 155,
      chairHeightInCm: 37,
      monitorHeightInCm: 107,
    ),
    ErgonomicHeightModel(
      userHeightInCm: 160,
      chairHeightInCm: 38,
      monitorHeightInCm: 110,
    ),
    ErgonomicHeightModel(
      userHeightInCm: 165,
      chairHeightInCm: 40,
      monitorHeightInCm: 115,
    ),
    ErgonomicHeightModel(
      userHeightInCm: 170,
      chairHeightInCm: 41,
      monitorHeightInCm: 118,
    ),
    ErgonomicHeightModel(
      userHeightInCm: 175,
      chairHeightInCm: 43,
      monitorHeightInCm: 122,
    ),
    ErgonomicHeightModel(
      userHeightInCm: 180,
      chairHeightInCm: 44,
      monitorHeightInCm: 125,
    ),
    ErgonomicHeightModel(
      userHeightInCm: 185,
      chairHeightInCm: 46,
      monitorHeightInCm: 129,
    ),
    ErgonomicHeightModel(
      userHeightInCm: 190,
      chairHeightInCm: 48,
      monitorHeightInCm: 132,
    ),
    ErgonomicHeightModel(
      userHeightInCm: 195,
      chairHeightInCm: 49,
      monitorHeightInCm: 138,
    ),
  ];
}
