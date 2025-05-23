class DiceBearUtils {
  static String getSpaceImageUrl({
    required String id,
  }) {
    final uri = Uri.parse(
      "https://api.dicebear.com/9.x/glass/png?seed=$id&backgroundColor=4799eb,47d0eb,47ebeb,b6e3f4,c0aede,d1d4f9,ebd047,ffd5dc,ffdfbf&backgroundType=gradientLinear&backgroundRotation=-90&shape1=a,d,e,i,n,r,t,g&shape2=d,e,g,i,n,r,t,a&randomizeIds=false",
    );
    final rawValue = uri.toString();
    return rawValue;
  }

  static String getUserImageUrl({
    required String id,
  }) {
    final uri = Uri.parse(
      "https://api.dicebear.com/9.x/thumbs/png?seed=$id&backgroundColor=b6e3f4,d1d4f9,f1f4dc,ffd5dc,ffdfbf&backgroundType=gradientLinear&backgroundRotation=-90&eyes=variant2W16,variant3W16,variant4W16,variant5W16,variant6W16,variant7W16,variant8W16,variant9W16&eyesColor=000000&face=variant1&mouth=variant1,variant2,variant3,variant4&mouthColor=000000&shapeColor=transparent",
    );
    final rawValue = uri.toString();
    return rawValue;
  }
}
