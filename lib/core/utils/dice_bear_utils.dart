class DiceBearUtils {
  static String getImageUrl({
    required String id,
  }) {
    final uri = Uri.parse(
      "https://api.dicebear.com/9.x/glass/png?seed=$id&backgroundColor=4799eb,47d0eb,47ebeb,b6e3f4,c0aede,d1d4f9,ebd047,ffd5dc,ffdfbf&backgroundType=gradientLinear&backgroundRotation=-90&shape1=a,d,e,i,n,r,t,g&shape2=d,e,g,i,n,r,t,a&randomizeIds=false",
    );
    final rawValue = uri.toString();
    return rawValue;
  }
}
