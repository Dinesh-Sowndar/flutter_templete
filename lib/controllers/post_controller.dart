import 'package:flutter_templete/model/post_model.dart';
import 'package:flutter_templete/services/api.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  List<PostModel> posts = [];
  bool loading = true;

  @override
  void onInit(){
    super.onInit();
    fetchPosts();
  }

  fetchPosts() {
    ApiServices()
        .customGet("https://jsonplaceholder.typicode.com/posts/")
        .then((value) {
      posts = (value as List).map((e) => PostModel.fromJson(e)).toList();
      loading = false;
    });
    update();
   
  }
}
