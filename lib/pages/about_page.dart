
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About VickyClone')),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'About WikiClone',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'WikiClone is an online encyclopedia that offers free access to a wealth of knowledge on a wide array of topics. Our platform is built on the principles of open collaboration and community-driven content creation.',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              Text(
                'Key Features:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '- Comprehensive Articles: Covering diverse subjects from history to science and technology.',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                '- Community Editing: Empowering users to contribute and enhance the information provided, ensuring accuracy and up-to-dateness.',
                style: TextStyle(fontSize: 18),
              ),
              // Add more features as needed
            ],
          ),
        ),
      ),
    );
  }
}
