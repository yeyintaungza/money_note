import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'theme_preference.dart';

class OtherPage extends ConsumerStatefulWidget {
  const OtherPage({super.key});

  @override
  ConsumerState<OtherPage> createState() => _OtherPageState();
}

class _OtherPageState extends ConsumerState<OtherPage> {
  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 5,
        shadowColor: Colors.black87,
        title: Row(children: [const Text('Other')]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: ListView(
          children: [
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  Icon(Icons.settings),
                  SizedBox(width: 10),
                  Text('Settings'),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.dark_mode),
                      SizedBox(width: 10),
                      Text('Dark mode'),
                    ],
                  ),
                  Switch(
                    value: isDark, //NOTE: load the value from main file
                    onChanged: (bool value) {
                      ref.read(themeProvider.notifier).toggleTheme();
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.insert_chart),
                      SizedBox(width: 10),
                      Text('Annual report'),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Icon(Icons.pie_chart),
                      SizedBox(width: 10),
                      Text('Category annual report'), // TODO: start from here
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Icon(Icons.insert_chart),
                      SizedBox(width: 10),
                      Text('All time report'),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Icon(Icons.pie_chart),
                      SizedBox(width: 10),
                      Text('All time Category report'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.tv),
                      SizedBox(width: 10),
                      Text('Remove Ads'),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Icon(Icons.restore),
                      SizedBox(width: 10),
                      Text('Restore previous ads removal'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.download),
                      SizedBox(width: 10),
                      Text('Data output'),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Icon(Icons.system_update_alt),
                      SizedBox(width: 10),
                      Text('Data backup / Restore'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.help),
                      SizedBox(width: 10),
                      Text('Help/ FAQ'),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Icon(Icons.info),
                      SizedBox(width: 10),
                      Text('App Information'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
