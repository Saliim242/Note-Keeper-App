import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:note_keeper/app/components/error_message.dart';
import 'package:note_keeper/app/components/notes_Card.dart';
import 'package:note_keeper/app/components/search_text_feild.dart';
import 'package:note_keeper/app/utils/events/user_events.dart';

import '../../../components/summer_Card.dart';
import '../../../utils/exports.dart';
import '../../user/controllers/user_controller.dart';
import '../controllers/home_controller.dart';
import '../model/notes_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with AfterLayoutMixin<HomeView> {
  final TextEditingController _searchController = TextEditingController();
  String? _error;
  String _query = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: NAppColor.kbgColor2,
          automaticallyImplyLeading: false,
          titleSpacing: NSizes.md,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Notes',
                style: style(
                  color: NAppColor.kTextStyleColor,
                  fontWeight: FontWeight.w600,
                  fontSize: NSizes.fontSizeLg,
                ),
              ),
              Text(
                'Capture ideas before they fade.',
                style: style(
                  color: NAppColor.kTextStyleColorGray,
                  fontSize: NSizes.fontSizeSm,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: NSizes.sm),
              decoration: BoxDecoration(
                color: NAppColor.kbgColor2,
                borderRadius: BorderRadius.circular(NSizes.cardRadiusMd),
                border: Border.all(color: NAppColor.borderSecondary),
              ),
              child: IconButton(
                tooltip: 'Refresh notes',
                color: NAppColor.kSecondColor,
                onPressed: () {},
                icon: const Icon(Icons.refresh_rounded),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: NSizes.md),
              decoration: BoxDecoration(
                color: NAppColor.kSecondColor,
                borderRadius: BorderRadius.circular(NSizes.cardRadiusMd),
              ),
              child: IconButton(
                tooltip: 'Logout',
                color: Colors.white,
                onPressed: () {
                  // final user = Get.find<UserController>();
                  // user.logout(
                  //   onSuccess: () {
                  //     Navigator.pushNamedAndRemoveUntil(
                  //       context,
                  //       Routes.USER,
                  //       (route) => false,
                  //     );
                  //   },
                  // );
                },
                icon: const Icon(Icons.logout_rounded),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: NAppColor.kPrimaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
          onPressed: () async {
            // final created = await Navigator.push<bool>(
            //   context,
            //   MaterialPageRoute(
            //     builder: (_) => const CreateNewNoteOrEditNote(),
            //   ),
            // );

            // if (created == true) {
            //   getNoteStatistics();
            // }
          },
          child: const Icon(Icons.add_rounded),
        ),
        body: SafeArea(
          child: GetBuilder<HomeController>(
            builder: (controller) {
              final visibleCount = _filteredNotes(controller.notes).length;

              return RefreshIndicator(
                color: NAppColor.kPrimaryColor,
                onRefresh: () {
                  // return getAllNotes();
                  return Future.delayed(const Duration(seconds: 1));
                },
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              Gap(NSizes.spaceBtwSections),
                              SearchField(
                                controller: _searchController,
                                onChanged: (value) {
                                  setState(() => _query = value.trim());
                                },
                              ),
                              const Gap(NSizes.md),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: SummaryCard(
                                          title: 'Total Notes',
                                          value:
                                              '${controller.statistcs.totalNotes}',
                                          icon: Icons.sticky_note_2_rounded,
                                          color: NAppColor.kPrimaryColor,
                                        ),
                                      ),
                                      const Gap(NSizes.sm),
                                      Expanded(
                                        child: SummaryCard(
                                          title: 'Pinned',
                                          value:
                                              '${controller.statistcs.pinnedNotes}',
                                          icon: Icons.push_pin_rounded,
                                          color: const Color(0xff16a085),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Gap(NSizes.sm),
                                  SummaryCard(
                                    title: 'UnPinned',
                                    value:
                                        '${controller.statistcs.unpinnedNotes}',
                                    icon: Icons.push_pin_rounded,
                                    color: const Color(0xff16a085),
                                  ),
                                ],
                              ),
                              const Gap(NSizes.lg),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _query.isEmpty
                                        ? 'Recent Notes'
                                        : 'Search Results',
                                    style: style(
                                      fontSize: NSizes.fontSizeLg,
                                      color: NAppColor.kTextStyleColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    ' shown',
                                    style: style(
                                      fontSize: NSizes.fontSizeSm,
                                      color: NAppColor.kTextStyleColorGray,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Gap(NSizes.spaceBtwItems),

                              GetBuilder<HomeController>(
                                builder: (note) {
                                  switch (note.allNotes) {
                                    case GetAllNotes.loading:
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: 1,
                                        itemBuilder: (context, index) => Center(
                                          child:
                                              const CircularProgressIndicator.adaptive(),
                                        ),
                                      );
                                    case GetAllNotes.networkError:
                                      return MessageState(
                                        icon: Icons.cloud_off_rounded,
                                        title: 'Please Check Your Internet.',
                                        message: _error!,
                                      );

                                    case GetAllNotes.error:
                                      return MessageState(
                                        icon: Icons.cloud_off_rounded,
                                        title: 'Could not load notes',
                                        message: _error!,
                                      );
                                    case GetAllNotes.success:
                                      final visibleNotes = _filteredNotes(
                                        note.notes,
                                      );
                                      if (visibleNotes.isEmpty) {
                                        return MessageState(
                                          icon: Icons.note_add_rounded,
                                          title: _query.isEmpty
                                              ? 'No notes yet'
                                              : 'No matches found',
                                          message: _query.isEmpty
                                              ? 'Tap the add button when you are ready to create one.'
                                              : 'Try searching by title, content, or tag.',
                                        );
                                      } else {
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: visibleNotes.length,
                                          itemBuilder: (context, index) {
                                            final notes = visibleNotes[index];
                                            return GestureDetector(
                                              onTap: () async {
                                                // final updated =
                                                //     await Navigator.push<bool>(
                                                //       context,
                                                //       MaterialPageRoute(
                                                //         builder: (_) =>
                                                //             CreateNewNoteOrEditNote(
                                                //               note: notes,
                                                //             ),
                                                //       ),
                                                //     );

                                                // if (updated == true) {
                                                //   getAllNotes();
                                                //   getNoteStatistics();
                                                // }
                                              },
                                              child: NoteCard(
                                                note: notes,
                                                accentColor:
                                                    noteColors[index %
                                                        noteColors.length],
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    default:
                                      return SizedBox.shrink();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  List<NotesModel> _filteredNotes(List<NotesModel> notes) {
    if (_query.isEmpty) return notes;

    final query = _query.toLowerCase();
    return notes.where((note) {
      final title = note.title?.toLowerCase() ?? '';
      final content = note.content?.toLowerCase() ?? '';
      final tags = (note.tags ?? []).join(' ').toLowerCase();
      return title.contains(query) ||
          content.contains(query) ||
          tags.contains(query);
    }).toList();
  }

  Future<void> getAllNotes() async {
    final notes = Get.find<HomeController>();

    await notes.getAllNotes(
      onSuccess: (_) {
        if (!mounted) return;
        setState(() => _error = null);
      },
      onError: (error) {
        if (!mounted) return;
        debugPrint('Error loading notes: $error');
        setState(() => _error = error);
      },
    );
  }

  Future<void> getNoteStatistics() async {
    final stats = Get.find<HomeController>();

    await stats.getNoteStatistics(
      onSuccess: (_) {
        if (!mounted) return;
        // setState(() => _error = null);
      },
      onError: (error) {
        if (!mounted) return;
        debugPrint('Error loading notes: $error');
        // setState(() => _error = error);
      },
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    getAllNotes();
    getNoteStatistics();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
