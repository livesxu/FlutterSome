import 'package:aqueduct_demo/aqueduct_demo.dart';
//数据库表和字段定义 https://aqueduct.io/docs/db/modeling_data/
//增删改查操作 https://aqueduct.io/docs/db/executing_queries/
class User extends ManagedObject<_User> implements _User {}
class _User {

  @Column(primaryKey: true)
  int id;

  @Column(indexed: true,autoincrement: true)
  int user_id;

  @Column(indexed: true)
  String user_name;

  @Column(indexed: true)
  String nick_name;

  @Column(indexed: true)
  String rank;

  @Column(indexed: true)
  bool vip;

  String password;
}

class Article extends ManagedObject<_Article> implements _Article {}
class _Article {
  @primaryKey//作为主键 == @
  int id;

  String content;//内容

  @Column(indexed: true)//添加索引
  DateTime createData;

}