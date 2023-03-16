import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:family_controller/layout/cubit/family_controller_cubit.dart';
import 'package:family_controller/models/one_meet_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowOneFamilyControl extends StatefulWidget {
  final String meetID;
  const ShowOneFamilyControl({required this.meetID}) : super();

  @override
  State<ShowOneFamilyControl> createState() => _ShowOneFamilyControlState();
}

class _ShowOneFamilyControlState extends State<ShowOneFamilyControl> {
  @override
  void initState() {
    context.read<FamilyControllerCubit>().getOneMeetResults(widget.meetID);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var cubit = FamilyControllerCubit.get(context);
    return BlocConsumer<FamilyControllerCubit, FamilyControllerState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {

    return cubit.loadOneMeet?
    Scaffold(
        body: Center(
          child:
          CircularProgressIndicator(),
        )
    )
        : Scaffold(
      appBar: AppBar(
        title: const Text(
          "Show Results",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child:cubit.loadOneMeet?const Center(child: CircularProgressIndicator(),): GridView(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            crossAxisCount: 2,
            childAspectRatio: .9,
          ),
          physics: const BouncingScrollPhysics(),
          children: [
            buildCard(teamMeetRows: cubit.oneMeetModel.teamMeetRows!.elementAt(0)),
            buildCard(teamMeetRows: cubit.oneMeetModel.teamMeetRows!.elementAt(1)),
            buildCard(teamMeetRows: cubit.oneMeetModel.teamMeetRows!.elementAt(2)),
            buildCard(teamMeetRows: cubit.oneMeetModel.teamMeetRows!.elementAt(3)),
            buildCard(teamMeetRows: cubit.oneMeetModel.teamMeetRows!.elementAt(4)),

          ],

        ),
      ),
    );
  },
);
  }


  Widget buildCard({
    required TeamMeetRows teamMeetRows,
}

      ){
    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(

          children: [
            Center(child: Text(teamMeetRows.teamName!,style: GoogleFonts.aBeeZee(fontSize: 20),),),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text("${teamMeetRows.team1Name} : ",style: GoogleFonts.lalezar(fontSize: 17),),
                Text('${teamMeetRows.team1State}',style: GoogleFonts.aBeeZee(color: Colors.green,fontSize: 16),),
              ],
            ),
            const SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text("${teamMeetRows.team2Name} : ",style: GoogleFonts.lalezar(fontSize: 17),),
                Text('${teamMeetRows.team2State}',style: GoogleFonts.aBeeZee(color: Colors.green,fontSize: 16),),
              ],
            ),
            const SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text("${teamMeetRows.team3Name} : ",style: GoogleFonts.lalezar(fontSize: 17),),
                Text('${teamMeetRows.team3State}',style: GoogleFonts.aBeeZee(color: Colors.green,fontSize: 16),),
              ],
            ),
            const SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text("${teamMeetRows.team4Name} : ",style: GoogleFonts.lalezar(fontSize: 17),),
                Text('${teamMeetRows.team4State}',style: GoogleFonts.aBeeZee(color: Colors.green,fontSize: 16),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
