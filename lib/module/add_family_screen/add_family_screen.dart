import 'package:family_controller/layout/cubit/family_controller_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:intl/intl.dart';

class AddFamilyScreen extends StatelessWidget {
  const AddFamilyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = FamilyControllerCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new Family Meet"),
        centerTitle: true,
        leading: MenuWidget(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 180,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (date){
                    cubit.selectedDate =DateFormat('yyyy-MM-dd').format(date);
                  },

                  initialDateTime: DateTime.now(),
                minimumYear: 2023,
                maximumYear: 2025,
              ),
            ),
            Spacer(),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),

              ),
              child: ElevatedButton(
                child: Text("Add"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[200]
                ),
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        title: Text("Add new Family meet?"),
                        content: Text(cubit.selectedDate,style: TextStyle(fontSize: 22),),
                        buttonPadding: EdgeInsets.all(120),
                        actions: [
                          ElevatedButton(
                              onPressed: (){
                                cubit.addNewFamilyMeet(cubit.selectedDate,context);
                              },
                              child: Text("yes",style: TextStyle(color: Colors.white),),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green
                            ),
                          ),
                          ElevatedButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: Text("No",style: TextStyle(color: Colors.white),),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red
                            ),
                          ),
                        ],
                      );
                    }
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: (){
          return ZoomDrawer.of(context)!.toggle();
        },
        icon: Icon(Icons.menu_outlined,)
    );
  }
}

