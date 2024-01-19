class RewardViewModel {
  final String name;
  final String icon;

  RewardViewModel({required this.name, required this.icon});

  static List<RewardViewModel> staticRewards = [
    RewardViewModel(
      name: 'Energy drink',
      icon: '/assets/images/rewards/energy_drink.png',
    ),
    RewardViewModel(
      name: 'Lemonade',
      icon: '/assets/images/rewards/lemonade.png',
    ),
    RewardViewModel(name: 'Beer', icon: '/assets/images/rewards/beer.png'),
    RewardViewModel(
      name: 'Mocktail',
      icon: '/assets/images/rewards/mocktail.png',
    ),
    RewardViewModel(name: 'Wine', icon: '/assets/images/rewards/wine.png'),
    RewardViewModel(
      name: 'Cocktail',
      icon: '/assets/images/rewards/cocktail.png',
    ),
    RewardViewModel(
      name: 'Present',
      icon: '/assets/images/rewards/present.png',
    ),
    RewardViewModel(name: 'Coffee', icon: '/assets/images/rewards/coffee.png'),
    RewardViewModel(name: 'Fries', icon: '/assets/images/rewards/fries.png'),
    RewardViewModel(name: 'Pizza', icon: '/assets/images/rewards/pizza.png'),
    RewardViewModel(
      name: 'Popcorn',
      icon: '/assets/images/rewards/popcorn.png',
    ),
  ];
}
