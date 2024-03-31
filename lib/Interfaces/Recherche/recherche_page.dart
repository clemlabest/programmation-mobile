import 'package:flutter/material.dart';

class MySearchPage extends StatefulWidget {
  const MySearchPage({super.key});

  @override
  State<MySearchPage> createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF15232E),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (searchText.contains('comics'))
                    ...[ ],
                  if (searchText.contains('films'))
                    ...[ ],
                  if (searchText.contains('séries'))
                    ...[ ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
