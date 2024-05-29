class KangooList {
  String id;
  String name;
  String obs;
  DateTime dateCreate;
  DateTime dateUpdate;

  KangooList({
    required this.id,
    required this.name,
    required this.obs,
    required this.dateCreate,
    required this.dateUpdate,
  });

  KangooList.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        obs = map["obs"],
        dateCreate = DateTime.parse(map["dateCreate"]),
        dateUpdate = DateTime.parse(map["dateUpdate"]);

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "obs": obs,
      "dateCreate": dateCreate.toString(),
      "dateUpdate": dateUpdate.toString(),
    };
  }
}
