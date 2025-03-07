class ProfileModel {
  String? id;
  String? displayName;
  String? username;
  List<dynamic>? roles;
  bool? active;
  int? experienceYears;
  String? address;
  String? level;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  ProfileModel({
    this.id,
    this.displayName,
    this.username,
    this.roles,
    this.active,
    this.experienceYears,
    this.address,
    this.level,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    id: json['_id'] as String?,
    displayName: json['displayName'] as String?,
    username: json['username'] as String?,
    roles: json['roles'] as List<dynamic>?,
    active: json['active'] as bool?,
    experienceYears: json['experienceYears'] as int?,
    address: json['address'] as String?,
    level: json['level'] as String?,
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
    'displayName': displayName,
    'username': username,
    'roles': roles,
    'active': active,
    'experienceYears': experienceYears,
    'address': address,
    'level': level,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    '__v': v,
  };
}
