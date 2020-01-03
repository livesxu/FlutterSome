import '../aqueduct_demo.dart';

//https://aqueduct.io/docs/http/controller/
//https://aqueduct.io/docs/http/routing/

class LoginVc extends Controller {
  
  LoginVc(this.context);

  final ManagedContext context;
  
  @override
  FutureOr<RequestOrResponse> handle(Request request) {

    List<String> paths = request.path.segments;

    return Response.ok("");
  }
}