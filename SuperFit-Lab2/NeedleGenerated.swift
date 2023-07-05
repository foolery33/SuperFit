

import NeedleFoundation
import UIKit

// swiftlint:disable unused_declaration
private let needleDependenciesHash : String? = nil

// MARK: - Traversal Helpers

private func parent1(_ component: NeedleFoundation.Scope) -> NeedleFoundation.Scope {
    return component.parent
}

// MARK: - Providers

#if !NEEDLE_DYNAMIC

private class TrainProgressComponentDependency39fad7231bb9090222ccProvider: TrainProgressComponentDependency {
    var trainingRepository: TrainingRepository {
        return mainComponent.trainingRepository
    }
    var getTrainProgressByTrainingTypeModelUseCase: GetTrainProgressByTrainingTypeModelUseCase {
        return mainComponent.getTrainProgressByTrainingTypeModelUseCase
    }
    private let mainComponent: MainComponent
    init(mainComponent: MainComponent) {
        self.mainComponent = mainComponent
    }
}
/// ^->MainComponent->TrainProgressComponent
private func factoryde965c29a68c660dad650ae93e637f014511a119(_ component: NeedleFoundation.Scope) -> AnyObject {
    return TrainProgressComponentDependency39fad7231bb9090222ccProvider(mainComponent: parent1(component) as! MainComponent)
}
private class MyBodyComponentDependencyfdb26a7106a090fd9b66Provider: MyBodyComponentDependency {
    var profileRepository: ProfileRepository {
        return mainComponent.profileRepository
    }
    var userBodyParametersRepository: UserBodyParametersRepository {
        return mainComponent.userBodyParametersRepository
    }
    var profilePhotosRepository: ProfilePhotosRepository {
        return mainComponent.profilePhotosRepository
    }
    var getMostRecentPhotoUseCase: GetMostRecentPhotoUseCase {
        return mainComponent.getMostRecentPhotoUseCase
    }
    var getLastestPhotoUseCase: GetLatestPhotoUseCase {
        return mainComponent.getLastestPhotoUseCase
    }
    var getBodyParametersValidationErrorUseCase: GetBodyParametersValidationErrorUseCase {
        return mainComponent.getBodyParametersValidationErrorUseCase
    }
    var convertDateToYyyyMmDdUseCase: ConvertDateToYyyyMmDdUseCase {
        return mainComponent.convertDateToYyyyMmDdUseCase
    }
    var convertTimestampToDdMmYyyyUseCase: ConvertTimestampToDdMmYyyyUseCase {
        return mainComponent.convertTimestampToDdMmYyyyUseCase
    }
    private let mainComponent: MainComponent
    init(mainComponent: MainComponent) {
        self.mainComponent = mainComponent
    }
}
/// ^->MainComponent->MyBodyComponent
private func factory9a1f6a05e605a2888f250ae93e637f014511a119(_ component: NeedleFoundation.Scope) -> AnyObject {
    return MyBodyComponentDependencyfdb26a7106a090fd9b66Provider(mainComponent: parent1(component) as! MainComponent)
}
private class ExercisesComponentDependency87121689354ac322309eProvider: ExercisesComponentDependency {


    init() {

    }
}
/// ^->MainComponent->ExercisesComponent
private func factory898ce2b97f4454014ac8e3b0c44298fc1c149afb(_ component: NeedleFoundation.Scope) -> AnyObject {
    return ExercisesComponentDependency87121689354ac322309eProvider()
}
private class MainScreenComponentDependencyf7fb8b48e001394384acProvider: MainScreenComponentDependency {
    var profileRepository: ProfileRepository {
        return mainComponent.profileRepository
    }
    var userBodyParametersRepository: UserBodyParametersRepository {
        return mainComponent.userBodyParametersRepository
    }
    var trainingRepository: TrainingRepository {
        return mainComponent.trainingRepository
    }
    var lastExercisesRepository: LastExercisesRepository {
        return mainComponent.lastExercisesRepository
    }
    var garbageManager: GarbageManager {
        return mainComponent.garbageManager
    }
    var getTrainingInfoModelByTrainingTypeModelUseCase: GetTrainingInfoModelByTrainingTypeModelUseCase {
        return mainComponent.getTrainingInfoModelByTrainingTypeModelUseCase
    }
    var getTwoLastExercisesUseCase: GetTwoLastExercisesUseCase {
        return mainComponent.getTwoLastExercisesUseCase
    }
    var getLastBodyParametersUseCase: GetLastBodyParametersUseCase {
        return mainComponent.getLastBodyParametersUseCase
    }
    private let mainComponent: MainComponent
    init(mainComponent: MainComponent) {
        self.mainComponent = mainComponent
    }
}
/// ^->MainComponent->MainScreenComponent
private func factoryd2e546a960c33ef2225f0ae93e637f014511a119(_ component: NeedleFoundation.Scope) -> AnyObject {
    return MainScreenComponentDependencyf7fb8b48e001394384acProvider(mainComponent: parent1(component) as! MainComponent)
}
private class RegistrationComponentDependency45ce06ac0365c929bb6bProvider: RegistrationComponentDependency {
    var authRepository: AuthRepository {
        return mainComponent.authRepository
    }
    var saveRefreshTokenUseCase: SaveRefreshTokenUseCase {
        return mainComponent.saveRefreshTokenUseCase
    }
    var saveUserEmailUseCase: SaveUserEmailUseCase {
        return mainComponent.saveUserEmailUseCase
    }
    var getRegisterValidationErrorUseCase: GetRegisterValidationErrorUseCase {
        return mainComponent.getRegisterValidationErrorUseCase
    }
    var codeValueChangeUseCase: CodeValueChangeUseCase {
        return mainComponent.codeValueChangeUseCase
    }
    private let mainComponent: MainComponent
    init(mainComponent: MainComponent) {
        self.mainComponent = mainComponent
    }
}
/// ^->MainComponent->RegistrationComponent
private func factorybf509de48c6e5261a8800ae93e637f014511a119(_ component: NeedleFoundation.Scope) -> AnyObject {
    return RegistrationComponentDependency45ce06ac0365c929bb6bProvider(mainComponent: parent1(component) as! MainComponent)
}
private class ExerciseComponentDependency46503fb7e86011a17493Provider: ExerciseComponentDependency {
    var trainingRepository: TrainingRepository {
        return mainComponent.trainingRepository
    }
    var exerciseManagerRepository: ExerciseRepository {
        return mainComponent.exerciseManagerRepository
    }
    var lastExercisesRepository: LastExercisesRepository {
        return mainComponent.lastExercisesRepository
    }
    var getTrainingTypeByTrainingInfoModelUseCase: GetTrainingTypeByTrainingInfoModelUseCase {
        return mainComponent.getTrainingTypeByTrainingInfoModelUseCase
    }
    var convertDateToYyyyMmDdUseCase: ConvertDateToYyyyMmDdUseCase {
        return mainComponent.convertDateToYyyyMmDdUseCase
    }
    private let mainComponent: MainComponent
    init(mainComponent: MainComponent) {
        self.mainComponent = mainComponent
    }
}
/// ^->MainComponent->ExerciseComponent
private func factory3422b72b04c9baa072ea0ae93e637f014511a119(_ component: NeedleFoundation.Scope) -> AnyObject {
    return ExerciseComponentDependency46503fb7e86011a17493Provider(mainComponent: parent1(component) as! MainComponent)
}
private class ImageListComponentDependencya92a62da873e101d3d0dProvider: ImageListComponentDependency {
    var profileRepository: ProfileRepository {
        return mainComponent.profileRepository
    }
    var groupPhotosByMonthUseCase: GroupPhotosByMonthUseCase {
        return mainComponent.groupPhotosByMonthUseCase
    }
    var getMonthAndYearByTimeIntervalUseCase: GetMonthAndYearByTimeIntervalUseCase {
        return mainComponent.getMonthAndYearByTimeIntervalUseCase
    }
    private let mainComponent: MainComponent
    init(mainComponent: MainComponent) {
        self.mainComponent = mainComponent
    }
}
/// ^->MainComponent->ImageListComponent
private func factory59a0ba5befcc3327d7c80ae93e637f014511a119(_ component: NeedleFoundation.Scope) -> AnyObject {
    return ImageListComponentDependencya92a62da873e101d3d0dProvider(mainComponent: parent1(component) as! MainComponent)
}
private class ExerciseResultComponentDependency4f7585123a20166ea66eProvider: ExerciseResultComponentDependency {
    var getTrainingTypeByTrainingInfoModelUseCase: GetTrainingTypeByTrainingInfoModelUseCase {
        return mainComponent.getTrainingTypeByTrainingInfoModelUseCase
    }
    var getFailurePhraseUseCase: GetFailurePhraseUseCase {
        return mainComponent.getFailurePhraseUseCase
    }
    private let mainComponent: MainComponent
    init(mainComponent: MainComponent) {
        self.mainComponent = mainComponent
    }
}
/// ^->MainComponent->ExerciseResultComponent
private func factoryf5f0fd12b202348636450ae93e637f014511a119(_ component: NeedleFoundation.Scope) -> AnyObject {
    return ExerciseResultComponentDependency4f7585123a20166ea66eProvider(mainComponent: parent1(component) as! MainComponent)
}
private class ImageComponentDependency9c9b522294a5a4ecba10Provider: ImageComponentDependency {


    init() {

    }
}
/// ^->MainComponent->ImageComponent
private func factory10dba4ff650751a88113e3b0c44298fc1c149afb(_ component: NeedleFoundation.Scope) -> AnyObject {
    return ImageComponentDependency9c9b522294a5a4ecba10Provider()
}
private class AuthorizationPinPanelComponentDependencyc9ab79be377ddba2eabeProvider: AuthorizationPinPanelComponentDependency {
    var authRepository: AuthRepository {
        return mainComponent.authRepository
    }
    var saveRefreshTokenUseCase: SaveRefreshTokenUseCase {
        return mainComponent.saveRefreshTokenUseCase
    }
    var saveUserEmailUseCase: SaveUserEmailUseCase {
        return mainComponent.saveUserEmailUseCase
    }
    private let mainComponent: MainComponent
    init(mainComponent: MainComponent) {
        self.mainComponent = mainComponent
    }
}
/// ^->MainComponent->AuthorizationPinPanelComponent
private func factory3d9df8e0a52c98f96a490ae93e637f014511a119(_ component: NeedleFoundation.Scope) -> AnyObject {
    return AuthorizationPinPanelComponentDependencyc9ab79be377ddba2eabeProvider(mainComponent: parent1(component) as! MainComponent)
}
private class AuthorizationComponentDependency01c300e9208281b9a593Provider: AuthorizationComponentDependency {
    var userDataManagerRepository: UserDataManagerRepository {
        return mainComponent.userDataManagerRepository
    }
    var emptyValidationUseCase: EmptyValidationUseCase {
        return mainComponent.emptyValidationUseCase
    }
    private let mainComponent: MainComponent
    init(mainComponent: MainComponent) {
        self.mainComponent = mainComponent
    }
}
/// ^->MainComponent->AuthorizationComponent
private func factory36d2db3a6303047193540ae93e637f014511a119(_ component: NeedleFoundation.Scope) -> AnyObject {
    return AuthorizationComponentDependency01c300e9208281b9a593Provider(mainComponent: parent1(component) as! MainComponent)
}
private class StatisticsComponentDependencya91911856f2911c7e472Provider: StatisticsComponentDependency {
    var profileRepository: ProfileRepository {
        return mainComponent.profileRepository
    }
    var trainingRepository: TrainingRepository {
        return mainComponent.trainingRepository
    }
    var getSortedTrainingDatesUseCase: GetSortedTrainingDatesUseCase {
        return mainComponent.getSortedTrainingDatesUseCase
    }
    var getSortedWeightChangesDatesUseCase: GetSortedWeightChangesDatesUseCase {
        return mainComponent.getSortedWeightChangesDatesUseCase
    }
    var getTrainingResultsUseCase: GetTrainingResultsUseCase {
        return mainComponent.getTrainingResultsUseCase
    }
    var getWeightChangesUseCase: GetWeightChangesUseCase {
        return mainComponent.getWeightChangesUseCase
    }
    var getNearestMultipleOfTenUseCase: GetNearestMultipleOfTenUseCase {
        return mainComponent.getNearestMultipleOfTenUseCase
    }
    private let mainComponent: MainComponent
    init(mainComponent: MainComponent) {
        self.mainComponent = mainComponent
    }
}
/// ^->MainComponent->StatisticsComponent
private func factory93fd75db9bb408e1dac50ae93e637f014511a119(_ component: NeedleFoundation.Scope) -> AnyObject {
    return StatisticsComponentDependencya91911856f2911c7e472Provider(mainComponent: parent1(component) as! MainComponent)
}

#else
extension TrainProgressComponent: Registration {
    public func registerItems() {
        keyPathToName[\TrainProgressComponentDependency.trainingRepository] = "trainingRepository-TrainingRepository"
        keyPathToName[\TrainProgressComponentDependency.getTrainProgressByTrainingTypeModelUseCase] = "getTrainProgressByTrainingTypeModelUseCase-GetTrainProgressByTrainingTypeModelUseCase"
    }
}
extension MyBodyComponent: Registration {
    public func registerItems() {
        keyPathToName[\MyBodyComponentDependency.profileRepository] = "profileRepository-ProfileRepository"
        keyPathToName[\MyBodyComponentDependency.userBodyParametersRepository] = "userBodyParametersRepository-UserBodyParametersRepository"
        keyPathToName[\MyBodyComponentDependency.profilePhotosRepository] = "profilePhotosRepository-ProfilePhotosRepository"
        keyPathToName[\MyBodyComponentDependency.getMostRecentPhotoUseCase] = "getMostRecentPhotoUseCase-GetMostRecentPhotoUseCase"
        keyPathToName[\MyBodyComponentDependency.getLastestPhotoUseCase] = "getLastestPhotoUseCase-GetLatestPhotoUseCase"
        keyPathToName[\MyBodyComponentDependency.getBodyParametersValidationErrorUseCase] = "getBodyParametersValidationErrorUseCase-GetBodyParametersValidationErrorUseCase"
        keyPathToName[\MyBodyComponentDependency.convertDateToYyyyMmDdUseCase] = "convertDateToYyyyMmDdUseCase-ConvertDateToYyyyMmDdUseCase"
        keyPathToName[\MyBodyComponentDependency.convertTimestampToDdMmYyyyUseCase] = "convertTimestampToDdMmYyyyUseCase-ConvertTimestampToDdMmYyyyUseCase"
    }
}
extension ExercisesComponent: Registration {
    public func registerItems() {

    }
}
extension MainScreenComponent: Registration {
    public func registerItems() {
        keyPathToName[\MainScreenComponentDependency.profileRepository] = "profileRepository-ProfileRepository"
        keyPathToName[\MainScreenComponentDependency.userBodyParametersRepository] = "userBodyParametersRepository-UserBodyParametersRepository"
        keyPathToName[\MainScreenComponentDependency.trainingRepository] = "trainingRepository-TrainingRepository"
        keyPathToName[\MainScreenComponentDependency.lastExercisesRepository] = "lastExercisesRepository-LastExercisesRepository"
        keyPathToName[\MainScreenComponentDependency.garbageManager] = "garbageManager-GarbageManager"
        keyPathToName[\MainScreenComponentDependency.getTrainingInfoModelByTrainingTypeModelUseCase] = "getTrainingInfoModelByTrainingTypeModelUseCase-GetTrainingInfoModelByTrainingTypeModelUseCase"
        keyPathToName[\MainScreenComponentDependency.getTwoLastExercisesUseCase] = "getTwoLastExercisesUseCase-GetTwoLastExercisesUseCase"
        keyPathToName[\MainScreenComponentDependency.getLastBodyParametersUseCase] = "getLastBodyParametersUseCase-GetLastBodyParametersUseCase"
    }
}
extension MainComponent: Registration {
    public func registerItems() {


    }
}
extension RegistrationComponent: Registration {
    public func registerItems() {
        keyPathToName[\RegistrationComponentDependency.authRepository] = "authRepository-AuthRepository"
        keyPathToName[\RegistrationComponentDependency.saveRefreshTokenUseCase] = "saveRefreshTokenUseCase-SaveRefreshTokenUseCase"
        keyPathToName[\RegistrationComponentDependency.saveUserEmailUseCase] = "saveUserEmailUseCase-SaveUserEmailUseCase"
        keyPathToName[\RegistrationComponentDependency.getRegisterValidationErrorUseCase] = "getRegisterValidationErrorUseCase-GetRegisterValidationErrorUseCase"
        keyPathToName[\RegistrationComponentDependency.codeValueChangeUseCase] = "codeValueChangeUseCase-CodeValueChangeUseCase"
    }
}
extension ExerciseComponent: Registration {
    public func registerItems() {
        keyPathToName[\ExerciseComponentDependency.trainingRepository] = "trainingRepository-TrainingRepository"
        keyPathToName[\ExerciseComponentDependency.exerciseManagerRepository] = "exerciseManagerRepository-ExerciseRepository"
        keyPathToName[\ExerciseComponentDependency.lastExercisesRepository] = "lastExercisesRepository-LastExercisesRepository"
        keyPathToName[\ExerciseComponentDependency.getTrainingTypeByTrainingInfoModelUseCase] = "getTrainingTypeByTrainingInfoModelUseCase-GetTrainingTypeByTrainingInfoModelUseCase"
        keyPathToName[\ExerciseComponentDependency.convertDateToYyyyMmDdUseCase] = "convertDateToYyyyMmDdUseCase-ConvertDateToYyyyMmDdUseCase"
    }
}
extension ImageListComponent: Registration {
    public func registerItems() {
        keyPathToName[\ImageListComponentDependency.profileRepository] = "profileRepository-ProfileRepository"
        keyPathToName[\ImageListComponentDependency.groupPhotosByMonthUseCase] = "groupPhotosByMonthUseCase-GroupPhotosByMonthUseCase"
        keyPathToName[\ImageListComponentDependency.getMonthAndYearByTimeIntervalUseCase] = "getMonthAndYearByTimeIntervalUseCase-GetMonthAndYearByTimeIntervalUseCase"
    }
}
extension ExerciseResultComponent: Registration {
    public func registerItems() {
        keyPathToName[\ExerciseResultComponentDependency.getTrainingTypeByTrainingInfoModelUseCase] = "getTrainingTypeByTrainingInfoModelUseCase-GetTrainingTypeByTrainingInfoModelUseCase"
        keyPathToName[\ExerciseResultComponentDependency.getFailurePhraseUseCase] = "getFailurePhraseUseCase-GetFailurePhraseUseCase"
    }
}
extension ImageComponent: Registration {
    public func registerItems() {

    }
}
extension AuthorizationPinPanelComponent: Registration {
    public func registerItems() {
        keyPathToName[\AuthorizationPinPanelComponentDependency.authRepository] = "authRepository-AuthRepository"
        keyPathToName[\AuthorizationPinPanelComponentDependency.saveRefreshTokenUseCase] = "saveRefreshTokenUseCase-SaveRefreshTokenUseCase"
        keyPathToName[\AuthorizationPinPanelComponentDependency.saveUserEmailUseCase] = "saveUserEmailUseCase-SaveUserEmailUseCase"
    }
}
extension AuthorizationComponent: Registration {
    public func registerItems() {
        keyPathToName[\AuthorizationComponentDependency.userDataManagerRepository] = "userDataManagerRepository-UserDataManagerRepository"
        keyPathToName[\AuthorizationComponentDependency.emptyValidationUseCase] = "emptyValidationUseCase-EmptyValidationUseCase"
    }
}
extension StatisticsComponent: Registration {
    public func registerItems() {
        keyPathToName[\StatisticsComponentDependency.profileRepository] = "profileRepository-ProfileRepository"
        keyPathToName[\StatisticsComponentDependency.trainingRepository] = "trainingRepository-TrainingRepository"
        keyPathToName[\StatisticsComponentDependency.getSortedTrainingDatesUseCase] = "getSortedTrainingDatesUseCase-GetSortedTrainingDatesUseCase"
        keyPathToName[\StatisticsComponentDependency.getSortedWeightChangesDatesUseCase] = "getSortedWeightChangesDatesUseCase-GetSortedWeightChangesDatesUseCase"
        keyPathToName[\StatisticsComponentDependency.getTrainingResultsUseCase] = "getTrainingResultsUseCase-GetTrainingResultsUseCase"
        keyPathToName[\StatisticsComponentDependency.getWeightChangesUseCase] = "getWeightChangesUseCase-GetWeightChangesUseCase"
        keyPathToName[\StatisticsComponentDependency.getNearestMultipleOfTenUseCase] = "getNearestMultipleOfTenUseCase-GetNearestMultipleOfTenUseCase"
    }
}


#endif

private func factoryEmptyDependencyProvider(_ component: NeedleFoundation.Scope) -> AnyObject {
    return EmptyDependencyProvider(component: component)
}

// MARK: - Registration
private func registerProviderFactory(_ componentPath: String, _ factory: @escaping (NeedleFoundation.Scope) -> AnyObject) {
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: componentPath, factory)
}

#if !NEEDLE_DYNAMIC

@inline(never) private func register1() {
    registerProviderFactory("^->MainComponent->TrainProgressComponent", factoryde965c29a68c660dad650ae93e637f014511a119)
    registerProviderFactory("^->MainComponent->MyBodyComponent", factory9a1f6a05e605a2888f250ae93e637f014511a119)
    registerProviderFactory("^->MainComponent->ExercisesComponent", factory898ce2b97f4454014ac8e3b0c44298fc1c149afb)
    registerProviderFactory("^->MainComponent->MainScreenComponent", factoryd2e546a960c33ef2225f0ae93e637f014511a119)
    registerProviderFactory("^->MainComponent", factoryEmptyDependencyProvider)
    registerProviderFactory("^->MainComponent->RegistrationComponent", factorybf509de48c6e5261a8800ae93e637f014511a119)
    registerProviderFactory("^->MainComponent->ExerciseComponent", factory3422b72b04c9baa072ea0ae93e637f014511a119)
    registerProviderFactory("^->MainComponent->ImageListComponent", factory59a0ba5befcc3327d7c80ae93e637f014511a119)
    registerProviderFactory("^->MainComponent->ExerciseResultComponent", factoryf5f0fd12b202348636450ae93e637f014511a119)
    registerProviderFactory("^->MainComponent->ImageComponent", factory10dba4ff650751a88113e3b0c44298fc1c149afb)
    registerProviderFactory("^->MainComponent->AuthorizationPinPanelComponent", factory3d9df8e0a52c98f96a490ae93e637f014511a119)
    registerProviderFactory("^->MainComponent->AuthorizationComponent", factory36d2db3a6303047193540ae93e637f014511a119)
    registerProviderFactory("^->MainComponent->StatisticsComponent", factory93fd75db9bb408e1dac50ae93e637f014511a119)
}
#endif

public func registerProviderFactories() {
#if !NEEDLE_DYNAMIC
    register1()
#endif
}
