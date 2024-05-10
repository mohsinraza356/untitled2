import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../hive_dbHandle/hiveDBHandler.dart';
import '../model_hive/model_classs.dart';
import 'HiveMainScreen.dart';

class CreateDataScreen extends StatefulWidget {
   CreateDataScreen({
    Key? key, this.index,this.name,this.description,this.age
  }) : super(key: key);
  int? index;
  String? name;
  String? description;
  int? age;

  @override
  State<CreateDataScreen> createState() => _CreateDataScreenState();
}

class _CreateDataScreenState extends State<CreateDataScreen> {
  HiveHandler? hiveHandler;
  Future<List<UserModel>>? userList;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  @override
  void initState() {
    super.initState();
    loadData();
    hiveHandler = HiveHandler();
    hiveHandler!.init();
  }
  loadData(){
    if(widget.name == null && widget.age == null && widget.description == null){
      _nameController.text = "";
      _ageController.text = "";
      _descriptionController.text = "";
    }else {
      _nameController.text = widget.name.toString();
      _ageController.text = widget.age.toString();
      _descriptionController.text = widget.description.toString();
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Data'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormFieldWidget(
                  controller: _nameController,
                  hintText: "Enter Name",
                  validateMsg: "your name",
                ),
                const SizedBox(height: 30),
                TextFormFieldWidget(
                  controller: _ageController,
                  hintText: "Enter age",
                  validateMsg: "your age",
                ),
                const SizedBox(height: 30),
                TextFormFieldWidget(
                  controller: _descriptionController,
                  hintText: "Enter description",
                  validateMsg: "your description",
                ),
                const SizedBox(height: 50),
                RoundedButton(
                  onTap: () {
                    print("please enter the text");
                    if(_formKey.currentState!.validate()){
                      var ageText = int.tryParse(_ageController.text.toString());
                      if(widget.index != null){
                        print("vvvvvvvvvvvvvv index ${widget.index}");
                        int index = widget.index!;
                        UserModel userModel = UserModel(
                          title: _nameController.text,
                          description: _descriptionController.text,
                          age: ageText,
                        );
                        hiveHandler!.updateDataInDB(userModel,index);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HiveMainScreen()));
                      }else{
                        hiveHandler!.createDataInDB(UserModel(
                          title: _nameController.text,
                          description: _descriptionController.text,
                          age: ageText,
                        ));
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HiveMainScreen()));
                      }
                    }
                    else {
                      print("please enter the text");
                    }

                  },
                  title: "Create",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    required this.onTap,
    required this.title,
  });
  final Function()? onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 250,
        height: 45,
        decoration: BoxDecoration(
            color: Colors.black54,
          borderRadius: BorderRadius.circular(22.5),
        ),
          child:  Center(
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
              ),),
          )
      ),
    );
  }
}

class TextFormFieldWidget extends StatelessWidget {
  TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.validateMsg,
    this.textInputType,
  });
  final TextEditingController controller;
  final String hintText;
  String? validateMsg;
  TextInputType? textInputType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      decoration: InputDecoration(
        border:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red,width: 1.0),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w400
        ),
      ),
      validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter $validateMsg';
      }
      return null;
    },
    );
  }
}
