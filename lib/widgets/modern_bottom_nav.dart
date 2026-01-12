import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../generated/l10n/app_localizations.dart';

class ModernBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const ModernBottomNav({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, -3),
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Row(
          children: [
            _buildNavItem(
              context,
              icon: Icons.home_rounded,
              label: AppLocalizations.of(context).home,
              index: 0,
              isSelected: currentIndex == 0,
            ),
            _buildNavItem(
              context,
              icon: Icons.work_rounded,
              label: AppLocalizations.of(context).jobs,
              index: 1,
              isSelected: currentIndex == 1,
            ),
            _buildNavItem(
              context,
              icon: Icons.assignment_rounded,
              label: AppLocalizations.of(context).activity,
              index: 2,
              isSelected: currentIndex == 2,
            ),
            _buildNavItem(
              context,
              icon: Icons.play_circle_rounded,
              label: AppLocalizations.of(context).video,
              index: 3,
              isSelected: currentIndex == 3,
            ),
            _buildNavItem(
              context,
              icon: Icons.person_rounded,
              label: AppLocalizations.of(context).profile,
              index: 4,
              isSelected: currentIndex == 4,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required int index,
    required bool isSelected,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        behavior: HitTestBehavior.opaque,
        child: Container(
          height: 65,
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon with animated background
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: isSelected 
                      ? AppColors.primary.withOpacity(0.12)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: isSelected 
                      ? AppColors.primary 
                      : AppColors.iconColor.withOpacity(0.65),
                ),
              ),
              const SizedBox(height: 2),
              // Label
              Text(
                label,
                style: TextStyle(
                  fontSize: 8.5,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected 
                      ? AppColors.primary 
                      : AppColors.bodyText.withOpacity(0.7),
                  letterSpacing: 0.1,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              // Active indicator
              Container(
                margin: const EdgeInsets.only(top: 1),
                height: 2,
                width: isSelected ? 12 : 0,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}