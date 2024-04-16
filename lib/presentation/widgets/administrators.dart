import 'package:flutter/material.dart';
import 'package:video_game_catalogue_app/presentation/data/accounts.dart';
import 'package:video_game_catalogue_app/presentation/widgets/admin_tier.dart';

class AdminContainer extends StatelessWidget {
  const AdminContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.brown[100],
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.brown, width: 3.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Administrators',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: accounts.length,
              itemBuilder: (context, index) {
                return AdminTier(
                    userName: accounts[index].userName,
                    userType: accounts[index].userType);
              },
            ),
          ),
        ],
      ),
    );
  }
}
