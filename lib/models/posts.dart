import 'category.dart';

class Posts {
  Posts({
    this.id,
    this.category,
    this.slug,
    this.title,
    this.identifier,
    this.commentCount,
    this.upvoteCount,
    this.shareCount,
    this.videoLink,
    this.isLocked,
    this.createdAt,
    this.firstName,
    this.lastName,
    this.username,
    this.upvoted,
    this.bookmarked,
    this.thumbnailUrl,
    this.following,
    this.pictureUrl,
  });

  Posts.fromJson(dynamic json) {
    id = json['id'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    slug = json['slug'];
    title = json['title'];
    identifier = json['identifier'];
    commentCount = json['comment_count'];
    upvoteCount = json['upvote_count'];
    shareCount = json['share_count'];
    videoLink = json['video_link'];
    isLocked = json['is_locked'];
    createdAt = json['created_at'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    upvoted = json['upvoted'];
    bookmarked = json['bookmarked'];
    thumbnailUrl = json['thumbnail_url'];
    following = json['following'];
    pictureUrl = json['picture_url'];
  }

  int? id;
  Category? category;
  String? slug;
  String? title;
  String? identifier;
  int? commentCount;
  int? upvoteCount;
  int? shareCount;
  String? videoLink;
  bool? isLocked;
  int? createdAt;
  String? firstName;
  String? lastName;
  String? username;
  bool? upvoted;
  bool? bookmarked;
  String? thumbnailUrl;
  bool? following;
  String? pictureUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (category != null) {
      map['category'] = category?.toJson();
    }
    map['slug'] = slug;
    map['title'] = title;
    map['identifier'] = identifier;
    map['comment_count'] = commentCount;
    map['upvote_count'] = upvoteCount;
    map['share_count'] = shareCount;
    map['video_link'] = videoLink;
    map['is_locked'] = isLocked;
    map['created_at'] = createdAt;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['username'] = username;
    map['upvoted'] = upvoted;
    map['bookmarked'] = bookmarked;
    map['thumbnail_url'] = thumbnailUrl;
    map['following'] = following;
    map['picture_url'] = pictureUrl;
    return map;
  }
}
