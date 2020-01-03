import 'harness/app.dart';
import '../lib/tables/tables_rss.dart';
//https://aqueduct.io/docs/testing/tests/

Future main() async {
  final harness = Harness()..install();

  test("GET /example returns 200 {'key': 'value'}", () async {
    expectResponse(await harness.agent.get("/example"), 200, body: {"key": "value"});
  });

  test("GET /login/in returns 200 {'key': 'value'}", () async {
    expectResponse(await harness.agent.get("/login/in"), 200, body: {"key": "value"});
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
