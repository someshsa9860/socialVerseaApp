import 'posts.dart';

class ApiModel {
  ApiModel({
    this.page,
    this.recordsPerPage,
    this.maxPageSize,
    this.pageSize,
    this.posts,
  });

  ApiModel.fromJson(dynamic json) {
    page = json['page'];
    recordsPerPage = json['records_per_page'];
    maxPageSize = json['max_page_size'];
    pageSize = json['page_size'];
    if (json['posts'] != null) {
      posts = [];
      json['posts'].forEach((v) {
        posts?.add(Posts.fromJson(v));
      });
    }
  }

  int? page;
  int? recordsPerPage;
  int? maxPageSize;
  int? pageSize;
  List<Posts>? posts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = page;
    map['records_per_page'] = recordsPerPage;
    map['max_page_size'] = maxPageSize;
    map['page_size'] = pageSize;
    if (posts != null) {
      map['posts'] = posts?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
