class FetchableUrl {
  String protocol;
  String href;

  FetchableUrl({
    required this.protocol,
    required this.href,
  });
}

class IpfsUtils {
  static FetchableUrl getFetchableUrl(String url) {
    Uri uri = Uri.parse(url);
    String protocol = uri.scheme;
    String href = uri.toString();

    switch (protocol) {
      case 'http':
      case 'data':
      case 'blob:':
      case 'https':
        return FetchableUrl(protocol: protocol, href: href);
      case 'ipfs':
        var parts = url.substring(url.indexOf('://') + 3).split('/');
        var hostname = parts[0].toString();
        var pathname = parts.length >= 2 ? parts[1].toString() : '';
        return FetchableUrl(
          protocol: protocol,
          href: 'https://ipfs.io/ipfs/$hostname/$pathname',
        );
      default:
        throw Exception('Unsupported protocol $protocol');
    }
  }
}
