enum NotificationObjectType { storeOrder, event, user }

const Map<String, NotificationObjectType> objectTypeMap = {
  "StoreOrder": NotificationObjectType.storeOrder,
  "Event": NotificationObjectType.event,
  "User": NotificationObjectType.user,
};
