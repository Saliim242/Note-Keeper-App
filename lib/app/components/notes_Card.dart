import 'package:flutter/material.dart';
import 'package:note_keeper/app/modules/home/model/notes_model.dart';

import '../utils/exports.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.note, required this.accentColor});

  final NotesModel note;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final tags = note.tags ?? [];

    return Container(
      padding: const EdgeInsets.all(NSizes.md),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: NAppColor.kbgColor2,
        borderRadius: BorderRadius.circular(NSizes.cardRadiusLg),
        border: Border.all(color: NAppColor.borderSecondary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 5,
                height: 54,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(NSizes.cardRadiusXs),
                ),
              ),
              const SizedBox(width: NSizes.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            note.title ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: style(
                              fontSize: NSizes.fontSizeLg - 2,
                              color: NAppColor.kTextStyleColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        if (note.isPinned == true)
                          Container(
                            margin: const EdgeInsets.only(left: NSizes.sm),
                            padding: const EdgeInsets.all(NSizes.xs),
                            decoration: BoxDecoration(
                              color: accentColor.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(
                                NSizes.cardRadiusSm,
                              ),
                            ),
                            child: Icon(
                              Icons.push_pin_rounded,
                              size: NSizes.iconSm,
                              color: accentColor,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: NSizes.xs),
                    Text(
                      formatDate(note.updatedAt ?? note.createdAt),
                      style: style(
                        fontSize: NSizes.fontSizeSm,
                        color: NAppColor.kTextStyleColorGray,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: NSizes.md),
          Text(
            note.content ?? "",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: style(
              fontSize: NSizes.fontSizeMd,
              color: NAppColor.kSecondColor.withValues(alpha: 0.72),
              height: 1.45,
            ),
          ),
          if (tags.isNotEmpty) ...[
            const SizedBox(height: NSizes.md),
            Wrap(
              spacing: NSizes.sm,
              runSpacing: NSizes.sm,
              children: tags.take(3).map((tag) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: NSizes.sm,
                    vertical: NSizes.xs,
                  ),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    '# $tag',
                    style: style(
                      fontSize: NSizes.fontSizeSm,
                      color: accentColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}
