import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/user.dart';
import '../../providers/user_provider.dart';
import '../../providers/user_session_provider.dart';
import 'user_details_dialog.dart';

class RoleMgtPannel extends ConsumerStatefulWidget {
  const RoleMgtPannel({
    required this.users,
    super.key,
  });
  final List<User> users;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RoleMgtPannelState();
}

class _RoleMgtPannelState extends ConsumerState<RoleMgtPannel> {
  final Map<int, bool> roleState = {};

  @override
  void initState() {
    super.initState();
    for (var user in widget.users) {
      roleState[user.id!] = (user.role == "admin" || user.role == "owner");
    }
  }

  void saveChanges() {
    final modifierUserIds = <int>[];
    for (final user in widget.users) {
      final roleBoolean = user.role == "admin" || user.role == "owner";
      if (roleState[user.id!] != roleBoolean) {
        modifierUserIds.add(user.id!);
      }
    }
    if (modifierUserIds.isNotEmpty) {
      for (final userId in modifierUserIds) {
        if (roleState[userId] == true) {
          ref
              .read(userListProvider(ref.read(userSessionProvider).token!)
                  .notifier)
              .promoteUser(userId);
        } else {
          ref
              .read(userListProvider(ref.read(userSessionProvider).token!)
                  .notifier)
              .demoteUser(userId);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(
                label: Text(
                  "ID",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                tooltip: "User ID",
              ),
              DataColumn(
                label: Text(
                  "USERNAME",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                tooltip: "Username",
              ),
              DataColumn(
                label: Text(
                  "ADMIN",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                tooltip: "Is Admin?",
              )
            ],
            rows: [
              for (var user in widget.users)
                DataRow(cells: [
                  DataCell(
                    Text(
                      user.id.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  DataCell(
                    GestureDetector(
                      onTap: () => showDialog(
                          context: context,
                          builder: (context) => UserDetailsDialog(user)),
                      child: Text(
                        user.username,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  DataCell(
                    Switch.adaptive(
                      value: roleState[user.id]!,
                      activeColor: user.role == "owner"
                          ? Colors.grey[500]
                          : Colors.blue[300],
                      onChanged: (val) {
                        setState(() {
                          if (user.role != "owner") {
                            roleState[user.id!] = !roleState[user.id]!;
                          }
                        });
                      },
                    ),
                  ),
                ])
            ],
            headingRowColor: MaterialStateProperty.all(Colors.blueGrey[600]),
            border: TableBorder.all(color: Colors.grey),
            dataRowColor: MaterialStatePropertyAll(
                Colors.blueGrey[800]?.withOpacity(0.5)),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red[700]),
              ),
              label: const Text('Close'),
              icon: const Icon(Icons.close),
            ),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton.icon(
              onPressed: () {
                saveChanges();
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue[700]),
              ),
              label: const Text('Save changes'),
              icon: const Icon(Icons.save),
            ),
          ],
        ),
      ],
    );
  }
}
