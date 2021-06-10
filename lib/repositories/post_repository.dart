import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';

abstract class PostRepository {
  Future<List<Post>> getPost();
}

class SamplePostRepository implements PostRepository {
  final baseUrl = "https://reddit-e717a-default-rtdb.firebaseio.com/.json";

  @override
  Future<List<Post>> getPost() async {
    final response = await http.get(Uri.parse(baseUrl));
    print(response);

    switch (response.statusCode) {
      case HttpStatus.ok:
        print(response);
        final jsonBody = json.decode(response.body) as List;
        return jsonBody.map((e) => Post.fromJson(e)).toList();
      default:
        throw NetworkError(response.statusCode.toString(), response.body);
    }
  }
}

class NetworkError implements Exception {
  final String statusCode;
  final String message;

  NetworkError(this.statusCode, this.message);
}
