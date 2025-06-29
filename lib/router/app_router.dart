import 'package:app/router/app_router.gr.dart';
import 'package:app/router/features/lens/lens_routes.dart';
import 'package:app/router/features/space/space_routes.dart';
import 'package:auto_route/auto_route.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/login',
          page: LoginRoute.page,
          fullscreenDialog: true,
        ),
        AutoRoute(
          path: '/shorebird-update',
          page: ShorebirdUpdateRoute.page,
          fullscreenDialog: true,
        ),
        AutoRoute(
          path: '/',
          page: RootRoute.page,
          children: [
            AutoRoute(
              initial: true,
              path: 'home',
              page: HomeRoute.page,
            ),
            AutoRoute(
              path: 'discover',
              page: DiscoverRoute.page,
            ),
            AutoRoute(
              path: 'home-spaces',
              page: HomeSpaceListingRoute.page,
            ),
            AutoRoute(
              page: ChatStackRoute.page,
              path: 'chat',
              children: [
                AutoRoute(
                  initial: true,
                  path: 'list',
                  page: ChatListRoute.page,
                ),
              ],
            ),
            AutoRoute(
              path: '404',
              page: EmptyRoute.page,
            ),
          ],
        ),
        AutoRoute(
          path: '/notification',
          page: NotificationRoute.page,
        ),
        AutoRoute(
          path: '/claim-token-reward',
          page: ClaimTokenRewardRoute.page,
        ),
        AutoRoute(
          path: '/me',
          page: MyProfileRoute.page,
        ),
        AutoRoute(
          path: '/profile/:id',
          page: ProfileRoute.page,
        ),
        AutoRoute(
          path: '/poap',
          page: PoapListingRoute.page,
        ),
        AutoRoute(
          page: OnboardingWrapperRoute.page,
          children: [
            AutoRoute(
              page: OnboardingTermAdultRoute.page,
              meta: const {
                'popBlocked': true,
              },
            ),
            AutoRoute(
              page: OnboardingTermConditionsRoute.page,
              meta: const {
                'popBlocked': true,
              },
            ),
            AutoRoute(
              page: OnboardingUsernameRoute.page,
            ),
            AutoRoute(
              page: OnboardingConnectWalletRoute.page,
            ),
            AutoRoute(
              page: CreateLensAccountRoute.page,
            ),
            AutoRoute(
              page: OnboardingProfilePhotoRoute.page,
            ),
            AutoRoute(
              page: OnboardingSocialOnChainRoute.page,
            ),
            AutoRoute(
              page: OnboardingAboutRoute.page,
            ),
          ],
        ),
        AutoRoute(
          page: EditProfileRoute.page,
        ),
        AutoRoute(page: CreatePopUpRoute.page),
        AutoRoute(page: SettingRoute.page),
        AutoRoute(page: AccountSettingRoute.page),
        AutoRoute(page: NotificationSettingRoute.page),
        AutoRoute(page: CommunityRoute.page),
        AutoRoute(page: QrCodeRoute.page),
        AutoRoute(page: SettingBlockRoute.page),
        AutoRoute(page: LocationRequestRoute.page),
        AutoRoute(page: AIRoute.page),
        AutoRoute(page: MyEventsRoute.page),
        AutoRoute(path: '/chat/detail/:id', page: ChatRoute.page),
        AutoRoute(
          path: '/pending-invites',
          page: HomePendingInvitesRoute.page,
        ),
        AutoRoute(
          page: EventPreviewRoute.page,
        ),
        AutoRoute(
          page: EventPublishingRoute.page,
        ),
        AutoRoute(
          page: EventVotingDetailRoute.page,
        ),
        eventBuyTicketsRoutes,
        createEventRoutes,
        eventDetailRoutes,
        vaultRoutes,
        collaboratorRoutes,
        questRoutes,
        createDuplicatedSubEventsRoutes,
        ...chatRoutes,
        ...postRoutes,
        ...eventRoutes,
        ...commonRoutes,
        ...farcasterRoutes,
        ...spaceRoutes,
        ...lensRoutes,
      ];
}

final postRoutes = [
  AutoRoute(
    page: CreatePostRoute.page,
  ),
  AutoRoute(page: PostDetailRoute.page),
];

final chatRoutes = [
  AutoRoute(path: '/chat/detail/:id', page: ChatRoute.page),
  AutoRoute(
    path: '/chat/setting/:id',
    page: ChatSettingRoute.page,
  ),
  AutoRoute(
    path: '/chat/create_guild',
    page: CreateGuildChannelRoute.page,
    children: [
      AutoRoute(
        initial: true,
        page: CreateGuildChannelBaseRoute.page,
      ),
      AutoRoute(
        page: CreateGuildChannelCommunityGatedRoute.page,
      ),
      AutoRoute(
        page: CreateGuildChannelAccessRoute.page,
      ),
      AutoRoute(
        page: CreateGuildProcessingRoute.page,
      ),
    ],
  ),
];

final eventRoutes = [
  AutoRoute(
    path: '/events',
    page: EventsListingRoute.page,
  ),
  AutoRoute(
    page: EventSelectingRoute.page,
  ),
  AutoRoute(
    page: RSVPEventSuccessPopupRoute.page,
  ),
  AutoRoute(
    page: MyEventTicketsListRoute.page,
  ),
  AutoRoute(
    page: MyEventTicketRoute.page,
  ),
  AutoRoute(
    page: MyEventTicketAssignmentRoute.page,
  ),
];

final eventDetailRoutes = AutoRoute(
  page: EventDetailRoute.page,
  path: '/event/:id',
  children: [
    AutoRoute(
      initial: true,
      page: EventDetailBaseRoute.page,
    ),
    AutoRoute(
      page: ScanQRCheckinRewardsRoute.page,
    ),
    AutoRoute(
      page: CheckInGuestListRoute.page,
    ),
    AutoRoute(
      page: ClaimSplitRelayPaymentRoute.page,
    ),
    AutoRoute(
      path: 'claimRewards/:user_id',
      page: ClaimRewardsRoute.page,
    ),
    AutoRoute(
      page: HostEventPublishFlowRoute.page,
    ),
    AutoRoute(
      page: GuestEventRewardUsesRoute.page,
    ),
    // TODO: I dont know why we place this route here
    // should be already child of EventSettingsRoute
    // AutoRoute(
    //   page: EventTicketTierSettingRoute.page,
    //   children: [
    //     AutoRoute(
    //       initial: true,
    //       page: EventTicketTiersListingRoute.page,
    //     ),
    //     AutoRoute(
    //       page: EventCreateTicketTierRoute.page,
    //     ),
    //   ],
    // ),
    AutoRoute(
      page: EventSettingsRoute.page,
      children: [
        AutoRoute(
          initial: true,
          page: EventSettingsBaseRoute.page,
        ),
        AutoRoute(
          page: EventGuestSettingsRoute.page,
        ),
        AutoRoute(
          page: EventDatetimeSettingsRoute.page,
        ),
        AutoRoute(
          page: EventLocationSettingRoute.page,
        ),
        AutoRoute(
          page: EventLocationSettingDetailRoute.page,
        ),
        CustomRoute(
          page: EventCohostsSettingRoute.page,
          transitionsBuilder: TransitionsBuilders.slideBottom,
        ),
        CustomRoute(
          page: EventAddCohostsRoute.page,
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          page: EventReorderingCohostsRoute.page,
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        AutoRoute(
          page: EventSpeakersRoute.page,
        ),
        AutoRoute(
          page: EventAddSpeakersRoute.page,
        ),
        AutoRoute(
          page: EventTicketTierSettingRoute.page,
          children: [
            AutoRoute(
              initial: true,
              page: EventTicketTiersListingRoute.page,
            ),
            AutoRoute(
              page: EventCreateTicketTierRoute.page,
            ),
            AutoRoute(
              page: EventActiveCryptoPaymentAccountsRoute.page,
            ),
          ],
        ),
        AutoRoute(
          page: EventApplicationFormSettingRoute.page,
        ),
        AutoRoute(
          page: EventApplicationFormProfileSettingRoute.page,
        ),
        AutoRoute(
          page: EventDiscountSettingRoute.page,
          children: [
            AutoRoute(
              initial: true,
              page: EventDiscountListingSetttingRoute.page,
            ),
            AutoRoute(
              page: EventDiscountFormSettingRoute.page,
            ),
          ],
        ),
        AutoRoute(
          page: EventPhotosSettingRoute.page,
        ),
        AutoRoute(
          page: EventSubEventsSettingRoute.page,
        ),
        AutoRoute(
          page: EventDescriptionFieldRoute.page,
        ),
        // AutoRoute(
        //   page: EventTeamMembersSettingRoute.page,
        //   children: [
        //     AutoRoute(
        //       initial: true,
        //       page: EventTeamMembersListingRoute.page,
        //     ),
        //     AutoRoute(
        //       page: EventTeamMembersFormRoute.page,
        //     ),
        //   ],
        // ),
      ],
    ),
    AutoRoute(
      page: EventApprovalSettingRoute.page,
    ),
    AutoRoute(
      page: EventJoinRequestDetailRoute.page,
    ),
    AutoRoute(page: ChatRoute.page),
    AutoRoute(
      page: ChatSettingRoute.page,
    ),
    AutoRoute(
      page: EventIssueTicketsSettingRoute.page,
      children: [
        AutoRoute(
          initial: true,
          page: EventIssueTicketsFormRoute.page,
        ),
        AutoRoute(
          page: EventIssueTicketsSummaryRoute.page,
        ),
        AutoRoute(
          page: EventIssueTicketsProcessingRoute.page,
        ),
      ],
    ),
    AutoRoute(
      page: EventInviteSettingRoute.page,
      children: [
        AutoRoute(
          initial: true,
          page: EventInviteFormRoute.page,
        ),
        AutoRoute(
          page: EventInviteProcessingRoute.page,
        ),
      ],
    ),
    AutoRoute(
      page: EventProgramRoute.page,
    ),
    AutoRoute(
      page: GuestEventApplicationRoute.page,
      children: [
        AutoRoute(
          initial: true,
          page: GuestEventApplicationInfoRoute.page,
        ),
        AutoRoute(
          page: GuestEventApplicationFormRoute.page,
        ),
        AutoRoute(
          page: GuestEventApplicationFormProcessingRoute.page,
        ),
      ],
    ),
    AutoRoute(
      page: GuestEventApprovalStatusRoute.page,
    ),
    AutoRoute(
      page: GuestEventStoriesRoute.page,
    ),
    AutoRoute(
      page: GuestEventGuestDirectoryRoute.page,
    ),
    AutoRoute(
      page: GuestEventPrivateAlertRoute.page,
    ),
    AutoRoute(
      page: EventDashboardRoute.page,
    ),
    AutoRoute(
      page: CreateFarcasterCastRoute.page,
    ),
    AutoRoute(
      page: SubEventsListingRoute.page,
    ),
    AutoRoute(
      page: EventRewardSettingRoute.page,
      children: [
        AutoRoute(
          initial: true,
          page: EventRewardsListingRoute.page,
        ),
        AutoRoute(
          page: EventCreateRewardRoute.page,
        ),
      ],
    ),
    AutoRoute(
      page: EventDetailClaimTokenRewardRoute.page,
    ),
    AutoRoute(
      page: ClaimTokenRewardRoute.page,
    ),
    AutoRoute(
      page: EventPaymentLedgerRoute.page,
    ),
    AutoRoute(
      page: EventGuestDetailRoute.page,
    ),
  ],
);

final eventBuyTicketsRoutes = AutoRoute(
  page: EventBuyTicketsRoute.page,
  children: [
    CustomRoute(
      initial: true,
      page: EventBuyTicketsInitialRoute.page,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    CustomRoute(
      page: EventBuyTicketsSelectTicketCategoryRoute.page,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    CustomRoute(
      page: SelectTicketsRoute.page,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    AutoRoute(
      page: EventTicketsSummaryRoute.page,
    ),
    AutoRoute(
      page: EventBuyTicketsProcessingRoute.page,
    ),
    AutoRoute(
      page: EventTicketsPaymentMethodRoute.page,
    ),
    AutoRoute(
      page: ClaimTokenRewardRoute.page,
    ),
    AutoRoute(
      page: EventPickMyTicketRoute.page,
      meta: const {'popBlocked': true},
    ),
    AutoRoute(
      page: EventTicketManagementRoute.page,
      meta: const {'popBlocked': true},
    ),
    AutoRoute(
      page: RSVPEventSuccessPopupRoute.page,
      meta: const {'popBlocked': true},
    ),
    AutoRoute(
      page: MyEventTicketAssignmentRoute.page,
    ),
  ],
);

final createEventRoutes = AutoRoute(
  page: CreateEventRoute.page,
  children: [
    AutoRoute(
      initial: true,
      page: CreateEventBaseRoute.page,
    ),
    AutoRoute(
      page: EventDescriptionFieldRoute.page,
    ),
    AutoRoute(
      page: EventGuestSettingsRoute.page,
    ),
    AutoRoute(
      page: EventDatetimeSettingsRoute.page,
    ),
    AutoRoute(
      page: EventLocationSettingRoute.page,
    ),
    AutoRoute(
      page: EventLocationSettingDetailRoute.page,
    ),
  ],
);

final commonRoutes = [
  AutoRoute(
    page: PhotosGalleryRoute.page,
  ),
  AutoRoute(
    path: '/404',
    page: EmptyRoute.page,
  ),
  AutoRoute(
    path: '/browser',
    page: WebviewRoute.page,
    fullscreenDialog: true,
  ),
];

final vaultRoutes = AutoRoute(
  path: '/vault',
  page: VaultRootRoute.page,
  children: [
    AutoRoute(
      initial: true,
      page: VaultsListingRoute.page,
    ),
    AutoRoute(
      page: CreateVaultRoute.page,
      children: [
        AutoRoute(
          initial: true,
          page: CreateVaultBasicInfoRoute.page,
        ),
        AutoRoute(
          page: CreateVaultSetupPhraseRoute.page,
        ),
        AutoRoute(
          page: CreateVaultCheckPhraseRoute.page,
        ),
        AutoRoute(
          page: CreateVaultSubmitTransactionRoute.page,
        ),
        AutoRoute(
          page: CreateVaultSetupPinRoute.page,
        ),
        AutoRoute(
          page: CreateVaultSuccessRoute.page,
        ),
      ],
    ),
  ],
);

final collaboratorRoutes = AutoRoute(
  path: '/collaborator',
  page: CollaboratorRoute.page,
  children: [
    AutoRoute(
      initial: true,
      page: CollaboratorDiscoverRoute.page,
    ),
    AutoRoute(
      page: CollaboratorChatRoute.page,
    ),
    AutoRoute(
      page: CollaboratorLikesRoute.page,
    ),
    AutoRoute(
      page: CollaboratorLikePreviewRoute.page,
    ),
    AutoRoute(
      page: CollaboratorEditProfileRoute.page,
    ),
    AutoRoute(
      page: CollaboratorPreviewProfileRoute.page,
    ),
    AutoRoute(
      page: EditProfileRoute.page,
    ),
    AutoRoute(page: ChatRoute.page),
  ],
);

final farcasterRoutes = [
  AutoRoute(page: FarcasterChannelNewsfeedRoute.page),
  AutoRoute(page: CreateFarcasterCastReplyRoute.page),
  AutoRoute(page: FarcasterCastDetailRoute.page),
  AutoRoute(page: FarcasterCastDetailRoute.page),
  AutoRoute(page: FarcasterUserProfileRoute.page),
  AutoRoute(page: FarcasterDiscoverRoute.page),
];

final questRoutes = AutoRoute(
  path: '/quest',
  page: QuestRoute.page,
  children: [
    AutoRoute(
      initial: true,
      page: QuestListingRoute.page,
    ),
    AutoRoute(
      page: CompletedQuestsListingRoute.page,
    ),
  ],
);

final createDuplicatedSubEventsRoutes = AutoRoute(
  page: CreateDuplicatedSubEventsRoute.page,
);
