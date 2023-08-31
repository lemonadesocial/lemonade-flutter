class FetchableUrl {

  FetchableUrl({
    required this.protocol,
    required this.href,
  });
  String protocol;
  String href;
}

class IpfsUtils {
  static FetchableUrl getFetchableUrl(String url) {
    final uri = Uri.parse(url);
    final protocol = uri.scheme;
    final href = uri.toString();

    switch (protocol) {
      case 'http':
      case 'data':
      case 'blob:':
      case 'https':
        return FetchableUrl(protocol: protocol, href: href);
      case 'ipfs':
        final parts = url.substring(url.indexOf('://') + 3).split('/');
        final hostname = parts[0].toString();
        final pathname = parts.length >= 2 ? parts[1].toString() : '';
        return FetchableUrl(
            protocol: protocol,
            href: 'https://ipfs.io/ipfs/$hostname/$pathname',);
      default:
        throw Exception('Unsupported protocol $protocol');
    }
  }
}