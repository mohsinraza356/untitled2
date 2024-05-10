import 'package:hive/hive.dart';

import '../model_hive/model_classs.dart';

class HiveHandler{
  static Box? _instance;
  Future<Box?> get db async{
    if (_instance != null) {
      return _instance;
    }
    _instance = await init();
    return _instance;
  }
  init() async {
    final userBox = Hive.box('userInFrom');
    return userBox;
  }
  Future<void> createDataInDB(UserModel userModel) async{
    var dbClient = await db;
    await dbClient!.add(userModel.toMap());
    print("dbClient List length ${dbClient.length}");
  }

  Future<List<UserModel>> getDataInDB() async{
    var dbClient = await db;
    final data = dbClient!.keys.map((key) {
      var item = dbClient!.get(key);
      return UserModel.fromMap(item);
    }).toList();
      print("vvvvvvvvvvv ${data.length}");
      return data;
  }

  Future<void> updateDataInDB(UserModel userModel,int index) async{
    var dbClient = await db;
    dbClient!.putAt(index, userModel.toMap());
    var updatedData = await getDataInDB();
    print("Updated data: $updatedData");
    print("jlsfklsdjfdklsjf ${dbClient!.length}");
  }

  Future<void> deleteDataInDb(int key) async {
    var dbClient = await db;
    await dbClient!.deleteAt(key);
  }

}