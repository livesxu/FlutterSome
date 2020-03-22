import '../aqueduct_demo.dart';
import '../tables/tables_rss.dart';

class TagResourceVc extends ResourceController {

  TagResourceVc(this.context);

  final ManagedContext context;

  //查询所有标签
  @Operation.get()
  FutureOr<Response> allTag () async {

    final query = Query<Tag>(context)
      ..sortBy((Tag tag) => tag.tagId, QuerySortOrder.ascending);

    List<Tag> list = await query.fetch();

    return Response.ok(list.map((Tag tag) => tag.tagName).toList());
  }

  //根据名称添加一个标签
  /*
  * tagName 标签名称 必传
   */
  @Operation.post()
  FutureOr<Response> addTag (@Bind.body(require: ["tagName"]) Tag tag) async {

    final result = await context.insertObject<Tag>(tag);

    return Response.ok(result);
  }
}