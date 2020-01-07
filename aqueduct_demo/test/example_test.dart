import 'harness/app.dart';
//https://aqueduct.io/docs/testing/tests/

Future main() async {
  final harness = Harness()..install();

//  test("GET /example returns 200 {'key': 'value'}", () async {
//    expectResponse(await harness.agent.get("/example"), 200, body: {"key": "value"});
//  });
//
//  test("GET /login/in returns 200 {'key': 'value'}", () async {
//    expectResponse(await harness.agent.get("/login/in"), 200, body: {"key": "value"});
//  });
//添加账号测试
//  test("post login return 200", () async {
//    final response = await harness.agent.post("/login", body: {
//      "id":14,
//      "nick_name":"postOneMan",
//      "password":"123456"
//    });
//
//    expect(response, hasStatus(200));
//  });
//登录测试
//  test("get login return 200", () async {
//    final response = await harness.agent.get("/login?id=12&password=123456");
//
//    expect(response, hasStatus(200));
//  });
//
////添加标签测试
//  test("post tag return 200", () async {
//    final response = await harness.agent.post("/tag", body: {
//      "tagName":"教育"
//    });
//
//    expect(response, hasStatus(200));
//  });
//查询标签测试
  test("get tag return 200", () async {
    final response = await harness.agent.get("/tag");

    print(response);
    expect(response, hasStatus(200));
  });



//  test("POST /employees adds an audit log record", () async {
//    final response = await harness.agent.post("/employees", body: {
//      "name": "Fred"
//    });
//
//    expect(response, hasStatus(202));
//
//    final context = harness.channel.context;
//    final query = new Query<AuditRecord>(context)
//      ..where((record) => record.user.id).equalTo(response.body.as<Map>()['id']);
//    final record = await query.fetchOne();
//    expect(record, isNotNull);
//  });
}
