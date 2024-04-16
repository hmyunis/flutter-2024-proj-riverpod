import 'package:flutter/material.dart';

class AdminTier extends StatefulWidget {
  const AdminTier({
    Key? key,
    required this.userName,
    required this.userType,
  }) : super(key: key);

  final String userName;
  final String userType;

  @override
  State<AdminTier> createState() => _AdminTierState();
}

class _AdminTierState extends State<AdminTier> {
  late bool _isAdminOrOwner;

  @override
  void initState() {
    super.initState();
    _isAdminOrOwner =
        (widget.userType == "Owner" || widget.userType == "Admin");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightGreen[100],
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.green),
      ),
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.userName,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.green[800],
            ),
          ),
          Switch(
            value: _isAdminOrOwner,
            onChanged: (value) {
              if (widget.userType != "Owner") {
                setState(() {
                  _isAdminOrOwner = value;
                });
              }
            },
            activeColor: Colors.green,
          ),
        ],
      ),
    );
  }
}
