import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'date_provider.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dateProvider = Provider.of<DateProvider>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (dateProvider.showFirstButton)
              ElevatedButton(
                onPressed: () async {
                  await dateProvider.storeCurrentDate();
                },
                child: const Text('First Button'),
              ),
            if (dateProvider.showSecondButton)
              ElevatedButton(
                onPressed: () {
                  // Handle second button logic here
                },
                child: const Text('Second Button'),
              ),
          ],
        ),
      ),
    );
  }}