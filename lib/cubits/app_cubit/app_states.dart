class AppStates {}

class AppInitialState extends AppStates {}

class AppRefreshState extends AppStates {}

class AppGetPlacesLoadingState extends AppStates {}

class AppGetPlacesSuccessState extends AppStates {}

class AppGetPlacesErrorState extends AppStates {
  String? error;
  AppGetPlacesErrorState(this.error);
}

class AppGetUserCurrentLatLangLoadingState extends AppStates {}

class AppGetUserCurrentLatLangSuccessState extends AppStates {}
