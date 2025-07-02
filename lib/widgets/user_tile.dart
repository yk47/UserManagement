// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../utils/app_styles.dart';

class UserTile extends StatelessWidget {
  final User user;
  final VoidCallback onTap;

  const UserTile({super.key, required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppStyles.paddingSmall),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppStyles.borderRadiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppStyles.borderRadiusMedium),
        child: Container(
          padding: const EdgeInsets.all(AppStyles.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Avatar
              Center(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF4A6CF7), Color(0xFF7B68EE)],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF4A6CF7).withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: AppStyles.isMobile(context) ? 25 : 30,
                        backgroundColor: Colors.transparent,
                        child: Text(
                          user.name?.isNotEmpty == true
                              ? user.name![0].toUpperCase()
                              : 'U',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: AppStyles.isMobile(context) ? 20 : 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    // Show indicator for locally added users (ID > 10 means local)
                    if (user.id != null && user.id! > 10)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 8,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: AppStyles.paddingMedium),

              // User Name
              Text(
                user.name ?? 'Unknown',
                style:
                    AppStyles.isMobile(context)
                        ? AppStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        )
                        : AppStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppStyles.paddingSmall),

              // User Email
              Text(
                user.email ?? 'No email',
                style:
                    AppStyles.isMobile(context)
                        ? AppStyles.bodySmall
                        : AppStyles.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppStyles.paddingSmall),

              // User Phone
              if (user.phone != null) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.phone,
                      size: AppStyles.isMobile(context) ? 14 : 16,
                      color: const Color(0xFF4A6CF7),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        user.phone!,
                        style:
                            AppStyles.isMobile(context)
                                ? AppStyles.bodySmall
                                : AppStyles.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
