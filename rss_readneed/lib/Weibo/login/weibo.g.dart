// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weibo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weibo _$WeiboFromJson(Map<String, dynamic> json) {
  return Weibo(
    id: json['id'] as num,
    idstr: json['idstr'] as String,
    screen_name: json['screen_name'] as String,
    name: json['name'] as String,
    province: json['province'] as String,
    city: json['city'] as String,
    location: json['location'] as String,
    description: json['description'] as String,
    url: json['url'] as String,
    profile_image_url: json['profile_image_url'] as String,
    profile_url: json['profile_url'] as String,
    domain: json['domain'] as String,
    weihao: json['weihao'] as String,
    gender: json['gender'] as String,
    followers_count: json['followers_count'] as num,
    friends_count: json['friends_count'] as num,
    pagefriends_count: json['pagefriends_count'] as num,
    statuses_count: json['statuses_count'] as num,
    video_status_count: json['video_status_count'] as num,
    video_play_count: json['video_play_count'] as num,
    favourites_count: json['favourites_count'] as num,
    created_at: json['created_at'] as String,
    following: json['following'] as bool,
    allow_all_act_msg: json['allow_all_act_msg'] as bool,
    geo_enabled: json['geo_enabled'] as bool,
    verified: json['verified'] as bool,
    verified_type: json['verified_type'] as num,
    remark: json['remark'] as String,
    email: json['email'] as String,
    insecurity: json['insecurity'] == null
        ? null
        : InsecurityEntity.fromJson(json['insecurity'] as Map<String, dynamic>),
    status: json['status'] == null
        ? null
        : StatusEntity.fromJson(json['status'] as Map<String, dynamic>),
    ptype: json['ptype'] as num,
    allow_all_comment: json['allow_all_comment'] as bool,
    avatar_large: json['avatar_large'] as String,
    avatar_hd: json['avatar_hd'] as String,
    verified_reason: json['verified_reason'] as String,
    verified_trade: json['verified_trade'] as String,
    verified_reason_url: json['verified_reason_url'] as String,
    verified_source: json['verified_source'] as String,
    verified_source_url: json['verified_source_url'] as String,
    follow_me: json['follow_me'] as bool,
    like: json['like'] as bool,
    like_me: json['like_me'] as bool,
    online_status: json['online_status'] as num,
    bi_followers_count: json['bi_followers_count'] as num,
    lang: json['lang'] as String,
    star: json['star'] as num,
    mbtype: json['mbtype'] as num,
    mbrank: json['mbrank'] as num,
    block_word: json['block_word'] as num,
    block_app: json['block_app'] as num,
    credit_score: json['credit_score'] as num,
    user_ability: json['user_ability'] as num,
    urank: json['urank'] as num,
    story_read_state: json['story_read_state'] as num,
    vclub_member: json['vclub_member'] as num,
    is_teenager: json['is_teenager'] as num,
    is_guardian: json['is_guardian'] as num,
    is_teenager_list: json['is_teenager_list'] as num,
    pc_new: json['pc_new'] as num,
    special_follow: json['special_follow'] as bool,
    planet_video: json['planet_video'] as num,
  );
}

Map<String, dynamic> _$WeiboToJson(Weibo instance) => <String, dynamic>{
      'id': instance.id,
      'idstr': instance.idstr,
      'screen_name': instance.screen_name,
      'name': instance.name,
      'province': instance.province,
      'city': instance.city,
      'location': instance.location,
      'description': instance.description,
      'url': instance.url,
      'profile_image_url': instance.profile_image_url,
      'profile_url': instance.profile_url,
      'domain': instance.domain,
      'weihao': instance.weihao,
      'gender': instance.gender,
      'followers_count': instance.followers_count,
      'friends_count': instance.friends_count,
      'pagefriends_count': instance.pagefriends_count,
      'statuses_count': instance.statuses_count,
      'video_status_count': instance.video_status_count,
      'video_play_count': instance.video_play_count,
      'favourites_count': instance.favourites_count,
      'created_at': instance.created_at,
      'following': instance.following,
      'allow_all_act_msg': instance.allow_all_act_msg,
      'geo_enabled': instance.geo_enabled,
      'verified': instance.verified,
      'verified_type': instance.verified_type,
      'remark': instance.remark,
      'email': instance.email,
      'insecurity': instance.insecurity,
      'status': instance.status,
      'ptype': instance.ptype,
      'allow_all_comment': instance.allow_all_comment,
      'avatar_large': instance.avatar_large,
      'avatar_hd': instance.avatar_hd,
      'verified_reason': instance.verified_reason,
      'verified_trade': instance.verified_trade,
      'verified_reason_url': instance.verified_reason_url,
      'verified_source': instance.verified_source,
      'verified_source_url': instance.verified_source_url,
      'follow_me': instance.follow_me,
      'like': instance.like,
      'like_me': instance.like_me,
      'online_status': instance.online_status,
      'bi_followers_count': instance.bi_followers_count,
      'lang': instance.lang,
      'star': instance.star,
      'mbtype': instance.mbtype,
      'mbrank': instance.mbrank,
      'block_word': instance.block_word,
      'block_app': instance.block_app,
      'credit_score': instance.credit_score,
      'user_ability': instance.user_ability,
      'urank': instance.urank,
      'story_read_state': instance.story_read_state,
      'vclub_member': instance.vclub_member,
      'is_teenager': instance.is_teenager,
      'is_guardian': instance.is_guardian,
      'is_teenager_list': instance.is_teenager_list,
      'pc_new': instance.pc_new,
      'special_follow': instance.special_follow,
      'planet_video': instance.planet_video,
    };

InsecurityEntity _$InsecurityEntityFromJson(Map<String, dynamic> json) {
  return InsecurityEntity(
    sexual_content: json['sexual_content'] as bool,
  );
}

Map<String, dynamic> _$InsecurityEntityToJson(InsecurityEntity instance) =>
    <String, dynamic>{
      'sexual_content': instance.sexual_content,
    };

StatusEntity _$StatusEntityFromJson(Map<String, dynamic> json) {
  return StatusEntity(
    visible: json['visible'] == null
        ? null
        : VisibleEntity.fromJson(json['visible'] as Map<String, dynamic>),
    created_at: json['created_at'] as String,
    id: json['id'] as num,
    idstr: json['idstr'] as String,
    mid: json['mid'] as String,
    can_edit: json['can_edit'] as bool,
    show_additional_indication: json['show_additional_indication'] as num,
    text: json['text'] as String,
    textLength: json['textLength'] as num,
    source_allowclick: json['source_allowclick'] as num,
    source_type: json['source_type'] as num,
    source: json['source'] as String,
    favorited: json['favorited'] as bool,
    truncated: json['truncated'] as bool,
    in_reply_to_status_id: json['in_reply_to_status_id'] as String,
    in_reply_to_user_id: json['in_reply_to_user_id'] as String,
    in_reply_to_screen_name: json['in_reply_to_screen_name'] as String,
    geo: json['geo'],
    is_paid: json['is_paid'] as bool,
    mblog_vip_type: json['mblog_vip_type'] as num,
    annotations: (json['annotations'] as List)
        ?.map((e) => e == null
            ? null
            : AnnotationsEntity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    reposts_count: json['reposts_count'] as num,
    comments_count: json['comments_count'] as num,
    attitudes_count: json['attitudes_count'] as num,
    pending_approval_count: json['pending_approval_count'] as num,
    isLongText: json['isLongText'] as bool,
    reward_exhibition_type: json['reward_exhibition_type'] as num,
    hide_flag: json['hide_flag'] as num,
    mlevel: json['mlevel'] as num,
    biz_feature: json['biz_feature'] as num,
    hasActionTypeCard: json['hasActionTypeCard'] as num,
    mblogtype: json['mblogtype'] as num,
    rid: json['rid'] as String,
    userType: json['userType'] as num,
    more_info_type: json['more_info_type'] as num,
    positive_recom_flag: json['positive_recom_flag'] as num,
    content_auth: json['content_auth'] as num,
    gif_ids: json['gif_ids'] as String,
    is_show_bulletin: json['is_show_bulletin'] as num,
    comment_manage_info: json['comment_manage_info'] == null
        ? null
        : Comment_manage_infoEntity.fromJson(
            json['comment_manage_info'] as Map<String, dynamic>),
    pic_num: json['pic_num'] as num,
  );
}

Map<String, dynamic> _$StatusEntityToJson(StatusEntity instance) =>
    <String, dynamic>{
      'visible': instance.visible,
      'created_at': instance.created_at,
      'id': instance.id,
      'idstr': instance.idstr,
      'mid': instance.mid,
      'can_edit': instance.can_edit,
      'show_additional_indication': instance.show_additional_indication,
      'text': instance.text,
      'textLength': instance.textLength,
      'source_allowclick': instance.source_allowclick,
      'source_type': instance.source_type,
      'source': instance.source,
      'favorited': instance.favorited,
      'truncated': instance.truncated,
      'in_reply_to_status_id': instance.in_reply_to_status_id,
      'in_reply_to_user_id': instance.in_reply_to_user_id,
      'in_reply_to_screen_name': instance.in_reply_to_screen_name,
      'geo': instance.geo,
      'is_paid': instance.is_paid,
      'mblog_vip_type': instance.mblog_vip_type,
      'annotations': instance.annotations,
      'reposts_count': instance.reposts_count,
      'comments_count': instance.comments_count,
      'attitudes_count': instance.attitudes_count,
      'pending_approval_count': instance.pending_approval_count,
      'isLongText': instance.isLongText,
      'reward_exhibition_type': instance.reward_exhibition_type,
      'hide_flag': instance.hide_flag,
      'mlevel': instance.mlevel,
      'biz_feature': instance.biz_feature,
      'hasActionTypeCard': instance.hasActionTypeCard,
      'mblogtype': instance.mblogtype,
      'rid': instance.rid,
      'userType': instance.userType,
      'more_info_type': instance.more_info_type,
      'positive_recom_flag': instance.positive_recom_flag,
      'content_auth': instance.content_auth,
      'gif_ids': instance.gif_ids,
      'is_show_bulletin': instance.is_show_bulletin,
      'comment_manage_info': instance.comment_manage_info,
      'pic_num': instance.pic_num,
    };

VisibleEntity _$VisibleEntityFromJson(Map<String, dynamic> json) {
  return VisibleEntity(
    type: json['type'] as num,
    list_id: json['list_id'] as num,
  );
}

Map<String, dynamic> _$VisibleEntityToJson(VisibleEntity instance) =>
    <String, dynamic>{
      'type': instance.type,
      'list_id': instance.list_id,
    };

AnnotationsEntity _$AnnotationsEntityFromJson(Map<String, dynamic> json) {
  return AnnotationsEntity(
    shooting: json['shooting'] as num,
    client_mblogid: json['client_mblogid'] as String,
    mapi_request: json['mapi_request'] as bool,
  );
}

Map<String, dynamic> _$AnnotationsEntityToJson(AnnotationsEntity instance) =>
    <String, dynamic>{
      'shooting': instance.shooting,
      'client_mblogid': instance.client_mblogid,
      'mapi_request': instance.mapi_request,
    };

Comment_manage_infoEntity _$Comment_manage_infoEntityFromJson(
    Map<String, dynamic> json) {
  return Comment_manage_infoEntity(
    comment_permission_type: json['comment_permission_type'] as num,
    approval_comment_type: json['approval_comment_type'] as num,
  );
}

Map<String, dynamic> _$Comment_manage_infoEntityToJson(
        Comment_manage_infoEntity instance) =>
    <String, dynamic>{
      'comment_permission_type': instance.comment_permission_type,
      'approval_comment_type': instance.approval_comment_type,
    };
