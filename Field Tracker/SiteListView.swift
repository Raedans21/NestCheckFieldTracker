import SwiftUI

struct SiteListView: View {
    @Binding var sites: [FieldSite]
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresentingNewSiteView = false
    @State private var edittingNotAdding = false
    @State private var tempSiteData = FieldSite.TempSiteEntry()
    let saveAction: ()->Void
    
    var body: some View {
        List {
            ForEach($sites) { $site in
                NavigationLink(destination: SiteInfoView(site: $site)) {
                    SiteView(site: site)
                }
                .swipeActions {
                    Button("Delete", action: {
                        if let pos = sites.firstIndex(of: site) {
                            sites.remove(at: pos)
                        }
                    })
                    .tint(.red)
                    Button("Edit", action: {
                        tempSiteData.name = site.name
                        tempSiteData.dataEntries = site.dataEntries
                        if let pos = sites.firstIndex(of: site) {
                            sites.remove(at: pos)
                        }
                        edittingNotAdding = true
                        isPresentingNewSiteView = true
                    })
                    .tint(.green)
                }
                .listRowBackground(site.theme.mainColor)
                .foregroundColor(site.theme.accentColor)
            }
        }
        .navigationTitle("Field Sites")
        .toolbar {
            Button(action: {
                isPresentingNewSiteView = true
            }) {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $isPresentingNewSiteView) {
            NavigationView {
                SiteEditView(tempSiteEntry: $tempSiteData)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                if !edittingNotAdding {
                                    isPresentingNewSiteView = false
                                    tempSiteData = FieldSite.TempSiteEntry()
                                }
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Confirm") {
                                let newSite = FieldSite(tempSiteEntry: tempSiteData)
                                sites.append(newSite)
                                isPresentingNewSiteView = false
                                edittingNotAdding = false
                                tempSiteData = FieldSite.TempSiteEntry()
                            }
                        }
                    }
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive || phase == .background {saveAction() }
        }
    }
}

struct SiteListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SiteListView(sites: .constant(FieldSite.sampleSites), saveAction: {})
        }
    }
}
