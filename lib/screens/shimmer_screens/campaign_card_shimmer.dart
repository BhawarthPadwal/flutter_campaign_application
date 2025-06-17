import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerCampaignCard() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
    child: Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Placeholder
            Container(
              width: double.infinity,
              height: 18,
              color: Colors.white,
            ),
            SizedBox(height: 8),
            // Description Placeholder
            Container(
              width: double.infinity,
              height: 14,
              color: Colors.white,
            ),
            SizedBox(height: 6),
            Container(
              width: 150,
              height: 14,
              color: Colors.white,
            ),
            SizedBox(height: 16),
            // Bottom row (start date, end date, etc.)
            Row(
              children: [
                Container(
                  width: 80,
                  height: 12,
                  color: Colors.white,
                ),
                SizedBox(width: 16),
                Container(
                  width: 80,
                  height: 12,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
