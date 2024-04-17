class GuildUtils {
  static String getFullImageUrl(String input) {
    const String baseUrl = 'https://guild.xyz/';

    // If input starts with 'https://' it's already a full URL
    if (input.startsWith('https://')) {
      return input;
    }

    // If input starts with '/', it's a path, so concatenate with baseUrl
    if (input.startsWith('/')) {
      return '$baseUrl$input';
    }

    return input;
  }

  static String getFullGuildUrl(String name) {
    return 'https://guild.xyz/$name';
  }
}
