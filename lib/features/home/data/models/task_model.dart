class TaskModel {
  String? id;
  String? image;
  String? title;
  String? desc;
  String? priority;
  String? status;
  String? user;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  TaskModel({
    this.id,
    this.image,
    this.title,
    this.desc,
    this.priority,
    this.status,
    this.user,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    id: json['_id'] as String?,
    image: json['image'] as String?,
    title: json['title'] as String?,
    desc: json['desc'] as String?,
    priority: json['priority'] as String?,
    status: json['status'] as String?,
    user: json['user'] as String?,
    createdAt:
        json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
    updatedAt:
        json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
    v: json['__v'] as int?,
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'image': image,
    'title': title,
    'desc': desc,
    'priority': priority,
    'status': status,
    'user': user,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    '__v': v,
  };
}
