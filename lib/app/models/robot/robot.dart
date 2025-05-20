import 'package:json_annotation/json_annotation.dart';

part 'robot.g.dart';

// --------=== Robot ===---------
@JsonSerializable()
class Robot {
  final String id;
  final String name;
  final String token;

  Robot(
    this.id,
    this.name,
    this.token,
  );

  factory Robot.fromJson(Map<String, dynamic> json) =>
      _$RobotFromJson(json);

  Map<String, dynamic> toJson() => _$RobotToJson(this);
}


// --------------------------------------- admin create robot
class CreateRobot {
  final String name;

  CreateRobot(
    this.name,
  );
}


@JsonSerializable()
class GetRobotsResponse {
  final List<Robot> items;
  final int limit;
  final int offset;
  final int total;

  GetRobotsResponse(this.items, this.limit, this.offset, this.total);

  factory GetRobotsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetRobotsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetRobotsResponseToJson(this);
}
