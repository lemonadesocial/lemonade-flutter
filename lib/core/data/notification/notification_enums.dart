enum NotificationObjectType { 
  StoreOrder,
  Event,
  User
}

const Map<String, NotificationObjectType> objectTypeMap = {
  'StoreOrder': NotificationObjectType.StoreOrder,
  'Event': NotificationObjectType.Event,
  'User': NotificationObjectType.User,
};