import 'dart:core';

import 'package:json_annotation/json_annotation.dart';
part 'model.g.dart';

@JsonSerializable()
class Model {
  List<StatusesEntity> statuses;
  bool hasvisible;
  num previous_cursor;
  num next_cursor;
  String previous_cursor_str;
  String next_cursor_str;
  num total_number;
  num interval;
  num uve_blank;
  num since_id;
  String since_id_str;
  num max_id;
  String max_id_str;
  num has_unread;
  Model({
    this.statuses,
    this.hasvisible,
    this.previous_cursor,
    this.next_cursor,
    this.previous_cursor_str,
    this.next_cursor_str,
    this.total_number,
    this.interval,
    this.uve_blank,
    this.since_id,
    this.since_id_str,
    this.max_id,
    this.max_id_str,
    this.has_unread
  });

  factory Model.fromJson(Map<String, dynamic> json) => _$ModelFromJson(json);
  Map<String, dynamic> toJson() => _$ModelToJson(this);
}
//内容模型
@JsonSerializable()
class StatusesEntity {
  VisibleEntity visible;
  String created_at;//微博创建时间
  num id;//微博ID
  String idstr;//字符串型的微博ID
  String mid;
  bool can_edit;
  num show_additional_indication;
  String text;//微博信息内容
  num textLength;
  num source_allowclick;
  num source_type;
  String source;//微博来源
  bool favorited;//是否已收藏，true：是，false：否
  bool truncated;//是否被截断，true：是，false：否
  String in_reply_to_status_id;//回复ID
  String in_reply_to_user_id;//回复人UID
  String in_reply_to_screen_name;//回复人昵称
  List<Pic_urlsEntity> pic_urls;
  String thumbnail_pic;//缩略图片地址
  String bmiddle_pic;//中等尺寸图片地址
  String original_pic;//原始图片地址
  dynamic geo;//地理信息字段
  bool is_paid;
  num mblog_vip_type;
  UserEntity user;//微博作者的用户信息字段
  StatusesEntity retweeted_status;//转发的内容
  String picStatus;
  num reposts_count;//转发数
  num comments_count;//评论数
  num attitudes_count;//表态数
  num pending_approval_count;
  bool isLongText;
  num reward_exhibition_type;
  String reward_scheme;
  num hide_flag;
  num mlevel;
  num biz_feature;
  num hasActionTypeCard;
  num mblogtype;
  String rid;
  num userType;
  num more_info_type;
  String cardid;
  Number_display_strategyEntity number_display_strategy;
  num positive_recom_flag;
  bool enable_comment_guide;
  num content_auth;
  String gif_ids;
  num is_show_bulletin;
  Comment_manage_infoEntity comment_manage_info;
  num pic_num;
  Alchemy_paramsEntity alchemy_params;
  StatusesEntity({
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
    this.pic_urls,
    this.thumbnail_pic,
    this.bmiddle_pic,
    this.original_pic,
    this.geo,
    this.is_paid,
    this.mblog_vip_type,
    this.user,
    this.retweeted_status,
    this.picStatus,
    this.reposts_count,
    this.comments_count,
    this.attitudes_count,
    this.pending_approval_count,
    this.isLongText,
    this.reward_exhibition_type,
    this.reward_scheme,
    this.hide_flag,
    this.mlevel,
    this.biz_feature,
    this.hasActionTypeCard,
    this.mblogtype,
    this.rid,
    this.userType,
    this.more_info_type,
    this.cardid,
    this.number_display_strategy,
    this.positive_recom_flag,
    this.enable_comment_guide,
    this.content_auth,
    this.gif_ids,
    this.is_show_bulletin,
    this.comment_manage_info,
    this.pic_num,
    this.alchemy_params
  });

  factory StatusesEntity.fromJson(Map<String, dynamic> json) => _$StatusesEntityFromJson(json);
  Map<String, dynamic> toJson() => _$StatusesEntityToJson(this);
}

@JsonSerializable()
class VisibleEntity {
  num type;//微博的可见性及指定可见分组信息。该object中type取值，0：普通微博，1：私密微博，3：指定分组微博，4：密友微博；list_id为分组的组号
  num list_id;
  VisibleEntity({
    this.type,
    this.list_id
  });

  factory VisibleEntity.fromJson(Map<String, dynamic> json) => _$VisibleEntityFromJson(json);
  Map<String, dynamic> toJson() => _$VisibleEntityToJson(this);
}

@JsonSerializable()
class Pic_urlsEntity {
  String thumbnail_pic;
  Pic_urlsEntity({
    this.thumbnail_pic
  });

  factory Pic_urlsEntity.fromJson(Map<String, dynamic> json) => _$Pic_urlsEntityFromJson(json);
  Map<String, dynamic> toJson() => _$Pic_urlsEntityToJson(this);
}
//用户模型
@JsonSerializable()
class UserEntity {
  num id;
  String idstr;
  String screen_name;//用户昵称
  String name;
  String province;
  String city;
  String location;
  String description;
  String url;
  String profile_image_url;//用户头像地址（中图），50×50像素
  String profile_url;//用户的微博统一URL地址
  String domain;
  String weihao;
  String gender;//性别，m：男、f：女、n：未知
  num followers_count;//粉丝数
  num friends_count;//关注数
  num pagefriends_count;
  num statuses_count;//微博数
  num video_status_count;
  num video_play_count;
  num favourites_count;//收藏数
  String created_at;//用户创建（注册）时间
  bool following;
  bool allow_all_act_msg;
  bool geo_enabled;
  bool verified;//是否是微博认证用户，即加V用户，true：是，false：否
  num verified_type;
  String remark;
  String email;
  InsecurityEntity insecurity;
  StatusesEntity status;//用户的最近一条微博信息字段
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
  UserEntity({
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

  factory UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);
  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
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
class Number_display_strategyEntity {
  num apply_scenario_flag;
  num display_text_min_number;
  String display_text;
  Number_display_strategyEntity({
    this.apply_scenario_flag,
    this.display_text_min_number,
    this.display_text
  });

  factory Number_display_strategyEntity.fromJson(Map<String, dynamic> json) => _$Number_display_strategyEntityFromJson(json);
  Map<String, dynamic> toJson() => _$Number_display_strategyEntityToJson(this);
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

@JsonSerializable()
class Alchemy_paramsEntity {
  num comment_guide_type;
  Alchemy_paramsEntity({
    this.comment_guide_type
  });

  factory Alchemy_paramsEntity.fromJson(Map<String, dynamic> json) => _$Alchemy_paramsEntityFromJson(json);
  Map<String, dynamic> toJson() => _$Alchemy_paramsEntityToJson(this);
}