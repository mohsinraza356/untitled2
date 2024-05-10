import 'package:flutter/material.dart';
import '../hive_dbHandle/hiveDBHandler.dart';
import '../model_hive/model_classs.dart';
import 'create_data_screen.dart';

class HiveMainScreen extends StatefulWidget {
  const HiveMainScreen({super.key});

  @override
  State<HiveMainScreen> createState() => _HiveMainScreenState();
}

class _HiveMainScreenState extends State<HiveMainScreen> {
  HiveHandler? hiveHandler;
  Future<List<UserModel>>? userList;
  @override
  void initState() {
    super.initState();
    hiveHandler = HiveHandler();
    hiveHandler!.init();
    loadData();
  //  _getItems();
  }
  loadData(){
    userList = hiveHandler!.getDataInDB();
  }
  // List<UserModel> newList = [];
  // void _getItems (){
  //   final data = userBox.keys.map((key) {
  //     var item = userBox.get(key);
  //     return UserModel.fromMap(item);
  //   }).toList();
  //
  //   setState(() {
  //     // newList = data.reversed.toList();
  //     newList = data;
  //     print("vvvvvvvvvvv ${newList.length}");
  //   });
  // }
  // final userBox = Hive.box('userInFrom');
  // Future<void> createData(UserModel newItem) async{
  //   await userBox.add(newItem.toMap());
  //   _getItems();
  //   print("jlsfklsdjfdklsjf ${userBox.length}");
  // }
  // Future<void> dataDelete(int key) async {
  //   await userBox.deleteAt(key);
  // }
  // Future<void> updateData(UserModel newItem,int key) async{
  //   await userBox.putAt(key, newItem.toMap());
  //   _getItems();
  //   print("jlsfklsdjfdklsjf ${userBox.length}");
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: userList,
                builder: (context, AsyncSnapshot<List<UserModel>> snapshot){
                  if(snapshot.hasData) {
                    return Align(
                      alignment: Alignment.topCenter,
                      child: ListView.builder(
                          itemCount: snapshot.data?.reversed.length,
                          shrinkWrap: true,
                          reverse: true,
                          itemBuilder: (context, index) {
                            var currentItem = snapshot.data![index];
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          currentItem.title.toString(),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          currentItem.description.toString(),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          currentItem.age.toString(),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                            onTap: () async{
                                              setState(() {});
                                              hiveHandler!.deleteDataInDb(index);
                                              loadData();
                                            },
                                            child: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                              size: 25,
                                            )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                            onTap: () async{
                                              // setState(() {});
                                              // UserModel userModel = UserModel(
                                              //   title: "update title",
                                              //   description: "update description",
                                              //   name: 'update name',
                                              // );
                                              // hiveHandler!.updateDataInDB(userModel,index);
                                              // setState(() {
                                              //   loadData();
                                              // });
                                              Navigator.of(context)
                                                  .push(
                                                MaterialPageRoute(
                                                  builder: (context) =>  CreateDataScreen(
                                                    index: index,
                                                    name: currentItem.title,
                                                    description: currentItem.description,
                                                    age: currentItem.age,
                                                  ),
                                                ),
                                              );
                                              setState(() {
                                                loadData();
                                              });

                                            },
                                            child: const Icon(
                                              Icons.edit,
                                              color: Colors.black,
                                              size: 25,
                                            )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    );
                  }
                  else{
                    return const Center(child: CircularProgressIndicator());
                  }
                }
            ),

          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.of(context)
              .push(
              MaterialPageRoute(
                  builder: (context) =>  CreateDataScreen(),
              ),
          );
          loadData();
        },
        child: const  Icon(Icons.add),
      ),
    );
  }

}
