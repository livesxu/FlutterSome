import 'dart:async';
import 'package:aqueduct/aqueduct.dart';   

class Migration1 extends Migration { 
  @override
  Future upgrade() async {
   		database.createTable(SchemaTable("_Article", [SchemaColumn("id", ManagedPropertyType.bigInteger, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("content", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("createData", ManagedPropertyType.datetime, isPrimaryKey: false, autoincrement: false, isIndexed: true, isNullable: false, isUnique: false)]));
		database.createTable(SchemaTable("_User", [SchemaColumn("id", ManagedPropertyType.integer, isPrimaryKey: true, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("user_id", ManagedPropertyType.integer, isPrimaryKey: false, autoincrement: true, isIndexed: true, isNullable: false, isUnique: false),SchemaColumn("user_name", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: true, isNullable: false, isUnique: false),SchemaColumn("nick_name", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: true, isNullable: false, isUnique: false),SchemaColumn("rank", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: true, isNullable: false, isUnique: false),SchemaColumn("vip", ManagedPropertyType.boolean, isPrimaryKey: false, autoincrement: false, isIndexed: true, isNullable: false, isUnique: false),SchemaColumn("password", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false)]));
		database.createTable(SchemaTable("_Contents", [SchemaColumn("articleId", ManagedPropertyType.integer, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("articleTitle", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("articleContent", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("articleTime", ManagedPropertyType.datetime, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("articleUrl", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("state", ManagedPropertyType.integer, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false)]));
		database.createTable(SchemaTable("_Tag", [SchemaColumn("tagId", ManagedPropertyType.integer, isPrimaryKey: false, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("tagName", ManagedPropertyType.string, isPrimaryKey: true, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false)]));
		database.createTable(SchemaTable("_CollectStore", [SchemaColumn("storeId", ManagedPropertyType.integer, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("storeName", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("storeState", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false)]));
		database.createTable(SchemaTable("_CollectArticles", [SchemaColumn("id", ManagedPropertyType.integer, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("collectState", ManagedPropertyType.boolean, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false)]));
		database.createTable(SchemaTable("_InterestInfo", [SchemaColumn("id", ManagedPropertyType.integer, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("interestState", ManagedPropertyType.boolean, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false)]));
		database.createTable(SchemaTable("_RssInfo", [SchemaColumn("infoId", ManagedPropertyType.integer, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("infoName", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("infoUrl", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("infoIntroduce", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("infoState", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("infoUpdateTime", ManagedPropertyType.datetime, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false)]));
		database.createTable(SchemaTable("_RssUser", [SchemaColumn("userId", ManagedPropertyType.integer, isPrimaryKey: false, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("phone", ManagedPropertyType.string, isPrimaryKey: true, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("nick", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("introduce", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("headImg", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("password", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("level", ManagedPropertyType.integer, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("vip", ManagedPropertyType.integer, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("state", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("createDate", ManagedPropertyType.datetime, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("loginTime", ManagedPropertyType.datetime, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("auth", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false)]));
		database.addColumn("_Contents", SchemaColumn.relationship("info", ManagedPropertyType.integer, relatedTableName: "_RssInfo", relatedColumnName: "infoId", rule: DeleteRule.nullify, isNullable: true, isUnique: false));
		database.addColumn("_Tag", SchemaColumn.relationship("user", ManagedPropertyType.string, relatedTableName: "_RssUser", relatedColumnName: "phone", rule: DeleteRule.nullify, isNullable: true, isUnique: false));
		database.addColumn("_Tag", SchemaColumn.relationship("user1", ManagedPropertyType.string, relatedTableName: "_RssUser", relatedColumnName: "phone", rule: DeleteRule.nullify, isNullable: true, isUnique: false));
		database.addColumn("_Tag", SchemaColumn.relationship("rssInfo", ManagedPropertyType.integer, relatedTableName: "_RssInfo", relatedColumnName: "infoId", rule: DeleteRule.nullify, isNullable: true, isUnique: false));
		database.addColumn("_Tag", SchemaColumn.relationship("rssArticle", ManagedPropertyType.integer, relatedTableName: "_Contents", relatedColumnName: "articleId", rule: DeleteRule.nullify, isNullable: true, isUnique: false));
		database.addColumn("_CollectStore", SchemaColumn.relationship("creator", ManagedPropertyType.string, relatedTableName: "_RssUser", relatedColumnName: "phone", rule: DeleteRule.nullify, isNullable: true, isUnique: false));
		database.addColumn("_CollectArticles", SchemaColumn.relationship("article", ManagedPropertyType.integer, relatedTableName: "_Contents", relatedColumnName: "articleId", rule: DeleteRule.nullify, isNullable: true, isUnique: true));
		database.addColumn("_CollectArticles", SchemaColumn.relationship("collectStore", ManagedPropertyType.integer, relatedTableName: "_CollectStore", relatedColumnName: "storeId", rule: DeleteRule.nullify, isNullable: true, isUnique: false));
		database.addColumn("_InterestInfo", SchemaColumn.relationship("info", ManagedPropertyType.integer, relatedTableName: "_RssInfo", relatedColumnName: "infoId", rule: DeleteRule.nullify, isNullable: true, isUnique: true));
		database.addColumn("_InterestInfo", SchemaColumn.relationship("user", ManagedPropertyType.string, relatedTableName: "_RssUser", relatedColumnName: "phone", rule: DeleteRule.nullify, isNullable: true, isUnique: false));
  }
  
  @override
  Future downgrade() async {}
  
  @override
  Future seed() async {}
}
    