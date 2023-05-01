

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

private class AuthorizationPinPanelComponentDependencyc9ab79be377ddba2eabeProvider: AuthorizationPinPanelComponentDependency {


    init() {

    }
}
/// ^->MainComponent->AuthorizationPinPanelComponent
private func factory3d9df8e0a52c98f96a49e3b0c44298fc1c149afb(_ component: NeedleFoundation.Scope) -> AnyObject {
    return AuthorizationPinPanelComponentDependencyc9ab79be377ddba2eabeProvider()
}
private class AuthorizationComponentDependency01c300e9208281b9a593Provider: AuthorizationComponentDependency {


    init() {

    }
}
/// ^->MainComponent->AuthorizationComponent
private func factory36d2db3a630304719354e3b0c44298fc1c149afb(_ component: NeedleFoundation.Scope) -> AnyObject {
    return AuthorizationComponentDependency01c300e9208281b9a593Provider()
}

#else
extension MainComponent: Registration {
    public func registerItems() {


    }
}
extension AuthorizationPinPanelComponent: Registration {
    public func registerItems() {

    }
}
extension AuthorizationComponent: Registration {
    public func registerItems() {

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
    registerProviderFactory("^->MainComponent", factoryEmptyDependencyProvider)
    registerProviderFactory("^->MainComponent->AuthorizationPinPanelComponent", factory3d9df8e0a52c98f96a49e3b0c44298fc1c149afb)
    registerProviderFactory("^->MainComponent->AuthorizationComponent", factory36d2db3a630304719354e3b0c44298fc1c149afb)
}
#endif

public func registerProviderFactories() {
#if !NEEDLE_DYNAMIC
    register1()
#endif
}
