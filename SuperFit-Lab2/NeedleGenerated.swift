

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

private class MyBodyComponentDependencyfdb26a7106a090fd9b66Provider: MyBodyComponentDependency {
    var profileRepository: ProfileRepository {
        return mainComponent.profileRepository
    }
    var userBodyParametersRepository: UserBodyParametersRepository {
        return mainComponent.userBodyParametersRepository
    }
    var getMostRecentPhotoUseCase: GetMostRecentPhotoUseCase {
        return mainComponent.getMostRecentPhotoUseCase
    }
    var getLastestPhotoUseCase: GetLatestPhotoUseCase {
        return mainComponent.getLastestPhotoUseCase
    }
    var getLastBodyParametersUseCase: GetLastBodyParametersUseCase {
        return mainComponent.getLastBodyParametersUseCase
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
    var trainingRepository: TrainingRepository {
        return mainComponent.trainingRepository
    }
    var getTrainingInfoModelByTrainingTypeModelUseCase: GetTrainingInfoModelByTrainingTypeModelUseCase {
        return mainComponent.getTrainingInfoModelByTrainingTypeModelUseCase
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
    var getTrainingTypeByTrainingInfoModelUseCase: GetTrainingTypeByTrainingInfoModelUseCase {
        return mainComponent.getTrainingTypeByTrainingInfoModelUseCase
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
private class ExerciseComponentDependency4f7585123a20166ea66eProvider: ExerciseComponentDependency {
    var getTrainingTypeByTrainingInfoModelUseCase: GetTrainingTypeByTrainingInfoModelUseCase {
        return mainComponent.getTrainingTypeByTrainingInfoModelUseCase
    }
    private let mainComponent: MainComponent
    init(mainComponent: MainComponent) {
        self.mainComponent = mainComponent
    }
}
/// ^->MainComponent->ExerciseResultComponent
private func factoryc1b47e3b96c2ebb2d1540ae93e637f014511a119(_ component: NeedleFoundation.Scope) -> AnyObject {
    return ExerciseComponentDependency4f7585123a20166ea66eProvider(mainComponent: parent1(component) as! MainComponent)
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

#else
extension MyBodyComponent: Registration {
    public func registerItems() {
        keyPathToName[\MyBodyComponentDependency.profileRepository] = "profileRepository-ProfileRepository"
        keyPathToName[\MyBodyComponentDependency.userBodyParametersRepository] = "userBodyParametersRepository-UserBodyParametersRepository"
        keyPathToName[\MyBodyComponentDependency.getMostRecentPhotoUseCase] = "getMostRecentPhotoUseCase-GetMostRecentPhotoUseCase"
        keyPathToName[\MyBodyComponentDependency.getLastestPhotoUseCase] = "getLastestPhotoUseCase-GetLatestPhotoUseCase"
        keyPathToName[\MyBodyComponentDependency.getLastBodyParametersUseCase] = "getLastBodyParametersUseCase-GetLastBodyParametersUseCase"
    }
}
extension ExercisesComponent: Registration {
    public func registerItems() {

    }
}
extension MainScreenComponent: Registration {
    public func registerItems() {
        keyPathToName[\MainScreenComponentDependency.trainingRepository] = "trainingRepository-TrainingRepository"
        keyPathToName[\MainScreenComponentDependency.getTrainingInfoModelByTrainingTypeModelUseCase] = "getTrainingInfoModelByTrainingTypeModelUseCase-GetTrainingInfoModelByTrainingTypeModelUseCase"
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
        keyPathToName[\ExerciseComponentDependency.getTrainingTypeByTrainingInfoModelUseCase] = "getTrainingTypeByTrainingInfoModelUseCase-GetTrainingTypeByTrainingInfoModelUseCase"
    }
}
extension ExerciseResultComponent: Registration {
    public func registerItems() {
        keyPathToName[\ExerciseComponentDependency.getTrainingTypeByTrainingInfoModelUseCase] = "getTrainingTypeByTrainingInfoModelUseCase-GetTrainingTypeByTrainingInfoModelUseCase"
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
        keyPathToName[\AuthorizationComponentDependency.emptyValidationUseCase] = "emptyValidationUseCase-EmptyValidationUseCase"
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
    registerProviderFactory("^->MainComponent->MyBodyComponent", factory9a1f6a05e605a2888f250ae93e637f014511a119)
    registerProviderFactory("^->MainComponent->ExercisesComponent", factory898ce2b97f4454014ac8e3b0c44298fc1c149afb)
    registerProviderFactory("^->MainComponent->MainScreenComponent", factoryd2e546a960c33ef2225f0ae93e637f014511a119)
    registerProviderFactory("^->MainComponent", factoryEmptyDependencyProvider)
    registerProviderFactory("^->MainComponent->RegistrationComponent", factorybf509de48c6e5261a8800ae93e637f014511a119)
    registerProviderFactory("^->MainComponent->ExerciseComponent", factory3422b72b04c9baa072ea0ae93e637f014511a119)
    registerProviderFactory("^->MainComponent->ExerciseResultComponent", factoryc1b47e3b96c2ebb2d1540ae93e637f014511a119)
    registerProviderFactory("^->MainComponent->AuthorizationPinPanelComponent", factory3d9df8e0a52c98f96a490ae93e637f014511a119)
    registerProviderFactory("^->MainComponent->AuthorizationComponent", factory36d2db3a6303047193540ae93e637f014511a119)
}
#endif

public func registerProviderFactories() {
#if !NEEDLE_DYNAMIC
    register1()
#endif
}
