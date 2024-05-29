import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/game_provider.dart';
import '../../providers/user_session_provider.dart';
import '../widgets/games_list.dart';
import '../widgets/new_game_modal.dart';

class BrowsePage extends ConsumerWidget {
  const BrowsePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List> gamesListProvider =
        ref.watch(gameListProvider(ref.read(userSessionProvider).token!));
    return switch (gamesListProvider) {
      AsyncData(:final value) => Stack(
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.fromLTRB(18.0, 16.0, 16.0, 0.0),
                      child: const Text(
                        'Browse',
                        style: TextStyle(
                          fontSize: 28.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    (ref.read(userSessionProvider).role == 'admin' ||
                            ref.read(userSessionProvider).role == 'owner')
                        ? Positioned(
                            top: 5,
                            right: 20.0,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  constraints:
                                      const BoxConstraints(maxHeight: 600),
                                  backgroundColor: Colors.blueGrey[800],
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(25),
                                    ),
                                  ),
                                  builder: (context) => const NewGameModal(),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlue,
                                shape: const StadiumBorder(),
                                elevation: 0,
                              ),
                              icon: const Icon(
                                Icons.add,
                              ),
                              label: const Text(
                                'New Game',
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
                Expanded(
                    child: Stack(
                  children: [
                    value[0].isEmpty
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.description_outlined,
                                  color: Colors.grey.withOpacity(0.5),
                                  size: 100,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "No game found",
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : GamesList(value[0], value[1]),
                    Positioned(
                      bottom: 5,
                      right: 12.0,
                      child: ElevatedButton(
                        onPressed: () {
                          ref
                              .read(gameListProvider(
                                      ref.read(userSessionProvider).token!)
                                  .notifier)
                              .refresh();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent[900],
                          shape: const CircleBorder(),
                          elevation: 0,
                          padding: const EdgeInsets.all(16.0),
                        ),
                        child: const Icon(
                          Icons.sync,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                )),
              ],
            ),
          ],
        ),
      AsyncError() => const Center(child: Text("Error, please try again")),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}
