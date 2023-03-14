class Category {
  Category({
      this.id, 
      this.name, 
      this.count, 
      this.description, 
      this.imageUrl,});

  Category.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    count = json['count'];
    description = json['description'];
    imageUrl = json['image_url'];
  }
  int? id;
  String? name;
  int? count;
  String? description;
  String? imageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['count'] = count;
    map['description'] = description;
    map['image_url'] = imageUrl;
    return map;
  }

}