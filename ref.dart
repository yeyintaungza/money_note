import 'package:flutter/material.dart';

class IconGridView extends StatefulWidget {
  @override
  _IconGridViewState createState() => _IconGridViewState();
}

class _IconGridViewState extends State<IconGridView> {
  int _selectedGridItem = -1;

  // Example list of icon names (could be any icon name or identifiers)
  final List<Map<String, dynamic>> iconData = [
    {'icon': Icons.home, 'label': 'Home'},
    {'icon': Icons.business, 'label': 'Business'},
    {'icon': Icons.school, 'label': 'School'},
    {'icon': Icons.settings, 'label': 'Settings'},
    {'icon': Icons.account_balance, 'label': 'Balance'},
    {'icon': Icons.access_alarm, 'label': 'Alarm'},
    {'icon': Icons.star, 'label': 'Star'},
    {'icon': Icons.favorite, 'label': 'Favorite'},
    {'icon': Icons.search, 'label': 'Search'},
    {'icon': Icons.shopping_cart, 'label': 'Cart'},
    {'icon': Icons.camera, 'label': 'Camera'},
    {
      'icon': Icons.edit,
      'label': 'Edit',
    }, // last icon to navigate to a new page
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GridView.count(
        crossAxisCount: 4, // 4 items per row
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        shrinkWrap: true, // Prevents it from being scrollable
        physics: const NeverScrollableScrollPhysics(), // Disables scrolling
        children: List.generate(iconData.length, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedGridItem = index;

                if (index == 11) {
                  // Check for the last icon (Edit)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => EditCategories(), // Your target screen
                    ),
                  );
                }
              });
            },
            child: Container(
              decoration: BoxDecoration(
                // Selected item border with theme color (lightBlueAccent)
                border: Border.all(
                  color:
                      _selectedGridItem == index
                          ? Colors.lightBlueAccent
                          : Colors.black12,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      iconData[index]['icon'],
                      color:
                          _selectedGridItem == index
                              ? Colors.lightBlueAccent
                              : Colors.black12,
                      size: 30, // Icon size
                    ),
                    const SizedBox(height: 4),
                    Text(
                      iconData[index]['label'],
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// Example EditCategories page
class EditCategories extends StatelessWidget {
  const EditCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Categories')),
      body: const Center(child: Text('Edit Categories Page')),
    );
  }
}
