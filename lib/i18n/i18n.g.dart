/// Generated file. Do not edit.
///
/// Locales: 1
/// Strings: 99
///
/// Built on 2023-08-07 at 08:49 UTC

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
	late final _I18nChatEn chat = _I18nChatEn._(_root);
	late final _I18nNftEn nft = _I18nNftEn._(_root);
	late final _I18nAuthEn auth = _I18nAuthEn._(_root);
	late final _I18nNotificationEn notification = _I18nNotificationEn._(_root);
	late final _I18nCommonEn common = _I18nCommonEn._(_root);
	late final _I18nEventEn event = _I18nEventEn._(_root);
}

// Path: post
class _I18nPostEn {
	_I18nPostEn._(this._root);

	final _I18nEn _root; // ignore: unused_field

	// Translations
	String get noPost => 'No posts yet';
}

// Path: chat
class _I18nChatEn {
	_I18nChatEn._(this._root);

	final _I18nEn _root; // ignore: unused_field

	// Translations
	String get unread => 'unread';
	String get channels => 'channels';
	String get directMessages => 'direct messages';
	String get spaces => 'spaces';
	String get home => 'home';
	late final _I18nChatCommandEn command = _I18nChatCommandEn._(_root);
	String get typeMessage => 'type a message...';
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
	String get lemonade => 'Lemonade';
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

// Path: chat.command
class _I18nChatCommandEn {
	_I18nChatCommandEn._(this._root);

	final _I18nEn _root; // ignore: unused_field

	// Translations
	String get ban => 'Ban the given user from this room';
	String get clearcache => 'Clear cache';
	String get create => 'Create';
	String get discardsession => 'Discard session';
	String get dm => 'Start a direct chat\nUse --no-encryption to disable encryption';
	String get html => 'Send HTML-formatted text';
	String get invite => 'Invite the given user to this room';
	String get join => 'Join the given room';
	String get kick => 'Remove the given user from this room';
	String get leave => 'Leave this room';
	String get me => 'Describe yourself';
	String get myroomavatar => 'Set your picture for this room (by mxc-uri)';
	String get myroomnick => 'Set your display name for this room';
	String get op => 'Set the given user\'s power level (default: 50)';
	String get plain => 'Send unformatted text';
	String get react => 'Send reply as a reaction';
	String get send => 'Send text';
	String get unban => 'Unban the given user from this room';
	String get markasdm => 'Mark as direct message room';
	String get markasgroup => 'Mark as group';
	String get googly => 'Send some googly eyes';
	String get hug => 'Send a hug';
	String get cuddle => 'Send a cuddle';
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
			case 'chat.unread': return 'unread';
			case 'chat.channels': return 'channels';
			case 'chat.directMessages': return 'direct messages';
			case 'chat.spaces': return 'spaces';
			case 'chat.home': return 'home';
			case 'chat.command.ban': return 'Ban the given user from this room';
			case 'chat.command.clearcache': return 'Clear cache';
			case 'chat.command.create': return 'Create';
			case 'chat.command.discardsession': return 'Discard session';
			case 'chat.command.dm': return 'Start a direct chat\nUse --no-encryption to disable encryption';
			case 'chat.command.html': return 'Send HTML-formatted text';
			case 'chat.command.invite': return 'Invite the given user to this room';
			case 'chat.command.join': return 'Join the given room';
			case 'chat.command.kick': return 'Remove the given user from this room';
			case 'chat.command.leave': return 'Leave this room';
			case 'chat.command.me': return 'Describe yourself';
			case 'chat.command.myroomavatar': return 'Set your picture for this room (by mxc-uri)';
			case 'chat.command.myroomnick': return 'Set your display name for this room';
			case 'chat.command.op': return 'Set the given user\'s power level (default: 50)';
			case 'chat.command.plain': return 'Send unformatted text';
			case 'chat.command.react': return 'Send reply as a reaction';
			case 'chat.command.send': return 'Send text';
			case 'chat.command.unban': return 'Unban the given user from this room';
			case 'chat.command.markasdm': return 'Mark as direct message room';
			case 'chat.command.markasgroup': return 'Mark as group';
			case 'chat.command.googly': return 'Send some googly eyes';
			case 'chat.command.hug': return 'Send a hug';
			case 'chat.command.cuddle': return 'Send a cuddle';
			case 'chat.typeMessage': return 'type a message...';
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
			case 'common.lemonade': return 'Lemonade';
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
			default: return null;
		}
	}
}
