//https://aqueduct.io/docs/http/file_upload/
//https://www.dartcn.com/server/io-library-tour
import '../aqueduct_demo.dart';
import 'package:mime/mime.dart';

//单张上传
class ImageController extends ResourceController {
  ImageController() {
    acceptedContentTypes = [ContentType("multipart", "form-data")];
  }

  @Operation.post()
  Future<Response> postImage() async {
    final boundary = request.raw.headers.contentType.parameters["boundary"];
    final transformer = MimeMultipartTransformer(boundary);
    final bodyBytes = await request.body.decode<List<int>>();

    // Pay special attention to the square brackets in the argument:
    final bodyStream = Stream.fromIterable([bodyBytes]);
    final parts = await transformer.bind(bodyStream).toList();

    File file_sure;
    String image_name;
    for (var part in parts) {
      final headers = part.headers;
      String fileNames = headers['content-disposition'];
      fileNames = fileNames.split('=').last;
      fileNames = fileNames.replaceAll('\"', "");
      final content = await part.toList();
      image_name = fileNames + '.png';
      final fileName = './store/image/' + image_name;
      final file = File(fileName);
      file_sure = await file.writeAsBytes(content.first);
      // Use headers['content-disposition'] to identify the part
      // The byte content of the part is available in 'content'.
    }
    if (file_sure != null && image_name != null) {

      String image_link = 'http://localhost:8888' + '/image/' + image_name;

      return Response.ok(image_link);
    } else {

      return Response.badRequest(body:'上传失败');
    }
  }
}


