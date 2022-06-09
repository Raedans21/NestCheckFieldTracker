import SwiftUI

struct SiteEditView: View {
    @Binding var tempSiteEntry: FieldSite.TempSiteEntry
    var body: some View {
        Form {
            Section(header: Text("Site Name")) {
                TextField("Site Name", text: $tempSiteEntry.name)
            }
        }
    }
}

struct SiteEditView_Previews: PreviewProvider {
    static var previews: some View {
        SiteEditView(tempSiteEntry: .constant(FieldSite.sampleSites[0].tempSiteEntry))
    }
}
