import 'package:freezed_annotation/freezed_annotation.dart';

part 'cube_track.freezed.dart';
part 'cube_track.g.dart';

@freezed
class CubeTrackMember with _$CubeTrackMember {
  factory CubeTrackMember({
    @JsonKey(name: "Tracks.date") DateTime? date,
    @JsonKey(name: "Tracks.countDistinctUsers") String? countDistinctUsers,
    @JsonKey(name: "Tracks.count") String? count,
  }) = _CubeTrackMember;

  factory CubeTrackMember.fromJson(Map<String, dynamic> json) =>
      _$CubeTrackMemberFromJson(json);
}
