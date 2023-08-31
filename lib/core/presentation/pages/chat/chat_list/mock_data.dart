import 'package:app/core/mock_model/chat_room.dart';

final List<ChatRoom> mockDirectMessages = [
  ChatRoom(
    avatarUrl: 'https://i.pravatar.cc/300',
    name: 'John Doe',
    latestMessage: 'Hello there!',
    createdAt: DateTime.now().subtract(const Duration(minutes: 1)),
    unseenMessageCount: 2,
    isMuted: false,
  ),
  ChatRoom(
    avatarUrl: 'https://i.pravatar.cc/301',
    name: 'Jane Smith',
    latestMessage: 'Hey! What are you up to?',
    createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
    unseenMessageCount: 7,
    isMuted: false,
  ),
  ChatRoom(
    avatarUrl: 'https://i.pravatar.cc/302',
    name: 'Brow Johnson',
    latestMessage: 'Good morning!',
    createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    unseenMessageCount: 1,
    isMuted: true,
  ),
  ChatRoom(
    avatarUrl: 'https://i.pravatar.cc/303',
    name: 'Emily Brown',
    latestMessage: 'Wow wow?',
    createdAt: DateTime.now().subtract(const Duration(hours: 3)),
    unseenMessageCount: 5,
    isMuted: false,
  ),
];

final List<ChatRoom> mockChannels = [
  ChatRoom(
    name: 'guildelines',
    latestMessage: 'Alex: Hahaha! I bet.',
    createdAt: DateTime.now().subtract(const Duration(minutes: 1)),
    unseenMessageCount: 3,
    isPrivate: true,
    isMuted: false,
  ),
  ChatRoom(
    name: 'annoucements',
    latestMessage: 'Ron: Virtual Beer Festival',
    createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
    unseenMessageCount: 20,
    isPrivate: true,
    isMuted: true,
  ),
  ChatRoom(
    name: 'faq',
    latestMessage: 'Ron: How do I buy lemon tokens?',
    createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    unseenMessageCount: 0,
    isPrivate: true,
    isMuted: false,
  ),
  ChatRoom(
    name: 'staff-applications',
    latestMessage: 'Hazel: Fill the form before 29th to apply!',
    createdAt: DateTime.now().subtract(const Duration(hours: 3)),
    unseenMessageCount: 0,
    isMuted: false,
  ),
  
];
