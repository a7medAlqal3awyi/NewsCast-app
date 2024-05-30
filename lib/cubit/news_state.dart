abstract class NewsStates  {}
final class NewsInitial extends NewsStates {}

final class ChangeIndexBottomNavBar extends NewsStates {}

final class GetBusinessLoadingNews extends NewsStates {}
final class GetBusinessSuccessNews extends NewsStates {}
final class GetBusinessErrorNews extends NewsStates {}


final class GetTechLoadingNews extends NewsStates {}
final class GetTechSuccessNews extends NewsStates {}
final class GetTechErrorNews extends NewsStates {}

final class GetSportsLoadingNews extends NewsStates {}
final class GetSportsSuccessNews extends NewsStates {}
final class GetSportsErrorNews extends NewsStates {}


final class HealthLoadingNews extends NewsStates {}
final class HealthSuccessNews extends NewsStates {}
final class HealthErrorNews extends NewsStates {}


