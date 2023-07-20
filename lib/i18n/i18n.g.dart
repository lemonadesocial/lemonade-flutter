/// Generated file. Do not edit.
///
/// Locales: 1
/// Strings: 59
///
/// Built on 2023-07-20 at 08:05 UTC

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
}

// Path: auth
class _I18nAuthEn {
	_I18nAuthEn._(this._root);

	final _I18nEn _root; // ignore: unused_field

	// Translations
	late final _I18nAuthLoginEn login = _I18nAuthLoginEn._(_root);
	String get logout => 'Logout';
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
			case 'auth.login.success': return 'Logged in successfully';
			case 'auth.login.fail': return 'Logged in failed';
			case 'auth.logout': return 'Logout';
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
