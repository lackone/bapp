class Owner {
  String name;
  String face;
  int fans;

  Owner({this.name = "", this.face = "", this.fans = 0});

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(name: json['name'], face: json['face'], fans: json['fans']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'face': face, 'fans': fans};
  }
}
