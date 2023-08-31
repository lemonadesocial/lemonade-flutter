import 'package:app/core/data/post/dtos/newsfeed_dtos.dart';
import 'package:app/core/data/post/dtos/post_dtos.dart';
import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/post/post_enums.dart';
import 'package:app/core/domain/user/entities/user.dart';

class Post {
  final String id;
  final String user;
  final PostVisibility visibility;
  final DateTime? createdAt;
  final User? userExpanded;
  final String? text;
  final String? refId;
  final PostRefType? refType;
  final Event? refEvent;
  final DbFile? refFile;
  final bool? hasReaction;
  final int? reactions;
  final int? comments;
  final bool? published;

  const Post({
    required this.id,
    required this.user,
    required this.visibility,
    this.createdAt,
    this.userExpanded,
    this.text,
    this.refId,
    this.refType,
    this.refEvent,
    this.refFile,
    this.hasReaction,
    this.reactions,
    this.comments,
    this.published,
  });

  factory Post.fromDto(PostDto dto) => Post(
        id: dto.id,
        user: dto.user,
        visibility: dto.visibility,
        createdAt: dto.createdAt,
        userExpanded:
            dto.userExpanded != null ? User.fromDto(dto.userExpanded!) : null,
        text: dto.text,
        refId: dto.refId,
        refType: dto.refType,
        refEvent: dto.refEvent != null ? Event.fromDto(dto.refEvent!) : null,
        refFile: dto.refFile != null ? DbFile.fromDto(dto.refFile!) : null,
        hasReaction: dto.hasReaction,
        reactions: dto.reactions,
        comments: dto.comments,
        published: dto.published,
      );
}

class Newsfeed {
  final int? offset;
  final List<Post>? posts;

  Newsfeed({this.offset, this.posts});

  static Newsfeed fromDto(NewsfeedDto dto) {
    return Newsfeed(
        offset: dto.offset,
        posts: List.from(dto.posts ?? [])
            .map((item) => Post.fromDto(item))
            .toList());
  }
}
