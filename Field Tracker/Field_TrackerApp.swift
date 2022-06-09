import SwiftUI

@main
struct Field_TrackerApp: App {
    @StateObject private var store = FieldSiteStore()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                SiteListView(sites: $store.sites) {
                    FieldSiteStore.save(sites: store.sites) { result in
                        if case .failure(let error) = result {
                            fatalError(error.localizedDescription)
                        }
                    }
                }
            }
            .onAppear {
                FieldSiteStore.load { result in
                    switch result {
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                    case .success(let sites):
                        store.sites = sites
                    }
                }
            }
        }
    }
}
