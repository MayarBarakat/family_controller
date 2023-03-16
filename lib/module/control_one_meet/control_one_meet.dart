import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../layout/cubit/family_controller_cubit.dart';
import '../../models/team_model.dart';

class ControlOneMeet extends StatefulWidget {
  final String meetId;
  const ControlOneMeet({Key? key,required this.meetId}) : super(key: key);

  @override
  State<ControlOneMeet> createState() => _ControlOneMeetState();
}

class _ControlOneMeetState extends State<ControlOneMeet> {
  @override
  void dispose() {
    // TODO: implement dispose
    context.read<FamilyControllerCubit>().refreshChhoseModel();
    super.dispose();
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
            title: Text("Control Meet"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  buildCardOfTeam(cubit.mayarTeam, context),
                  const SizedBox(height: 10,),
                  buildCardOfTeam(cubit.amjadTeam, context),
                  const SizedBox(height: 10,),
                  buildCardOfTeam(cubit.mjdTeam, context),
                  const SizedBox(height: 10,),
                  buildCardOfTeam(cubit.daniTeam, context),
                  const SizedBox(height: 10,),
                  buildCardOfTeam(cubit.makramTeam, context),
                  SizedBox(height: 30,),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: (){
                          cubit.sendMeetResult(widget.meetId,context);
                        } ,
                        child: const Text("Send Results"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange[300]
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),

                ],
              ),
            ),
          ),

        );
      },
    );
  }

  Widget buildCardOfTeam(Team team,context){
    return Container(
      width: double.infinity,
      height: 430,
      decoration: BoxDecoration(
        color: Colors.blue[50],
        border: Border.all(width: 10,color: Colors.blue[300]!,),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(20),
            bottomLeft:Radius.circular(30),
            bottomRight:Radius.circular(40)
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                 ' ${team.name}', style: GoogleFonts.lalezar(fontSize: 22),),
              ),
            ),
            buildRowResult(team.rows[0].name, context,team,0),
            Divider(thickness: 2,color: Colors.indigo,),
            buildRowResult(team.rows[1].name, context,team,1),
            Divider(thickness: 2,color: Colors.indigo,),
            buildRowResult(team.rows[2].name, context,team,2),
            Divider(thickness: 2,color: Colors.indigo,),
            buildRowResult(team.rows[3].name, context,team,3),

          ],
        ),
      ),
    );
  }

  Widget buildRowResult(name,BuildContext context,Team team,int index){
    var cubit = FamilyControllerCubit.get(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Expanded(child: Text('$name',style:  TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),)),
        Expanded(
          child: Column(
            children: [
              Text("Win",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green),),
              Radio(
                value: 1,
                groupValue: team.rows[index].result,
                onChanged: (val) {
                  print("value $val");
                  cubit.changeSelectedFor1TeamRadio(val!,team,index);
                },
                activeColor: Colors.green,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text("Draw",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.yellow[800])),
              Radio(
                value: 2,
                groupValue: team.rows[index].result,
                onChanged: (val) {
                  print("value $val");
                  cubit.changeSelectedFor1TeamRadio(val!,team,index);
                },
                activeColor: Colors.yellow[800],
              ),
            ],
          ),
        ),

        Expanded(
          child: Column(
            children: [
              Text("Loss",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
              Radio(
                value: 3,
                groupValue: team.rows[index].result,
                onChanged: (val) {
                  print("value $val");
                  cubit.changeSelectedFor1TeamRadio(val!,team,index);
                },
                activeColor: Colors.red,
              ),
            ],
          ),
        ),

      ],
    );
  }
}
