class CharacterModel {
  int? charId;
  String? name;
  String? birthday;
  List<String>? occupation;
  String? img;
  String? status;
  String? nickname;
  List<int>? appearance;
  String? portrayed;
  String? category;
  List<int>? betterCallSaulAppearance;

  CharacterModel(
      {this.charId,
      this.name,
      this.birthday,
      this.occupation,
      this.img,
      this.status,
      this.nickname,
      this.appearance,
      this.portrayed,
      this.category,
      this.betterCallSaulAppearance});

  CharacterModel.fromJson(Map<String, dynamic> json) {
    charId = json['char_id'];
    name = json['name'];
    birthday = json['birthday'];
    occupation = json['occupation'].cast<String>();
    img = json['img'];
    status = json['status'];
    nickname = json['nickname'];
    appearance = json['appearance'].cast<int>();
    portrayed = json['portrayed'];
    category = json['category'];
    betterCallSaulAppearance = json['better_call_saul_appearance'].cast<int>();
  }

  CharacterModel copyWith(
          int? charId,
          String? name,
          String? birthday,
          List<String>? occupation,
          String? img,
          String? status,
          String? nickname,
          List<int>? appearance,
          String? portrayed,
          String? category,
          List<int>? betterCallSaulAppearance) =>
      CharacterModel(
        appearance: appearance,
        betterCallSaulAppearance: betterCallSaulAppearance,
        birthday: birthday,
        category: category,
        charId: charId,
        img: img,
        name: name,
        nickname: nickname,
        occupation: occupation,
        portrayed: portrayed,
        status: status,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['char_id'] = this.charId;
    data['name'] = this.name;
    data['birthday'] = this.birthday;
    data['occupation'] = this.occupation;
    data['img'] = this.img;
    data['status'] = this.status;
    data['nickname'] = this.nickname;
    data['appearance'] = this.appearance;
    data['portrayed'] = this.portrayed;
    data['category'] = this.category;
    data['better_call_saul_appearance'] = this.betterCallSaulAppearance;
    return data;
  }
}
