class AllMeets {
  String? id;
  String? meet;

  AllMeets({this.id, this.meet});

  AllMeets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    meet = json['meet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['meet'] = this.meet;
    return data;
  }
}