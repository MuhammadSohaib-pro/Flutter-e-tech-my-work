import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to the Boat Booking App!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'How to Book a Boat:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text('- Navigate to the "Home" tab.'),
            Text('- Choose the desired date and time for your boat ride.'),
            // Text('- Select the type of boat and the number of passengers.'),
            Text('- Tap on the "Book Now" button to confirm your booking.'),
            SizedBox(height: 16),
            Text(
              'How to View Your Bookings:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text('- Go to the "My Bookings" tab to view your upcoming and past bookings.'),
            SizedBox(height: 16),
            Text(
              'Contact Support:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text('If you need further assistance, please contact our support team at support@boatbookingapp.com'),
          ],
        ),
      ),
    );
  }
}
