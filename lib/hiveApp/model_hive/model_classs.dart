class UserModel {
  String? id;
  String title;
  int? age;
  String description;
  String? email;
  String? image;
  String? name;
  String? time;
  UserModel({
    this.id,
    this.age,
    this.email,
    required this.title,
    required this.description,
    this.image,
    this.name,
    this.time
  });
  factory UserModel.fromMap(Map<dynamic,dynamic> res) => UserModel(
    id: res["id"],
    title: res["title"],
    age: res["age"],
    description: res["description"],
    image: res["image"],
    email: res["email"],
    name:res["name"],
    time: res['time']
  );

  Map<dynamic,dynamic> toMap() => {
    "id": id,
    "title": title,
    "age": age,
    "description": description,
    "email": email,
    "image":image,
    "name":name,
    "time":time
  };

}