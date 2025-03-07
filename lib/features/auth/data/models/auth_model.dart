class AuthModel {
  String? id;
  String? accessToken;
  String? refreshToken;
  String? name;

  AuthModel({this.id, this.accessToken, this.refreshToken,this.name});

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
    id: json['_id'] as String?,
    accessToken: json['access_token'] as String?,
    refreshToken: json['refresh_token'] as String?,
    name: json['displayName'] as String?,
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'access_token': accessToken,
    'refresh_token': refreshToken,
    'displayName': name
  };
}
