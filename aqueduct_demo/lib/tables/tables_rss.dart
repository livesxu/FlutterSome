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
  String state;//状态 0:封号 1:正常
  DateTime createDate;//创建日期
  DateTime loginTime;//登录时间
  String auth;//认证

  ManagedSet<Tag> notices;//主动关注

  ManagedSet<Tag> tags;//标签

  ManagedSet<InterestInfo> interestInfo;//关注

  ManagedSet<CollectStore> collectStore;//收藏夹
}

//主题信息 - 类似栏目
class RssInfo extends ManagedObject<_RssInfo> implements _RssInfo {}
class _RssInfo {
  @Column(primaryKey: true,autoincrement: true)
  int infoId;
  String infoName;
  String infoUrl;
  @Column(nullable: true)
  String abInfoUrl;//绝对栏目链接 - 相比infourl更加准确，因为rss或者json内容的infourl是无法链接正式网页的
  @Column(nullable: true)
  String infoIntroduce;//介绍
  @Column(nullable: true)
  String infoImage;//图片
  String infoState;//1有效 0失效
  DateTime infoUpdateTime;
  ManagedSet<Tag> infoTags;

  ManagedSet<RssArticle> articles;
  
  InterestInfo interestInfo;

  //内容解析逻辑*****
  /*
  1.添加内容链接

   */
  //内容本地响应正则解析链路
  @Column(nullable: true)
  String topExp;//分栏一级正则解析式 - 获取内容集合
  @Column(nullable: true)
  String titleExpStart;//标题解析前标志字段
  @Column(nullable: true)
  String titleExpEnd;//标题解析后标志字段
  @Column(nullable: true)
  String contentExpStart;//内容解析前标志字段
  @Column(nullable: true)
  String contentExpEnd;//内容解析后标志字段
  @Column(nullable: true)
  String imageExpStart;//图片解析前标志字段
  @Column(nullable: true)
  String imageExpEnd;//图片解析后标志字段
  @Column(nullable: true)
  String linkExpStart;//链接解析前标志字段
  @Column(nullable: true)
  String linkExpEnd;//链接解析后标志字段
}

//主题关注 - 栏目关注
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

//文章
class RssArticle extends ManagedObject<_RssArticle> implements _RssArticle {}
class _RssArticle {
  @Column(primaryKey: true,autoincrement: true)
  int articleId;
  String articleTitle;
  @Column(nullable: true)
  String articleContent;
  @Column(nullable: true)
  String articleImage;//图片
  DateTime articleTime;
  String articleUrl;
  ManagedSet<Tag> tags;
  int state;//可用 、软删除(查询过滤)

  @Relate(#articles)
  RssInfo info;
  
  CollectArticles collectArticles;
}

//收藏夹
class CollectStore extends ManagedObject<_CollectStore> implements _CollectStore {}
class _CollectStore {

  @Column(primaryKey: true,autoincrement: true)
  int storeId;
  String storeName;//收藏夹名称
  String storeState;//收藏夹状态

  ManagedSet<CollectArticles> articles;

  @Relate(#collectStore)
  RssUser creator;
}

//收藏文章
class CollectArticles extends ManagedObject<_CollectArticles> implements _CollectArticles{}
class _CollectArticles {

  @Column(primaryKey: true,autoincrement: true)
  int id;

  bool collectState;//收藏、已取消

  @Relate(#collectArticles)
  RssArticle article;

  @Relate(#articles)
  CollectStore collectStore;
}

//内容标签
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
