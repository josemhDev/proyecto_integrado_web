import 'dart:convert';

class StoredItem {

  String name;
  String imgUrl;
  String desc;
  int size;
  String type;
  String createdAt;
  String? id;


  StoredItem({
    required this.name,
    required this.imgUrl,
    required this.desc,
    required this.size,
    required this.type,
    required this.createdAt,
  });



  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imgUrl': imgUrl,
      'desc': desc,
      'size': size,
      'type': type,
      'createdAt': createdAt,
    };
  }

  factory StoredItem.fromMap(Map<String, dynamic> map) {
    return StoredItem(
      name: map['name'] ?? '',
      imgUrl: map['imgUrl'] ?? '',
      desc: map['desc'] ?? '',
      size: map['size']?.toInt() ?? 0,
      type: map['type'] ?? '',
      createdAt: map['createdAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory StoredItem.fromJson(String source) => StoredItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StoredItem(name: $name, imgUrl: $imgUrl, desc: $desc, size: $size, type: $type, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is StoredItem &&
      other.name == name &&
      other.imgUrl == imgUrl &&
      other.desc == desc &&
      other.size == size &&
      other.type == type &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      imgUrl.hashCode ^
      desc.hashCode ^
      size.hashCode ^
      type.hashCode ^
      createdAt.hashCode;
  }
}
