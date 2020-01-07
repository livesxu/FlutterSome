import 'package:aqueduct_demo/aqueduct_demo.dart';

class RssUser extends ManagedObject<_RssUser> implements _RssUser {}
class _RssUser {

  @Column(autoincrement: true)
  int userId;//用户id
  @Column(primaryKey: true)
  String phone;//手机号
  String nick;//昵称
  String introduce;//介绍
  String headImg;//头像
  @Column(nullable: false)
  String password;//密码
  int level;//等级
  int vip;//会员
  String state;//状态
  DateTime createDate;//创建日期
  DateTime loginTime;//登录时间
  String auth;//认证

  ManagedSet<Tag> notices;//主动关注

  ManagedSet<Tag> tags;//标签

  ManagedSet<InterestInfo> interestInfo;//关注

  ManagedSet<CollectStore> collectStore;//收藏夹
}

class RssInfo extends ManagedObject<_RssInfo> implements _RssInfo {}
class _RssInfo {
  @Column(primaryKey: true,autoincrement: true)
  int infoId;
  String infoName;
  String infoUrl;
  String infoIntroduce;
  String infoState;//1有效 0失效
  DateTime infoUpdateTime;
  ManagedSet<Tag> infoTags;

  ManagedSet<RssArticle> articles;
  
  InterestInfo interestInfo;
}

class InterestInfo extends ManagedObject<_InterestInfo> implements _InterestInfo {}
class _InterestInfo {

  @Column(primaryKey: true,autoincrement: true)
  int id;

  bool interestState;//关注、已取消

  @Relate(#interestInfo)
  RssInfo info;
  
  @Relate(#interestInfo)
  RssUser user;
}

class RssArticle extends ManagedObject<_RssArticle> implements _RssArticle {}
@Table(name: "_Contents")
class _RssArticle {
  @Column(primaryKey: true,autoincrement: true)
  int articleId;
  String articleTitle;
  String articleContent;
  DateTime articleTime;
  String articleUrl;
  ManagedSet<Tag> tags;
  int state;//可用 、软删除(查询过滤)

  @Relate(#articles)
  RssInfo info;
  
  CollectArticles collectArticles;
}

class CollectStore extends ManagedObject<_CollectStore> implements _CollectStore {}
//收藏夹
class _CollectStore {

  @Column(primaryKey: true,autoincrement: true)
  int storeId;
  String storeName;//收藏夹名称
  String storeState;//收藏夹状态

  ManagedSet<CollectArticles> articles;

  @Relate(#collectStore)
  RssUser creator;
}

class CollectArticles extends ManagedObject<_CollectArticles> implements _CollectArticles{}
//收藏文章
class _CollectArticles {

  @Column(primaryKey: true,autoincrement: true)
  int id;

  bool collectState;//收藏、已取消

  @Relate(#collectArticles)
  RssArticle article;

  @Relate(#articles)
  CollectStore collectStore;
}

class Tag extends ManagedObject<_Tag> implements _Tag {}
class _Tag {

  @Column(autoincrement: true)
  int tagId;

  @Column(primaryKey: true)
  String tagName;

  @Relate(#notices)
  RssUser user;

  @Relate(#tags)
  RssUser user1;

  @Relate(#infoTags)
  RssInfo rssInfo;

  @Relate(#tags)
  RssArticle rssArticle;
}
