import 'package:family_controller/layout/cubit/family_controller_cubit.dart';
import 'package:family_controller/module/control_one_meet/control_one_meet.dart';
import 'package:family_controller/module/show_one_family_control/show_one_family_control.dart';
import 'package:family_controller/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class ControlFamily extends StatefulWidget {
  const ControlFamily({Key? key}) : super(key: key);

  @override
  State<ControlFamily> createState() => _ControlFamilyState();
}

class _ControlFamilyState extends State<ControlFamily> {
  @override
  void initState() {
    context.read<FamilyControllerCubit>().getAllMeets();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FamilyControllerCubit, FamilyControllerState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    var cubit = FamilyControllerCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Control Family"),
        centerTitle: true,
        leading: MenuWidget(),
      ),
      body:cubit.loadAllMeet?Center(child: CircularProgressIndicator(),): Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.separated(
            itemBuilder: (context,index){
              return Container(
                  decoration: BoxDecoration(
                      color: Color(0xff2C3144),
                      borderRadius: BorderRadius.circular(20),

                      border: Border.all(color: Colors.yellow)
                  ),
                  child: ListTile(
                    style: ListTileStyle.list,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      leading: SizedBox(
                        width: 160,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: (){
                                //TODO show results
                                navigateTo(context,ShowOneFamilyControl(meetID: cubit.allMeets[index].id.toString()));
                              },
                                icon: Icon(
                                    Icons.keyboard_arrow_left_sharp,
                                    color: Colors.white,
                                    size: 35.0
                                ),
                                ),
                            SizedBox(width: 10,),
                            IconButton(
                              onPressed: (){
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (context) => ControlOneMeet(meetId:cubit.allMeets[index].id.toString() ),
                                ))
                                    .then((value) {
                                      cubit.refreshChhoseModel();
                                  // you can do what you need here
                                  // setState etc.
                                });
                              },
                              icon: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 30.0
                              ),
                            ),
                            IconButton(
                              onPressed: (){
                                showDialog(
                                    context: context,
                                    builder: (context){
                                      return AlertDialog(
                                        title: Text("Delete Meet ?"),
                                        content: Text('At ${cubit.allMeets.elementAt(index).meet}',style: TextStyle(fontSize: 22),),
                                        buttonPadding: EdgeInsets.all(120),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: (){
                                              cubit.deleteMeet(cubit.allMeets.elementAt(index).id!,context);
                                              setState(() {

                                              });
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
                              icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 30.0
                              ),
                            ),
                          ],
                        ),
                      ),
                      title: Text(
                        "التاريخ : ${cubit.allMeets.elementAt(index).meet} ",
                        textAlign: TextAlign.end,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),
                      ),
                      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),


                      trailing:
                      FittedBox(
                        child: CircleAvatar(
                          radius: 30,
                          child: Icon(Icons.group),
                        ),
                      ),

                  ),
              );
            },
            separatorBuilder: (context,index){
              return SizedBox(height: 20,);
            },
            itemCount: cubit.allMeets.length
        ),
      )
    );
  },
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

