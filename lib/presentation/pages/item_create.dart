import 'dart:io';


import 'package:bidding_app/presentation/utils/utils.dart';
import 'package:bidding_app/business_logic/bloc/item_bloc.dart';
import 'package:bidding_app/business_logic/cubits/cubit/calendar_cubit.dart';
import 'package:bidding_app/presentation/pages/user_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../sharedInfo.dart';
import 'Categories.dart';

class CreateItemPage extends StatefulWidget {
  CreateItemPage({Key? key}) : super(key: key);
  @override
  CreateItemPageState createState() => CreateItemPageState();
}

class CreateItemPageState extends State<CreateItemPage> {
  File? image;
  String? value;
  String? date;
  String? path;
  String? time;

  final box = GetStorage();

  var _formKey = GlobalKey<FormState>();
  final sharedInfo = SharedInfo();

  final textControllerName = TextEditingController(),
      textControllerIncrement = TextEditingController(),
      textControllerMinPrice = TextEditingController();
  Widget buildItemNameContainer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        controller: textControllerName,
        decoration: InputDecoration(
          hintText: 'Item Name',
          contentPadding: EdgeInsets.only(bottom: 8),
          prefix: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Icon(
              Icons.account_circle,
              size: 24,
              color: Color(0xfff06292),
            ),
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget buildMinPriceContainer(context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      margin: EdgeInsets.only(left: 30),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black26,
          width: 2,
        ),
      ),
      child: TextFormField(
        controller: textControllerMinPrice,
        decoration: InputDecoration(
          hintText: 'Min Price',
          contentPadding: EdgeInsets.only(bottom: 8),
          prefix: Padding(
            padding: const EdgeInsets.only(left: 16.0),
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget buildIncrementContainer(context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      margin: EdgeInsets.only(right: 30),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black26,
          width: 2,
        ),
      ),
      child: TextFormField(
        controller: textControllerIncrement,
        decoration: InputDecoration(
          hintText: 'Increment',
          contentPadding: EdgeInsets.only(bottom: 8),
          prefix: Padding(
            padding: const EdgeInsets.only(left: 16.0),
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget buildFrom() {
    return BlocProvider(
      create: (context) => CalendarCubit(context),
      child: BlocBuilder<CalendarCubit, CalendarState>(
        builder: (context, state) {
          return Row(
            children: [
              Expanded(
                flex: 2,
                child: buildDropDownField(
                    text: Utils.toDate(state.fromDate),
                    onClicked: () {
                      BlocProvider.of<CalendarCubit>(context)
                          .pickFromDateTime(pickDate: true);
                      this.date = Utils.toDate(state.fromDate);
                    }),
              ),
              Expanded(
                child: buildDropDownField(
                    text: Utils.toTime(state.fromDate),
                    onClicked: () {
                      BlocProvider.of<CalendarCubit>(context)
                          .pickFromDateTime(pickDate: false);
                      setState(() {
                        this.time = Utils.toTime(state.fromDate);
                      });
                    }),
              )
            ],
          );
        },
      ),
    );
  }

  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate ?? DateTime(2015, 8),
        lastDate: DateTime(2101),
      );

      if (date == null) return null;
      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);

      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
          context: context, initialTime: TimeOfDay.fromDateTime(initialDate));

      if (timeOfDay == null) return null;

      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
      return date.add(time);
    }
  }

  Widget buildDropDownField(
      {required String text, required VoidCallback onClicked}) {
    return ListTile(
      title: Text(text),
      trailing: Icon(Icons.arrow_drop_down),
      onTap: onClicked,
    );
  }

  Widget buildDateTimePickers(BuildContext context) => Column(
        children: [buildFrom()],
      );

  Widget buildImageContainer(context) {
    return Container(
      
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey,
      ),
      child: Center(
          child: image != null
              ? Image.file(
                  File(this.path!),
                  fit: BoxFit.cover,
                )
              : Icon(
                  Icons.add_a_photo,
                )),
    );
  }

  Widget buildButton(
          {required String title,
          required IconData icon,
          required VoidCallback onClicked}) =>
      Container(
        height: 40,
        width: MediaQuery.of(context).size.width * 0.4,
        child: ElevatedButton(
          onPressed: onClicked,
          style: ElevatedButton.styleFrom(
              minimumSize: Size.fromWidth(100),
              fixedSize: Size.fromHeight(40),
              primary: Color(0xFF42A5F5),
              onPrimary: Colors.black,
              textStyle: TextStyle(fontSize: 15)),
          child: Row(
            children: [
              Icon(
                icon,
                size: 25,
              ),
              Text(title)
            ],
          ),
        ),
      );

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      this.path = image.path.toString();
      setState(() {
        this.image = imageTemporary;
        this.path = image.path.toString();
      });
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
  }

  final categories = ['Apartment', 'Truck', 'Appliance', 'Artifact','Clock', 'Bags'];

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(value: item, child: Text(item));
  }

  void loadingDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Loading..."),
            content: CircularProgressIndicator(
              strokeWidth: 6,
            ),
          );
        });
  }

  void messageDialog(BuildContext context, String message) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(message),
            actions: [
              ElevatedButton(
                child: Text("Ok"),
                onPressed: () {
                  if (message == "Created successfully") {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => UserItems()));
                  } else {
                    Navigator.of(context, rootNavigator: true).pop();
                  }
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final itemBloc = ItemCreateBloc(this.context);
    return BlocListener(
      bloc: itemBloc,
      listener: (context, ItemCreateState state) {
        if (state.item != null && state is ItemCreateState) {
          Navigator.of(context, rootNavigator: true).pop();

          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Categories()));
        } else if (state is LoadingState) {
          //show loading
          WidgetsBinding.instance!
              .addPostFrameCallback((_) => loadingDialog(context));
        } else if (state is SuccessSaveItem) {
          Navigator.of(context, rootNavigator: true).pop(); //close loading
          WidgetsBinding.instance!.addPostFrameCallback(
              (_) => messageDialog(context, "Created successfully"));
        } else if (state is GetFailureState) {
          Navigator.of(context, rootNavigator: true).pop();
          WidgetsBinding.instance!.addPostFrameCallback(
              (_) => messageDialog(context, "Upps... " + state.error));
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
                      Navigator.of(context, rootNavigator: true).pop();
                    },),
                    SizedBox(width:MediaQuery.of(context).size.width*0.2),
                    Text(
                      'Create',
                      style: TextStyle(
                          color: Color(0xFF42A5F5),
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                buildImageContainer(context),
                SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildButton(
                            title: 'Pick Camera',
                            icon: Icons.camera_alt_outlined,
                            onClicked: () {
                              pickImage(ImageSource.camera);
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        buildButton(
                            title: 'Pick Gallery',
                            icon: Icons.image_outlined,
                            onClicked: () {
                              pickImage(ImageSource.gallery);
                            }),
                      ],
                    ),
                  ),
                ),
                buildItemNameContainer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildMinPriceContainer(context),
                    buildIncrementContainer(context)
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: buildDateTimePickers(context),
                ),
                Container(
                  child: DropdownButton<String>(
                    hint: Text('Categories'),
                    items: categories.map((String item) {
                      return DropdownMenuItem<String>(
                          value: item, child: Text(item));
                    }).toList(),
                    onChanged: (value) => setState(() => this.value = value),
                    value: this.value,
                  ),
                ),
                ElevatedButton(
                  child: Text('Create'),
                  onPressed: () {
                    
                    itemBloc.onCreate(
                        textControllerName.text,
                        box.read('id'),
                        textControllerIncrement.text,
                        textControllerMinPrice.text,
                        value!,
                        date!,
                        time!,
                        path!);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
