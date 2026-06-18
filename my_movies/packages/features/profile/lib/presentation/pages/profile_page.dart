import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
    required this.profileBloc,
    required this.onHomeTap,
    required this.onSearchTap,
    required this.onFavoriteTap,
    required this.onLogout,
  });

  final ProfileBloc profileBloc;
  final VoidCallback onHomeTap;
  final VoidCallback onSearchTap;
  final VoidCallback onFavoriteTap;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => profileBloc..add(const ProfileStarted()),
      child: BlocListener<ProfileBloc, ProfileState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == ProfileStatus.loggedOut) {
            onLogout();
          }

          final message = state.message;
          if (state.status == ProfileStatus.failure && message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          }
        },
        child: Scaffold(
          extendBody: true,
          bottomNavigationBar: AppBottomNavBar(
            currentItem: AppBottomNavItem.profile,
            onItemSelected: (item) {
              switch (item) {
                case AppBottomNavItem.home:
                  onHomeTap();
                case AppBottomNavItem.search:
                  onSearchTap();
                case AppBottomNavItem.favorite:
                  onFavoriteTap();
                case AppBottomNavItem.profile:
                  break;
              }
            },
          ),
          body: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 96),
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  final username = state.username.trim().isEmpty
                      ? 'Guest'
                      : state.username.trim();
                  final initial = username.characters.first.toUpperCase();
                  final isLoggingOut = state.status == ProfileStatus.loggingOut;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Profile',
                        style: AppTextStyles.titleMd.copyWith(
                          color: AppColors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Center(
                        child: CircleAvatar(
                          radius: 42,
                          backgroundColor: AppColors.surfaceContainerHigh,
                          child: Text(
                            initial,
                            style: AppTextStyles.headlineLgMobile.copyWith(
                              color: AppColors.cinematicRed,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        username,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.titleMd.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        state.isGuest ? 'Guest Account' : 'TMDb Account',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodySm.copyWith(
                          color: AppColors.mutedSilver,
                        ),
                      ),
                      const Spacer(),
                      FilledButton.icon(
                        onPressed: isLoggingOut
                            ? null
                            : () {
                                context.read<ProfileBloc>().add(
                                  const ProfileLogoutRequested(),
                                );
                              },
                        icon: isLoggingOut
                            ? const SizedBox.square(
                                dimension: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.white,
                                ),
                              )
                            : const Icon(Icons.logout_rounded),
                        label: Text(isLoggingOut ? 'Logout...' : 'Logout'),
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          backgroundColor: AppColors.cinematicRed,
                          foregroundColor: AppColors.white,
                          disabledBackgroundColor: AppColors.cinematicRed
                              .withValues(alpha: 0.55),
                          disabledForegroundColor: AppColors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: AppRadius.regularBorder,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
