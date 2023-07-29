/// Generated file. Do not edit.
///
/// Locales: 1
/// Strings: 119
///
/// Built on 2023-07-29 at 08:56 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.en;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, _I18nEn> {
	en(languageCode: 'en', build: _I18nEn.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, _I18nEn> build;

	/// Gets current instance managed by [LocaleSettings].
	_I18nEn get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
_I18nEn get t => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class Translations {
	Translations._(); // no constructor

	static _I18nEn of(BuildContext context) => InheritedLocaleData.of<AppLocale, _I18nEn>(context).translations;
}

/// The provider for method B
class TranslationProvider extends BaseTranslationProvider<AppLocale, _I18nEn> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, _I18nEn> of(BuildContext context) => InheritedLocaleData.of<AppLocale, _I18nEn>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	_I18nEn get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, _I18nEn> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, _I18nEn> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class _I18nEn implements BaseTranslations<AppLocale, _I18nEn> {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_I18nEn.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, _I18nEn> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final _I18nEn _root = this; // ignore: unused_field

	// Translations
	late final _I18nPostEn post = _I18nPostEn._(_root);
	late final _I18nNftEn nft = _I18nNftEn._(_root);
	late final _I18nAuthEn auth = _I18nAuthEn._(_root);
	late final _I18nNotificationEn notification = _I18nNotificationEn._(_root);
	late final _I18nCommonEn common = _I18nCommonEn._(_root);
	late final _I18nEventEn event = _I18nEventEn._(_root);
	late final _I18nMatrixEn matrix = _I18nMatrixEn._(_root);
}

// Path: post
class _I18nPostEn {
	_I18nPostEn._(this._root);

	final _I18nEn _root; // ignore: unused_field

	// Translations
	String get noPost => 'No posts yet';
}

// Path: nft
class _I18nNftEn {
	_I18nNftEn._(this._root);

	final _I18nEn _root; // ignore: unused_field

	// Translations
	String get onSale => 'on sale';
	String get created => 'created';
	String get collected => 'collected';
	String get sold => 'sold';
	String get emptyCreatedNfts => 'You have not created any NFTs yet';
	String get noCollectible => 'No collectibles yet';
	String get claimed => 'claimed';
	String get claim => 'claim';
	String get needLocationToClaimPoap => 'We need to access your location to check eligibility...';
	String get ineligibleToClaimPoap => 'Uh oh! 🙁 You are ineligible to claim this badge...';
	String get ableToClaimPoap => 'Congrats! 🥳 You meet all requirements to claim this badge';
	String get badges => 'badges';
}

// Path: auth
class _I18nAuthEn {
	_I18nAuthEn._(this._root);

	final _I18nEn _root; // ignore: unused_field

	// Translations
	late final _I18nAuthLoginEn login = _I18nAuthLoginEn._(_root);
	String get logout => 'Logout';
}

// Path: notification
class _I18nNotificationEn {
	_I18nNotificationEn._(this._root);

	final _I18nEn _root; // ignore: unused_field

	// Translations
	String get notifications => 'Notifications';
	String get emptyNotifications => 'No notifications yet';
}

// Path: common
class _I18nCommonEn {
	_I18nCommonEn._(this._root);

	final _I18nEn _root; // ignore: unused_field

	// Translations
	String get today => 'today';
	String get tomorrow => 'tomorrow';
	String get thisWeek => 'this week';
	String get thisWeekend => 'this weekend';
	String get nextWeek => 'next week';
	String get nextWeekend => 'next weekend';
	String get nextMonth => 'next month';
	String get somethingWrong => 'There\'s something wrong';
	String get following => 'following';
	String get description => 'description';
	String joinedOn({required Object date}) => 'joined on ${date}';
	String follower({required num n}) => (_root.$meta.ordinalResolver ?? PluralResolvers.ordinal('en'))(n,
		one: 'follower',
		other: 'followers',
	);
	String friends({required num n}) => (_root.$meta.ordinalResolver ?? PluralResolvers.ordinal('en'))(n,
		one: 'follower',
		other: 'followers',
	);
	String ticket({required num n}) => (_root.$meta.ordinalResolver ?? PluralResolvers.ordinal('en'))(n,
		one: 'ticket',
		other: 'tickets',
	);
	late final _I18nCommonActionsEn actions = _I18nCommonActionsEn._(_root);
	String get followed => 'Followed';
	String get anonymous => 'anonymous';
	String get profileUrlCopied => 'Profile\'s URL copied to clipboard';
	String get upcoming => 'Upcoming';
	String get past => 'Past';
	String get noPhotos => 'No photos yet';
	late final _I18nCommonUnitEn unit = _I18nCommonUnitEn._(_root);
	String get search => 'search';
	String get viewRequirements => 'view requirements';
	String get grantAccess => 'grant access';
	String get nearMe => 'Near me';
	String get maximumDistance => 'Maximum distance';
	String get community => 'community';
	String get dashboard => 'dashboard';
	String get qrCode => 'qrCode';
	String get support => 'support';
	String get delete => 'delete';
}

// Path: event
class _I18nEventEn {
	_I18nEventEn._(this._root);

	final _I18nEn _root; // ignore: unused_field

	// Translations
	String get events => 'Events';
	String get all => 'all';
	String get attending => 'attending';
	String get attended => 'attended';
	String get created => 'created';
	String get hosting => 'hosting';
	String get buy => 'buy';
	String get free => 'free';
	String empty_home_events({required Object time}) => 'There\'s no events ${time}';
	String empty_attending_events({required Object time}) => 'You are currently not attending any events ${time}';
	String empty_hosting_events({required Object time}) => 'You are currently not hosting any events ${time}';
	String get noEvents => 'No events yet';
}

// Path: matrix
class _I18nMatrixEn {
	_I18nMatrixEn._(this._root);

	final _I18nEn _root; // ignore: unused_field

	// Translations
	String get sourceCode => 'sourceCode';
	String get passphraseOrKey => 'passphrase or recovery key';
	String get incorrectPassphraseOrKey => 'Incorrect passphrase or recovery key';
	String get verifyTitle => 'Verifying other account';
	String get askSSSSSign => 'To be able to sign the other person, please enter your secure store passphrase or recovery key.';
	String get submit => 'Submit';
	String get skip => 'Skip';
	String get newVerificationRequest => 'New verification request!';
	String askVerificationRequest({required Object username}) => 'Accept this verification request from ${username}?';
	String get reject => 'Reject';
	String get accept => 'Accept';
	String get waitingPartnerAcceptRequest => 'Waiting for partner to accept the request…';
	String get compareEmojiMatch => 'Please compare the emojis';
	String get compareNumbersMatch => 'Please compare the numbers';
	String get theyDontMatch => 'They Don\'t Match';
	String get theyMatch => 'They Match';
	String get waitingPartnerEmoji => 'Waiting for partner to accept the emoji…';
	String get waitingPartnerNumbers => 'Waiting for partner to accept the numbers…';
	String get verifySuccess => 'You successfully verified!';
	String get close => 'Close';
	String get openChat => 'Open Chat';
	String get markAsRead => 'Mark as read';
	String get loadingPleaseWait => 'Loading… Please wait.';
	String get oneClientLoggedOut => 'One of your clients has been logged out';
	String get oopsSomethingWentWrong => 'Oops, something went wrong…';
	String get ok => 'Ok';
	String get help => 'Help';
	String get doNotShowAgain => 'Do not show again';
	String get saveFile => 'Save file';
	String fileHasBeenSavedAt({required Object path}) => 'File has been saved at ${path}';
	String lastActiveAgo({required Object localizedTimeShort}) => 'Last active: ${localizedTimeShort}';
	String dateWithoutYear({required Object month, required Object day}) => '${month}-${day}';
	String dateWithYear({required Object year, required Object month, required Object day}) => '${year}-${month}-${day}';
	String dateAndTimeOfDay({required Object date, required Object timeOfDay}) => '${date}, ${timeOfDay}';
	String get lastSeenLongTimeAgo => 'Seen a long time ago';
	String get currentlyActive => 'Currently active';
	String get noPermission => 'No permission';
	String get tooManyRequestsWarning => 'Too many requests. Please try again later!';
	String get fileIsTooBigForServer => 'The server reports that the file is too large to be sent.';
	String badServerVersionsException({required Object serverVersions, required Object supportedVersions}) => 'The homeserver supports the Spec versions:\n${serverVersions}\nBut this app supports only ${supportedVersions}';
	String badServerLoginTypesException({required Object serverVersions, required Object supportedVersions}) => 'The homeserver supports the login types:\n${serverVersions}\nBut this app supports only:\n${supportedVersions}';
	String get noConnectionToTheServer => 'No connection to the server';
	String get pleaseEnterYourPassword => 'Please enter your password';
	String get cancel => 'Cancel';
	String get weSentYouAnEmail => 'We sent you an email';
	String get pleaseClickOnLink => 'Please click on the link in the email and then proceed.';
	String get iHaveClickedOnLink => 'I have clicked on the link';
	String get pleaseFollowInstructionsOnWeb => 'Please follow the instructions on the website and tap on next.';
	String get next => 'Next';
	String get serverRequiresEmail => 'This server needs to validate your email address for registration.';
}

// Path: auth.login
class _I18nAuthLoginEn {
	_I18nAuthLoginEn._(this._root);

	final _I18nEn _root; // ignore: unused_field

	// Translations
	String get success => 'Logged in successfully';
	String get fail => 'Logged in failed';
}

// Path: common.actions
class _I18nCommonActionsEn {
	_I18nCommonActionsEn._(this._root);

	final _I18nEn _root; // ignore: unused_field

	// Translations
	String get edit => 'edit';
	String get connect => 'connect';
	String get editProfile => 'Edit profile';
	String get shareProfile => 'Share profile';
	String get follow => 'Follow';
}

// Path: common.unit
class _I18nCommonUnitEn {
	_I18nCommonUnitEn._(this._root);

	final _I18nEn _root; // ignore: unused_field

	// Translations
	String get km => 'km';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on _I18nEn {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'post.noPost': return 'No posts yet';
			case 'nft.onSale': return 'on sale';
			case 'nft.created': return 'created';
			case 'nft.collected': return 'collected';
			case 'nft.sold': return 'sold';
			case 'nft.emptyCreatedNfts': return 'You have not created any NFTs yet';
			case 'nft.noCollectible': return 'No collectibles yet';
			case 'nft.claimed': return 'claimed';
			case 'nft.claim': return 'claim';
			case 'nft.needLocationToClaimPoap': return 'We need to access your location to check eligibility...';
			case 'nft.ineligibleToClaimPoap': return 'Uh oh! 🙁 You are ineligible to claim this badge...';
			case 'nft.ableToClaimPoap': return 'Congrats! 🥳 You meet all requirements to claim this badge';
			case 'nft.badges': return 'badges';
			case 'auth.login.success': return 'Logged in successfully';
			case 'auth.login.fail': return 'Logged in failed';
			case 'auth.logout': return 'Logout';
			case 'notification.notifications': return 'Notifications';
			case 'notification.emptyNotifications': return 'No notifications yet';
			case 'common.today': return 'today';
			case 'common.tomorrow': return 'tomorrow';
			case 'common.thisWeek': return 'this week';
			case 'common.thisWeekend': return 'this weekend';
			case 'common.nextWeek': return 'next week';
			case 'common.nextWeekend': return 'next weekend';
			case 'common.nextMonth': return 'next month';
			case 'common.somethingWrong': return 'There\'s something wrong';
			case 'common.following': return 'following';
			case 'common.description': return 'description';
			case 'common.joinedOn': return ({required Object date}) => 'joined on ${date}';
			case 'common.follower': return ({required num n}) => (_root.$meta.ordinalResolver ?? PluralResolvers.ordinal('en'))(n,
				one: 'follower',
				other: 'followers',
			);
			case 'common.friends': return ({required num n}) => (_root.$meta.ordinalResolver ?? PluralResolvers.ordinal('en'))(n,
				one: 'follower',
				other: 'followers',
			);
			case 'common.ticket': return ({required num n}) => (_root.$meta.ordinalResolver ?? PluralResolvers.ordinal('en'))(n,
				one: 'ticket',
				other: 'tickets',
			);
			case 'common.actions.edit': return 'edit';
			case 'common.actions.connect': return 'connect';
			case 'common.actions.editProfile': return 'Edit profile';
			case 'common.actions.shareProfile': return 'Share profile';
			case 'common.actions.follow': return 'Follow';
			case 'common.followed': return 'Followed';
			case 'common.anonymous': return 'anonymous';
			case 'common.profileUrlCopied': return 'Profile\'s URL copied to clipboard';
			case 'common.upcoming': return 'Upcoming';
			case 'common.past': return 'Past';
			case 'common.noPhotos': return 'No photos yet';
			case 'common.unit.km': return 'km';
			case 'common.search': return 'search';
			case 'common.viewRequirements': return 'view requirements';
			case 'common.grantAccess': return 'grant access';
			case 'common.nearMe': return 'Near me';
			case 'common.maximumDistance': return 'Maximum distance';
			case 'common.community': return 'community';
			case 'common.dashboard': return 'dashboard';
			case 'common.qrCode': return 'qrCode';
			case 'common.support': return 'support';
			case 'common.delete': return 'delete';
			case 'event.events': return 'Events';
			case 'event.all': return 'all';
			case 'event.attending': return 'attending';
			case 'event.attended': return 'attended';
			case 'event.created': return 'created';
			case 'event.hosting': return 'hosting';
			case 'event.buy': return 'buy';
			case 'event.free': return 'free';
			case 'event.empty_home_events': return ({required Object time}) => 'There\'s no events ${time}';
			case 'event.empty_attending_events': return ({required Object time}) => 'You are currently not attending any events ${time}';
			case 'event.empty_hosting_events': return ({required Object time}) => 'You are currently not hosting any events ${time}';
			case 'event.noEvents': return 'No events yet';
			case 'matrix.sourceCode': return 'sourceCode';
			case 'matrix.passphraseOrKey': return 'passphrase or recovery key';
			case 'matrix.incorrectPassphraseOrKey': return 'Incorrect passphrase or recovery key';
			case 'matrix.verifyTitle': return 'Verifying other account';
			case 'matrix.askSSSSSign': return 'To be able to sign the other person, please enter your secure store passphrase or recovery key.';
			case 'matrix.submit': return 'Submit';
			case 'matrix.skip': return 'Skip';
			case 'matrix.newVerificationRequest': return 'New verification request!';
			case 'matrix.askVerificationRequest': return ({required Object username}) => 'Accept this verification request from ${username}?';
			case 'matrix.reject': return 'Reject';
			case 'matrix.accept': return 'Accept';
			case 'matrix.waitingPartnerAcceptRequest': return 'Waiting for partner to accept the request…';
			case 'matrix.compareEmojiMatch': return 'Please compare the emojis';
			case 'matrix.compareNumbersMatch': return 'Please compare the numbers';
			case 'matrix.theyDontMatch': return 'They Don\'t Match';
			case 'matrix.theyMatch': return 'They Match';
			case 'matrix.waitingPartnerEmoji': return 'Waiting for partner to accept the emoji…';
			case 'matrix.waitingPartnerNumbers': return 'Waiting for partner to accept the numbers…';
			case 'matrix.verifySuccess': return 'You successfully verified!';
			case 'matrix.close': return 'Close';
			case 'matrix.openChat': return 'Open Chat';
			case 'matrix.markAsRead': return 'Mark as read';
			case 'matrix.loadingPleaseWait': return 'Loading… Please wait.';
			case 'matrix.oneClientLoggedOut': return 'One of your clients has been logged out';
			case 'matrix.oopsSomethingWentWrong': return 'Oops, something went wrong…';
			case 'matrix.ok': return 'Ok';
			case 'matrix.help': return 'Help';
			case 'matrix.doNotShowAgain': return 'Do not show again';
			case 'matrix.saveFile': return 'Save file';
			case 'matrix.fileHasBeenSavedAt': return ({required Object path}) => 'File has been saved at ${path}';
			case 'matrix.lastActiveAgo': return ({required Object localizedTimeShort}) => 'Last active: ${localizedTimeShort}';
			case 'matrix.dateWithoutYear': return ({required Object month, required Object day}) => '${month}-${day}';
			case 'matrix.dateWithYear': return ({required Object year, required Object month, required Object day}) => '${year}-${month}-${day}';
			case 'matrix.dateAndTimeOfDay': return ({required Object date, required Object timeOfDay}) => '${date}, ${timeOfDay}';
			case 'matrix.lastSeenLongTimeAgo': return 'Seen a long time ago';
			case 'matrix.currentlyActive': return 'Currently active';
			case 'matrix.noPermission': return 'No permission';
			case 'matrix.tooManyRequestsWarning': return 'Too many requests. Please try again later!';
			case 'matrix.fileIsTooBigForServer': return 'The server reports that the file is too large to be sent.';
			case 'matrix.badServerVersionsException': return ({required Object serverVersions, required Object supportedVersions}) => 'The homeserver supports the Spec versions:\n${serverVersions}\nBut this app supports only ${supportedVersions}';
			case 'matrix.badServerLoginTypesException': return ({required Object serverVersions, required Object supportedVersions}) => 'The homeserver supports the login types:\n${serverVersions}\nBut this app supports only:\n${supportedVersions}';
			case 'matrix.noConnectionToTheServer': return 'No connection to the server';
			case 'matrix.pleaseEnterYourPassword': return 'Please enter your password';
			case 'matrix.cancel': return 'Cancel';
			case 'matrix.weSentYouAnEmail': return 'We sent you an email';
			case 'matrix.pleaseClickOnLink': return 'Please click on the link in the email and then proceed.';
			case 'matrix.iHaveClickedOnLink': return 'I have clicked on the link';
			case 'matrix.pleaseFollowInstructionsOnWeb': return 'Please follow the instructions on the website and tap on next.';
			case 'matrix.next': return 'Next';
			case 'matrix.serverRequiresEmail': return 'This server needs to validate your email address for registration.';
			default: return null;
		}
	}
}
