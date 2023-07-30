import 'package:app/core/mock_model/chat_room.dart';

final List<ChatRoom> mockDirectMessages = [
  ChatRoom(
    avatarUrl: 'https://i.pravatar.cc/300',
    name: 'John Doe',
    latestMessage: 'Hello there!',
    createdAt: DateTime.now().subtract(Duration(minutes: 1)),
    unseenMessageCount: 3,
  ),
  ChatRoom(
    avatarUrl: 'https://i.pravatar.cc/301',
    name: 'Jane Smith',
    latestMessage: 'Hey! What are you up to?',
    createdAt: DateTime.now().subtract(Duration(minutes: 5)),
    unseenMessageCount: 1,
  ),
  ChatRoom(
    avatarUrl: 'https://i.pravatar.cc/302',
    name: 'Brow Johnson',
    latestMessage: 'Good morning!',
    createdAt: DateTime.now().subtract(Duration(hours: 1)),
    unseenMessageCount: 0,
  ),
  ChatRoom(
    avatarUrl: 'https://i.pravatar.cc/303',
    name: 'Emily Brown',
    latestMessage: 'Wow wow?',
    createdAt: DateTime.now().subtract(Duration(hours: 3)),
    unseenMessageCount: 5,
  ),
  ChatRoom(
    avatarUrl: 'https://i.pravatar.cc/304',
    name: 'John Doe',
    latestMessage: 'HelloPOPOPPPPPPPPP!',
    createdAt: DateTime.now().subtract(Duration(days: 1)),
    unseenMessageCount: 0,
  ),
  ChatRoom(
    avatarUrl: 'https://i.pravatar.cc/305',
    name: 'Jane Smith Nano',
    latestMessage: 'Heyyyyyyyy ?',
    createdAt: DateTime.now().subtract(Duration(days: 1)),
    unseenMessageCount: 0,
  ),
  ChatRoom(
    avatarUrl: 'https://i.pravatar.cc/306',
    name: 'Alex Forguson',
    latestMessage: 'Goodddddd sir!',
    createdAt: DateTime.now().subtract(Duration(days: 2)),
    unseenMessageCount: 0,
  ),
  ChatRoom(
    avatarUrl: 'https://i.pravatar.cc/307',
    name: 'Eric john',
    latestMessage: 'How was yesterday party?',
    createdAt: DateTime.now().subtract(Duration(days: 3)),
    unseenMessageCount: 0,
  ),
  // Add more chat items as needed
];

final List<ChatRoom> mockChannels = [
  ChatRoom(
    name: 'guildelines',
    latestMessage: 'Alex: Hahaha! I bet.',
    createdAt: DateTime.now().subtract(Duration(minutes: 1)),
    unseenMessageCount: 3,
    isPrivate: true
  ),
  ChatRoom(
    name: 'annoucements',
    latestMessage: 'Ron: Virtual Beer Festival',
    createdAt: DateTime.now().subtract(Duration(minutes: 5)),
    unseenMessageCount: 0,
    isPrivate: true
  ),
  ChatRoom(
    name: 'faq',
    latestMessage: 'Ron: How do I buy lemon tokens?',
    createdAt: DateTime.now().subtract(Duration(hours: 1)),
    unseenMessageCount: 0,
    isPrivate: true
  ),
  ChatRoom(
    name: 'staff-applications',
    latestMessage: 'Hazel: Fill the form before 29th to apply!',
    createdAt: DateTime.now().subtract(Duration(hours: 3)),
    unseenMessageCount: 0,
  ),
  ChatRoom(
    name: 'support',
    latestMessage: 'Rachel: Thank you!',
    createdAt: DateTime.now().subtract(Duration(days: 1)),
    unseenMessageCount: 0,
  ),
  ChatRoom(
    name: 'art-gallery',
    latestMessage: 'Alex: Haha!!! I bet',
    createdAt: DateTime.now().subtract(Duration(days: 1)),
    unseenMessageCount: 0,
  ),
  ChatRoom(
    name: 'music-studio',
    latestMessage: 'Ron: Virtual Beer Festival',
    createdAt: DateTime.now().subtract(Duration(days: 2)),
    unseenMessageCount: 0,
  ),
  ChatRoom(
    name: 'design-paradise',
    latestMessage: 'How was yesterday party?',
    createdAt: DateTime.now().subtract(Duration(days: 3)),
    unseenMessageCount: 0,
  ),
  // Add more chat items as needed
];
