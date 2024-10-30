import 'package:timezone/timezone.dart' as tz;
import 'package:app/core/utils/date_utils.dart' as date_utils;

class EventConstants {
  /// Guest limit per 2
  static String defaultEventGuestLimitPer = '2';

  /// Guest limit 100
  static String defaultEventGuestLimit = '100';

  static final List<Map<String, String>> timezoneOptions =
      _generateTimezoneOptions();

  static List<Map<String, String>> _generateTimezoneOptions() {
    final Map<String, String> timezoneData = {
      'Midway Island, Samoa': 'Pacific/Midway',
      'Hawaii': 'Pacific/Honolulu',
      'Alaska': 'US/Alaska',
      'Pacific Time (US & Canada)': 'America/Los_Angeles',
      'Tijuana, Baja California': 'America/Tijuana',
      'Arizona': 'US/Arizona',
      'Chihuahua, La Paz, Mazatlan': 'America/Chihuahua',
      'Mountain Time (US & Canada)': 'US/Mountain',
      'Central America': 'America/Managua',
      'Central Time (US & Canada)': 'US/Central',
      'Guadalajara, Mexico City, Monterrey': 'America/Mexico_City',
      'Saskatchewan': 'Canada/Saskatchewan',
      'Bogota, Lima, Quito, Rio Branco': 'America/Bogota',
      'Eastern Time (US & Canada)': 'US/Eastern',
      'Indiana (East)': 'US/East-Indiana',
      'Atlantic Time (Canada)': 'Canada/Atlantic',
      'Caracas, La Paz': 'America/Caracas',
      'Manaus': 'America/Manaus',
      'Santiago': 'America/Santiago',
      'Newfoundland': 'Canada/Newfoundland',
      'Brasilia': 'America/Sao_Paulo',
      'Buenos Aires, Georgetown': 'America/Argentina/Buenos_Aires',
      'Greenland': 'America/Godthab',
      'Montevideo': 'America/Montevideo',
      'Mid-Atlantic': 'America/Noronha',
      'Cape Verde Is.': 'Atlantic/Cape_Verde',
      'Azores': 'Atlantic/Azores',
      'Casablanca, Monrovia, Reykjavik': 'Africa/Casablanca',
      'Greenwich Mean Time : Dublin, Edinburgh, Lisbon, London':
          'Etc/Greenwich',
      'Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna': 'Europe/Amsterdam',
      'Belgrade, Bratislava, Budapest, Ljubljana, Prague': 'Europe/Belgrade',
      'Brussels, Copenhagen, Madrid, Paris': 'Europe/Brussels',
      'Sarajevo, Skopje, Warsaw, Zagreb': 'Europe/Sarajevo',
      'West Central Africa': 'Africa/Lagos',
      'Amman': 'Asia/Amman',
      'Athens, Bucharest, Istanbul': 'Europe/Athens',
      'Beirut': 'Asia/Beirut',
      'Cairo': 'Africa/Cairo',
      'Harare, Pretoria': 'Africa/Harare',
      'Helsinki, Kyiv, Riga, Sofia, Tallinn, Vilnius': 'Europe/Helsinki',
      'Jerusalem': 'Asia/Jerusalem',
      'Minsk': 'Europe/Minsk',
      'Windhoek': 'Africa/Windhoek',
      'Kuwait, Riyadh, Baghdad': 'Asia/Kuwait',
      'Moscow, St. Petersburg, Volgograd': 'Europe/Moscow',
      'Nairobi': 'Africa/Nairobi',
      'Tbilisi': 'Asia/Tbilisi',
      'Tehran': 'Asia/Tehran',
      'Abu Dhabi, Muscat': 'Asia/Muscat',
      'Baku': 'Asia/Baku',
      'Yerevan': 'Asia/Yerevan',
      'Kabul': 'Asia/Kabul',
      'Yekaterinburg': 'Asia/Yekaterinburg',
      'Islamabad, Karachi, Tashkent': 'Asia/Karachi',
      'Sri Jayawardenapura': 'Asia/Calcutta',
      'Kathmandu': 'Asia/Katmandu',
      'Almaty, Novosibirsk': 'Asia/Almaty',
      'Astana, Dhaka': 'Asia/Dhaka',
      'Yangon (Rangoon)': 'Asia/Rangoon',
      'Bangkok, Hanoi, Jakarta': 'Asia/Bangkok',
      'Krasnoyarsk': 'Asia/Krasnoyarsk',
      'Beijing, Chongqing, Hong Kong, Urumqi': 'Asia/Hong_Kong',
      'Kuala Lumpur, Singapore': 'Asia/Kuala_Lumpur',
      'Irkutsk, Ulaan Bataar': 'Asia/Irkutsk',
      'Perth': 'Australia/Perth',
      'Taipei': 'Asia/Taipei',
      'Osaka, Sapporo, Tokyo': 'Asia/Tokyo',
      'Seoul': 'Asia/Seoul',
      'Yakutsk': 'Asia/Yakutsk',
      'Adelaide': 'Australia/Adelaide',
      'Darwin': 'Australia/Darwin',
      'Brisbane': 'Australia/Brisbane',
      'Canberra, Melbourne, Sydney': 'Australia/Canberra',
      'Hobart': 'Australia/Hobart',
      'Guam, Port Moresby': 'Pacific/Guam',
      'Vladivostok': 'Asia/Vladivostok',
      'Magadan, Solomon Is., New Caledonia': 'Asia/Magadan',
      'Auckland, Wellington': 'Pacific/Auckland',
      'Fiji, Kamchatka, Marshall Is.': 'Pacific/Fiji',
      'Nuku\'alofa': 'Pacific/Tongatapu',
      'Apia, Kiritimati': 'Pacific/Apia',
      'Niue': 'Pacific/Niue',
      'Rarotonga': 'Pacific/Rarotonga',
      'Tahiti': 'Pacific/Tahiti',
      'Marquesas': 'Pacific/Marquesas',
      'Gambier': 'Pacific/Gambier',
      'Pitcairn': 'Pacific/Pitcairn',
      'Belize': 'America/Belize',
      'Costa Rica': 'America/Costa_Rica',
      'El Salvador': 'America/El_Salvador',
      'Galapagos': 'Pacific/Galapagos',
      'Guatemala': 'America/Guatemala',
      'America Cancun': 'America/Cancun',
      'Easter Island': 'Pacific/Easter',
      'Guayaquil': 'America/Guayaquil',
      'Havana': 'America/Havana',
      'Jamaica': 'America/Jamaica',
      'Lima': 'America/Lima',
      'Nassau': 'America/Nassau',
      'Panama': 'America/Panama',
      'Port-au-Prince': 'America/Port-au-Prince',
      'Rio Branco': 'America/Rio_Branco',
      'Barbados': 'America/Barbados',
      'Bermuda': 'Atlantic/Bermuda',
      'Boa Vista': 'America/Boa_Vista',
      'Curacao': 'America/Curacao',
      'Grand Turk': 'America/Grand_Turk',
      'Guyana': 'America/Guyana',
      'La Paz': 'America/La_Paz',
      'Martinique': 'America/Martinique',
      'Port of Spain': 'America/Port_of_Spain',
      'Porto Velho': 'America/Porto_Velho',
      'Puerto Rico': 'America/Puerto_Rico',
      'Santo Domingo': 'America/Santo_Domingo',
      'Thule': 'America/Thule',
      'Newfoundland Time - St. Johns': 'America/St_Johns',
      'Araguaina': 'America/Araguaina',
      'Asuncion': 'America/Asuncion',
      'Belem': 'America/Belem',
      'Campo Grande': 'America/Campo_Grande',
      'Cayenne': 'America/Cayenne',
      'Cuiaba': 'America/Cuiaba',
      'Fortaleza': 'America/Fortaleza',
      'Maceio': 'America/Maceio',
      'Miquelon': 'America/Miquelon',
      'Palmer': 'Antarctica/Palmer',
      'Paramaribo': 'America/Paramaribo',
      'Punta Arenas': 'America/Punta_Arenas',
      'Recife': 'America/Recife',
      'Rothera': 'Antarctica/Rothera',
      'Salvador': 'America/Bahia',
      'Stanley': 'Atlantic/Stanley',
      'South Georgia': 'Atlantic/South_Georgia',
      'Scoresbysund': 'America/Scoresbysund',
      'Abidjan': 'Africa/Abidjan',
      'Accra': 'Africa/Accra',
      'Bissau': 'Africa/Bissau',
      'Canary Islands': 'Atlantic/Canary',
      'Danmarkshavn': 'America/Danmarkshavn',
      'Dublin': 'Europe/Dublin',
      'El Aaiun': 'Africa/El_Aaiun',
      'Faeroe': 'Atlantic/Faroe',
      'Lisbon': 'Europe/Lisbon',
      'London': 'Europe/London',
      'Monrovia': 'Africa/Monrovia',
      'Reykjavik': 'Atlantic/Reykjavik',
      'Algiers': 'Africa/Algiers',
      'Andorra': 'Europe/Andorra',
      'Ceuta': 'Africa/Ceuta',
      'Gibraltar': 'Europe/Gibraltar',
      'Luxembourg': 'Europe/Luxembourg',
      'Malta': 'Europe/Malta',
      'Monaco': 'Europe/Monaco',
      'Ndjamena': 'Africa/Ndjamena',
      'Oslo': 'Europe/Oslo',
      'Tirane': 'Europe/Tirane',
      'Tunis': 'Africa/Tunis',
      'Zurich': 'Europe/Zurich',
      'Chisinau': 'Europe/Chisinau',
      'Damascus': 'Asia/Damascus',
      'Gaza': 'Asia/Gaza',
      'Johannesburg': 'Africa/Johannesburg',
      'Khartoum': 'Africa/Khartoum',
      'Kiev': 'Europe/Kiev',
      'Maputo': 'Africa/Maputo',
      'Moscow-01 - Kaliningrad': 'Europe/Kaliningrad',
      'Nicosia': 'Asia/Nicosia',
      'Riga': 'Europe/Riga',
      'Sofia': 'Europe/Sofia',
      'Tallinn': 'Europe/Tallinn',
      'Tripoli': 'Africa/Tripoli',
      'Vilnius': 'Europe/Vilnius',
      'Baghdad': 'Asia/Baghdad',
      'Istanbul': 'Europe/Istanbul',
      'Qatar': 'Asia/Qatar',
      'Riyadh': 'Asia/Riyadh',
      'Syowa': 'Antarctica/Syowa',
      'Dubai': 'Asia/Dubai',
      'Mahe': 'Indian/Mahe',
      'Mauritius': 'Indian/Mauritius',
      'Moscow+01 - Samara': 'Europe/Samara',
      'Reunion': 'Indian/Reunion',
      'Aqtau': 'Asia/Aqtau',
      'Aqtobe': 'Asia/Aqtobe',
      'Ashgabat': 'Asia/Ashgabat',
      'Dushanbe': 'Asia/Dushanbe',
      'Kerguelen': 'Indian/Kerguelen',
      'Maldives': 'Indian/Maldives',
      'Mawson': 'Antarctica/Mawson',
      'Colombo': 'Asia/Colombo',
      'Bishkek': 'Asia/Bishkek',
      'Chagos': 'Indian/Chagos',
      'Moscow+03 - Omsk': 'Asia/Omsk',
      'Thimphu': 'Asia/Thimphu',
      'Vostok': 'Antarctica/Vostok',
      'Cocos': 'Indian/Cocos',
      'Christmas': 'Indian/Christmas',
      'Davis': 'Antarctica/Davis',
      'Hovd': 'Asia/Hovd',
      'Brunei': 'Asia/Brunei',
      'Choibalsan': 'Asia/Choibalsan',
      'Makassar': 'Asia/Makassar',
      'Manila': 'Asia/Manila',
      'Dili': 'Asia/Dili',
      'Jayapura': 'Asia/Jayapura',
      'Palau': 'Pacific/Palau',
      'Dumont D\'Urville': 'Antarctica/DumontDUrville',
      'Port Moresby': 'Pacific/Port_Moresby',
      'Truk': 'Pacific/Chuuk',
      'Casey': 'Antarctica/Casey',
      'Eastern Time - Melbourne, Sydney': 'Australia/Sydney',
      'Efate': 'Pacific/Efate',
      'Guadalcanal': 'Pacific/Guadalcanal',
      'Kosrae': 'Pacific/Kosrae',
      'Norfolk': 'Pacific/Norfolk',
      'Noumea': 'Pacific/Noumea',
      'Ponape': 'Pacific/Pohnpei',
      'Funafuti': 'Pacific/Funafuti',
      'Kwajalein': 'Pacific/Kwajalein',
      'Majuro': 'Pacific/Majuro',
      'Nauru': 'Pacific/Nauru',
      'Tarawa': 'Pacific/Tarawa',
      'Wake': 'Pacific/Wake',
      'Wallis': 'Pacific/Wallis',
      'Enderbury': 'Pacific/Enderbury',
      'Fakaofo': 'Pacific/Fakaofo',
      'Kiritimati': 'Pacific/Kiritimati',
    };

    return timezoneData.entries.map((entry) {
      final String key = entry.key;
      final String value = entry.value;
      final location = tz.getLocation(value);
      final now = tz.TZDateTime.now(location);
      final offset = now.timeZoneOffset;
      final int hours = offset.inHours;
      final int minutes = offset.inMinutes.abs() % 60;

      final String minutesPadded =
          minutes > 0 ? ':${minutes.toString().padLeft(2, '0')}' : '';
      final String hoursFormatted =
          offset.isNegative ? '-${hours.abs()}' : '+$hours';
      final String zz = '$hoursFormatted$minutesPadded';

      return {
        'value': value,
        'text': '(GMT$zz) $key',
        'short': 'GMT$zz',
      };
    }).toList();
  }
}

class EventDateTimeConstants {
  static DateTime get currentDateTime => tz.TZDateTime.now(
        tz.getLocation(date_utils.DateUtils.getUserTimezoneOptionValue()),
      );

  static DateTime get defaultStartDateTime {
    return DateTime(
      currentDateTime.year,
      currentDateTime.month,
      currentDateTime.day + 3,
      10,
    );
  }

  static DateTime get defaultEndDateTime {
    return DateTime(
      currentDateTime.year,
      currentDateTime.month,
      currentDateTime.day + 6,
      18,
    );
  }
}
