class EventConstants {
  /// Guest limit per 2
  static String defaultEventGuestLimitPer = '2';

  /// Guest limit 100
  static String defaultEventGuestLimit = '100';

  static final List<Map<String, String>> timezoneOptions = [
    {'text': '(GMT-12:00) International Date Line West', 'value': 'Etc/GMT+12'},
    {'text': '(GMT-11:00) Midway Island, Samoa', 'value': 'Pacific/Midway'},
    {'text': '(GMT-10:00) Hawaii', 'value': 'Pacific/Honolulu'},
    {'text': '(GMT-09:00) Alaska', 'value': 'US/Alaska'},
    {
      'text': '(GMT-08:00) Pacific Time (US & Canada)',
      'value': 'America/Los_Angeles',
    },
    {
      'text': '(GMT-08:00) Tijuana, Baja California',
      'value': 'America/Tijuana',
    },
    {'text': '(GMT-07:00) Arizona', 'value': 'US/Arizona'},
    {
      'text': '(GMT-07:00) Chihuahua, La Paz, Mazatlan',
      'value': 'America/Chihuahua',
    },
    {'text': '(GMT-07:00) Mountain Time (US & Canada)', 'value': 'US/Mountain'},
    {'text': '(GMT-06:00) Central America', 'value': 'America/Managua'},
    {'text': '(GMT-06:00) Central Time (US & Canada)', 'value': 'US/Central'},
    {
      'text': '(GMT-06:00) Guadalajara, Mexico City, Monterrey',
      'value': 'America/Mexico_City',
    },
    {'text': '(GMT-06:00) Saskatchewan', 'value': 'Canada/Saskatchewan'},
    {
      'text': '(GMT-05:00) Bogota, Lima, Quito, Rio Branco',
      'value': 'America/Bogota',
    },
    {'text': '(GMT-05:00) Eastern Time (US & Canada)', 'value': 'US/Eastern'},
    {'text': '(GMT-05:00) Indiana (East)', 'value': 'US/East-Indiana'},
    {'text': '(GMT-04:00) Atlantic Time (Canada)', 'value': 'Canada/Atlantic'},
    {'text': '(GMT-04:00) Caracas, La Paz', 'value': 'America/Caracas'},
    {'text': '(GMT-04:00) Manaus', 'value': 'America/Manaus'},
    {'text': '(GMT-04:00) Santiago', 'value': 'America/Santiago'},
    {'text': '(GMT-03:30) Newfoundland', 'value': 'Canada/Newfoundland'},
    {'text': '(GMT-03:00) Brasilia', 'value': 'America/Sao_Paulo'},
    {
      'text': '(GMT-03:00) Buenos Aires, Georgetown',
      'value': 'America/Argentina/Buenos_Aires',
    },
    {'text': '(GMT-03:00) Greenland', 'value': 'America/Godthab'},
    {'text': '(GMT-03:00) Montevideo', 'value': 'America/Montevideo'},
    {'text': '(GMT-02:00) Mid-Atlantic', 'value': 'America/Noronha'},
    {'text': '(GMT-01:00) Cape Verde Is.', 'value': 'Atlantic/Cape_Verde'},
    {'text': '(GMT-01:00) Azores', 'value': 'Atlantic/Azores'},
    {
      'text': '(GMT+00:00) Casablanca, Monrovia, Reykjavik',
      'value': 'Africa/Casablanca',
    },
    {
      'text':
          '(GMT+00:00) Greenwich Mean Time : Dublin, Edinburgh, Lisbon, London',
      'value': 'Etc/Greenwich',
    },
    {
      'text': '(GMT+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna',
      'value': 'Europe/Amsterdam',
    },
    {
      'text': '(GMT+01:00) Belgrade, Bratislava, Budapest, Ljubljana, Prague',
      'value': 'Europe/Belgrade',
    },
    {
      'text': '(GMT+01:00) Brussels, Copenhagen, Madrid, Paris',
      'value': 'Europe/Brussels',
    },
    {
      'text': '(GMT+01:00) Sarajevo, Skopje, Warsaw, Zagreb',
      'value': 'Europe/Sarajevo',
    },
    {'text': '(GMT+01:00) West Central Africa', 'value': 'Africa/Lagos'},
    {'text': '(GMT+02:00) Amman', 'value': 'Asia/Amman'},
    {
      'text': '(GMT+02:00) Athens, Bucharest, Istanbul',
      'value': 'Europe/Athens',
    },
    {'text': '(GMT+02:00) Beirut', 'value': 'Asia/Beirut'},
    {'text': '(GMT+02:00) Cairo', 'value': 'Africa/Cairo'},
    {'text': '(GMT+02:00) Harare, Pretoria', 'value': 'Africa/Harare'},
    {
      'text': '(GMT+02:00) Helsinki, Kyiv, Riga, Sofia, Tallinn, Vilnius',
      'value': 'Europe/Helsinki',
    },
    {'text': '(GMT+02:00) Jerusalem', 'value': 'Asia/Jerusalem'},
    {'text': '(GMT+02:00) Minsk', 'value': 'Europe/Minsk'},
    {'text': '(GMT+02:00) Windhoek', 'value': 'Africa/Windhoek'},
    {'text': '(GMT+03:00) Kuwait, Riyadh, Baghdad', 'value': 'Asia/Kuwait'},
    {
      'text': '(GMT+03:00) Moscow, St. Petersburg, Volgograd',
      'value': 'Europe/Moscow',
    },
    {'text': '(GMT+03:00) Nairobi', 'value': 'Africa/Nairobi'},
    {'text': '(GMT+03:00) Tbilisi', 'value': 'Asia/Tbilisi'},
    {'text': '(GMT+03:30) Tehran', 'value': 'Asia/Tehran'},
    {'text': '(GMT+04:00) Abu Dhabi, Muscat', 'value': 'Asia/Muscat'},
    {'text': '(GMT+04:00) Baku', 'value': 'Asia/Baku'},
    {'text': '(GMT+04:00) Yerevan', 'value': 'Asia/Yerevan'},
    {'text': '(GMT+04:30) Kabul', 'value': 'Asia/Kabul'},
    {'text': '(GMT+05:00) Yekaterinburg', 'value': 'Asia/Yekaterinburg'},
    {
      'text': '(GMT+05:00) Islamabad, Karachi, Tashkent',
      'value': 'Asia/Karachi',
    },
    {
      'text': '(GMT+05:30) Chennai, Kolkata, Mumbai, New Delhi',
      'value': 'Asia/Calcutta',
    },
    {'text': '(GMT+05:30) Sri Jayawardenapura', 'value': 'Asia/Calcutta'},
    {'text': '(GMT+05:45) Kathmandu', 'value': 'Asia/Katmandu'},
    {'text': '(GMT+06:00) Almaty, Novosibirsk', 'value': 'Asia/Almaty'},
    {'text': '(GMT+06:00) Astana, Dhaka', 'value': 'Asia/Dhaka'},
    {'text': '(GMT+06:30) Yangon (Rangoon)', 'value': 'Asia/Rangoon'},
    {'text': '(GMT+07:00) Bangkok, Hanoi, Jakarta', 'value': 'Asia/Bangkok'},
    {'text': '(GMT+07:00) Krasnoyarsk', 'value': 'Asia/Krasnoyarsk'},
    {
      'text': '(GMT+08:00) Beijing, Chongqing, Hong Kong, Urumqi',
      'value': 'Asia/Hong_Kong',
    },
    {
      'text': '(GMT+08:00) Kuala Lumpur, Singapore',
      'value': 'Asia/Kuala_Lumpur',
    },
    {'text': '(GMT+08:00) Irkutsk, Ulaan Bataar', 'value': 'Asia/Irkutsk'},
    {'text': '(GMT+08:00) Perth', 'value': 'Australia/Perth'},
    {'text': '(GMT+08:00) Taipei', 'value': 'Asia/Taipei'},
    {'text': '(GMT+09:00) Osaka, Sapporo, Tokyo', 'value': 'Asia/Tokyo'},
    {'text': '(GMT+09:00) Seoul', 'value': 'Asia/Seoul'},
    {'text': '(GMT+09:00) Yakutsk', 'value': 'Asia/Yakutsk'},
    {'text': '(GMT+09:30) Adelaide', 'value': 'Australia/Adelaide'},
    {'text': '(GMT+09:30) Darwin', 'value': 'Australia/Darwin'},
    {'text': '(GMT+10:00) Brisbane', 'value': 'Australia/Brisbane'},
    {
      'text': '(GMT+10:00) Canberra, Melbourne, Sydney',
      'value': 'Australia/Canberra',
    },
    {'text': '(GMT+10:00) Hobart', 'value': 'Australia/Hobart'},
    {'text': '(GMT+10:00) Guam, Port Moresby', 'value': 'Pacific/Guam'},
    {'text': '(GMT+10:00) Vladivostok', 'value': 'Asia/Vladivostok'},
    {
      'text': '(GMT+11:00) Magadan, Solomon Is., New Caledonia',
      'value': 'Asia/Magadan',
    },
    {'text': '(GMT+12:00) Auckland, Wellington', 'value': 'Pacific/Auckland'},
    {
      'text': '(GMT+12:00) Fiji, Kamchatka, Marshall Is.',
      'value': 'Pacific/Fiji',
    },
    {"text": "(GMT+13:00) Nuku'alofa", "value": 'Pacific/Tongatapu'},
  ];
}

class EventDateTimeConstants {
  static final DateTime currentDateTime = DateTime.now();

  static final DateTime defaultStartDateTime = DateTime.utc(
    currentDateTime.year,
    currentDateTime.month,
    currentDateTime.day + 3,
    10,
  );

  static final DateTime defaultEndDateTime = DateTime.utc(
    currentDateTime.year,
    currentDateTime.month,
    currentDateTime.day + 6,
    18,
  );
}
