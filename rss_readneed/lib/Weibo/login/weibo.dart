import 'dart:core';

import 'package:json_annotation/json_annotation.dart';
part 'weibo.g.dart';

@JsonSerializable()
class Weibo {
  num id;
  String idstr;
  String screen_name;
  String name;
  String province;
  String city;
  String location;
  String description;
  String url;
  String profile_image_url;
  String profile_url;
  String domain;
  String weihao;
  String gender;
  num followers_count;
  num friends_count;
  num pagefriends_count;
  num statuses_count;
  num video_status_count;
  num video_play_count;
  num favourites_count;
  String created_at;
  bool following;
  bool allow_all_act_msg;
  bool geo_enabled;
  bool verified;
  num verified_type;
  String remark;
  String email;
  InsecurityEntity insecurity;
  StatusEntity status;
  num ptype;
  bool allow_all_comment;
  String avatar_large;
  String avatar_hd;
  String verified_reason;
  String verified_trade;
  String verified_reason_url;
  String verified_source;
  String verified_source_url;
  bool follow_me;
  bool like;
  bool like_me;
  num online_status;
  num bi_followers_count;
  String lang;
  num star;
  num mbtype;
  num mbrank;
  num block_word;
  num block_app;
  num credit_score;
  num user_ability;
  num urank;
  num story_read_state;
  num vclub_member;
  num is_teenager;
  num is_guardian;
  num is_teenager_list;
  num pc_new;
  bool special_follow;
  num planet_video;
  Weibo({
    this.id,
    this.idstr,
    this.screen_name,
    this.name,
    this.province,
    this.city,
    this.location,
    this.description,
    this.url,
    this.profile_image_url,
    this.profile_url,
    this.domain,
    this.weihao,
    this.gender,
    this.followers_count,
    this.friends_count,
    this.pagefriends_count,
    this.statuses_count,
    this.video_status_count,
    this.video_play_count,
    this.favourites_count,
    this.created_at,
    this.following,
    this.allow_all_act_msg,
    this.geo_enabled,
    this.verified,
    this.verified_type,
    this.remark,
    this.email,
    this.insecurity,
    this.status,
    this.ptype,
    this.allow_all_comment,
    this.avatar_large,
    this.avatar_hd,
    this.verified_reason,
    this.verified_trade,
    this.verified_reason_url,
    this.verified_source,
    this.verified_source_url,
    this.follow_me,
    this.like,
    this.like_me,
    this.online_status,
    this.bi_followers_count,
    this.lang,
    this.star,
    this.mbtype,
    this.mbrank,
    this.block_word,
    this.block_app,
    this.credit_score,
    this.user_ability,
    this.urank,
    this.story_read_state,
    this.vclub_member,
    this.is_teenager,
    this.is_guardian,
    this.is_teenager_list,
    this.pc_new,
    this.special_follow,
    this.planet_video
  });

  factory Weibo.fromJson(Map<String, dynamic> json) => _$WeiboFromJson(json);
  Map<String, dynamic> toJson() => _$WeiboToJson(this);

}

@JsonSerializable()
class InsecurityEntity {
  bool sexual_content;
  InsecurityEntity({
    this.sexual_content
  });

  factory InsecurityEntity.fromJson(Map<String, dynamic> json) => _$InsecurityEntityFromJson(json);
  Map<String, dynamic> toJson() => _$InsecurityEntityToJson(this);
}

@JsonSerializable()
class StatusEntity {
  VisibleEntity visible;
  String created_at;
  num id;
  String idstr;
  String mid;
  bool can_edit;
  num show_additional_indication;
  String text;
  num textLength;
  num source_allowclick;
  num source_type;
  String source;
  bool favorited;
  bool truncated;
  String in_reply_to_status_id;
  String in_reply_to_user_id;
  String in_reply_to_screen_name;
  dynamic geo;
  bool is_paid;
  num mblog_vip_type;
  List<AnnotationsEntity> annotations;
  num reposts_count;
  num comments_count;
  num attitudes_count;
  num pending_approval_count;
  bool isLongText;
  num reward_exhibition_type;
  num hide_flag;
  num mlevel;
  num biz_feature;
  num hasActionTypeCard;
  num mblogtype;
  String rid;
  num userType;
  num more_info_type;
  num positive_recom_flag;
  num content_auth;
  String gif_ids;
  num is_show_bulletin;
  Comment_manage_infoEntity comment_manage_info;
  num pic_num;
  StatusEntity({
    this.visible,
    this.created_at,
    this.id,
    this.idstr,
    this.mid,
    this.can_edit,
    this.show_additional_indication,
    this.text,
    this.textLength,
    this.source_allowclick,
    this.source_type,
    this.source,
    this.favorited,
    this.truncated,
    this.in_reply_to_status_id,
    this.in_reply_to_user_id,
    this.in_reply_to_screen_name,
    this.geo,
    this.is_paid,
    this.mblog_vip_type,
    this.annotations,
    this.reposts_count,
    this.comments_count,
    this.attitudes_count,
    this.pending_approval_count,
    this.isLongText,
    this.reward_exhibition_type,
    this.hide_flag,
    this.mlevel,
    this.biz_feature,
    this.hasActionTypeCard,
    this.mblogtype,
    this.rid,
    this.userType,
    this.more_info_type,
    this.positive_recom_flag,
    this.content_auth,
    this.gif_ids,
    this.is_show_bulletin,
    this.comment_manage_info,
    this.pic_num
  });

  factory StatusEntity.fromJson(Map<String, dynamic> json) => _$StatusEntityFromJson(json);
  Map<String, dynamic> toJson() => _$StatusEntityToJson(this);
}

@JsonSerializable()
class VisibleEntity {
  num type;
  num list_id;
  VisibleEntity({
    this.type,
    this.list_id
  });

  factory VisibleEntity.fromJson(Map<String, dynamic> json) => _$VisibleEntityFromJson(json);
  Map<String, dynamic> toJson() => _$VisibleEntityToJson(this);
}

@JsonSerializable()
class AnnotationsEntity {
  num shooting;
  String client_mblogid;
  bool mapi_request;
  AnnotationsEntity({
    this.shooting,
    this.client_mblogid,
    this.mapi_request
  });

  factory AnnotationsEntity.fromJson(Map<String, dynamic> json) => _$AnnotationsEntityFromJson(json);
  Map<String, dynamic> toJson() => _$AnnotationsEntityToJson(this);
}

@JsonSerializable()
class Comment_manage_infoEntity {
  num comment_permission_type;
  num approval_comment_type;
  Comment_manage_infoEntity({
    this.comment_permission_type,
    this.approval_comment_type
  });

  factory Comment_manage_infoEntity.fromJson(Map<String, dynamic> json) => _$Comment_manage_infoEntityFromJson(json);
  Map<String, dynamic> toJson() => _$Comment_manage_infoEntityToJson(this);
}