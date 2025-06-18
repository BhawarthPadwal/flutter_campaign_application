import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerCampaignCard(BuildContext context) {
  final theme = Theme.of(context);
  final isDark = theme.brightness == Brightness.dark;

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
    child: Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[700]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[500]! : Colors.grey[100]!,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 18,
              color: theme.cardColor,
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 14,
              color: theme.cardColor,
            ),
            const SizedBox(height: 6),
            Container(
              width: 150,
              height: 14,
              color: theme.cardColor,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  width: 80,
                  height: 12,
                  color: theme.cardColor,
                ),
                const SizedBox(width: 16),
                Container(
                  width: 80,
                  height: 12,
                  color: theme.cardColor,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
