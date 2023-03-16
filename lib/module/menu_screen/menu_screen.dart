import 'package:flutter/material.dart';


class MenuItems{
  static  const add =   MenuItem('Add New Meet',Icons.add_box_outlined);
  static  const control =   MenuItem('Control',Icons.control_camera_outlined);

  static const all =<MenuItem>[
    add,
    control
  ];
}
class MenuItem{
  final String title;
  final IconData icon;
  const MenuItem(this.title,this.icon);
}

class MenuScreen extends StatelessWidget {
  final MenuItem currentItem;
  final ValueChanged<MenuItem> onSelectedItem;
  const MenuScreen({
    Key? key,
    required this.currentItem,
    required this.onSelectedItem
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        backgroundColor: Colors.indigo,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              ...MenuItems.all.map(buildMenuItem).toList(),
              Spacer(flex: 2,),

            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem(MenuItem item) {
    return ListTileTheme(
      selectedColor: Colors.white,
      child: ListTile(
        selected: currentItem == item,
        selectedTileColor: Colors.black26,
        minLeadingWidth: 20,
        leading: Icon(item.icon),
        title: Text(item.title),
        onTap: () => onSelectedItem(item),
      ),
    );
  }
}
