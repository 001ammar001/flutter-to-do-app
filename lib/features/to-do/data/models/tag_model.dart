import 'package:to_do_app/features/to-do/domin/entitys/tag_entity.dart';

class TagModel extends TagEntity {
  TagModel({required super.name, required super.color});

  factory TagModel.fromJson(Map<String, dynamic> map) {
    return TagModel(
      name: map["name"],
      color: map["color"],
    );
  }

  Map<String, dynamic> toJSon() {
    return {"name": name, "color": color};
  }
}
