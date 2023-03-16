import 'package:bloc/bloc.dart';
import 'package:family_controller/layout/cubit/family_controller_cubit.dart';
import 'package:family_controller/module/control_family/control_family.dart';
import 'package:family_controller/module/menu_screen/menu_screen.dart';
import 'package:family_controller/shared/network/local/cache_helper.dart';
import 'package:family_controller/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'bloc_observer.dart';
import 'module/add_family_screen/add_family_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  await DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FamilyControllerCubit(),
        ),
      ],
      child: BlocConsumer<FamilyControllerCubit, FamilyControllerState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = FamilyControllerCubit.get(context);
          return MaterialApp(
            title: 'Filey',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
            ),
            home: ZoomDrawer(
              borderRadius: 40,
              angle: -5,
              showShadow: true,

              menuScreen: Builder(
                builder: (context) => MenuScreen(
                    currentItem: cubit.currentItem,
                    onSelectedItem: (item) {
                      cubit.changeMenuItem(item, context);
                    }),
              ),

              mainScreen: getScreen(cubit),
              menuBackgroundColor: Colors.indigo,
            ),
          );
        },
      ),
    );
  }

  Widget getScreen(FamilyControllerCubit cubit) {
    switch (cubit.currentItem) {
      case MenuItems.add:
        return AddFamilyScreen();
      case MenuItems.control:
        return ControlFamily();
      default:
        return AddFamilyScreen();
    }
  }
}
