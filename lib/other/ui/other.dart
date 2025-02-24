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
    // this is notifier provider
    final isDark = ref.watch(themeNotifierProvider);

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
                  Icon(Icons.settings, color: Colors.black),
                  SizedBox(width: 10),
                  Text('Settings', style: TextStyle(color: Colors.black)),
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
                      Icon(Icons.dark_mode, color: Colors.black),
                      SizedBox(width: 10),
                      Text('Dark mode', style: TextStyle(color: Colors.black)),
                    ],
                  ),
                  Switch(
                    value: isDark, //NOTE: load the value from main file
                    onChanged: (bool value) {
                      ref.read(themeNotifierProvider.notifier).toggleTheme();
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
                      Icon(Icons.insert_chart, color: Colors.black),
                      SizedBox(width: 10),
                      Text(
                        'Annual report',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Icon(Icons.pie_chart, color: Colors.black),
                      SizedBox(width: 10),
                      Text(
                        'Category annual report',
                        style: TextStyle(color: Colors.black),
                      ), // TODO: start from here
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Icon(Icons.insert_chart, color: Colors.black),
                      SizedBox(width: 10),
                      Text(
                        'All time report',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Icon(Icons.pie_chart, color: Colors.black),
                      SizedBox(width: 10),
                      Text(
                        'All time Category report',
                        style: TextStyle(color: Colors.black),
                      ),
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
                      Icon(Icons.tv, color: Colors.black),
                      SizedBox(width: 10),
                      Text('Remove Ads', style: TextStyle(color: Colors.black)),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Icon(Icons.restore, color: Colors.black),
                      SizedBox(width: 10),
                      Text(
                        'Restore previous ads removal',
                        style: TextStyle(color: Colors.black),
                      ),
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
                      Icon(Icons.download, color: Colors.black),
                      SizedBox(width: 10),
                      Text(
                        'Data output',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Icon(Icons.system_update_alt, color: Colors.black),
                      SizedBox(width: 10),
                      Text(
                        'Data backup / Restore',
                        style: TextStyle(color: Colors.black),
                      ),
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
                      Icon(Icons.help, color: Colors.black),
                      SizedBox(width: 10),
                      Text('Help/ FAQ', style: TextStyle(color: Colors.black)),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Icon(Icons.info, color: Colors.black),
                      SizedBox(width: 10),
                      Text(
                        'App Information',
                        style: TextStyle(color: Colors.black),
                      ),
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
