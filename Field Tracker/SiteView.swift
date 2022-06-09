import SwiftUI

struct SiteView: View {
    let site: FieldSite
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(site.name)
                .font(.headline)
            Spacer()
            HStack {
                Label("\(site.dataEntries.count) Entries", systemImage: "pencil.circle.fill")
                Spacer()
                let lastEntryIndex = site.dataEntries.count - 1
                if lastEntryIndex >= 0 {
                    Text("Last Entry: \(site.dataEntries[lastEntryIndex].logDate.formatted())")
                        .font(.footnote)
                } else {
                    Text("No Entries Yet")
                        .font(.footnote)
                }
            }
        }
        .padding(3)
    }
}

struct SiteView_Previews: PreviewProvider {
    static var site = FieldSite.sampleSites[0]
    static var previews: some View {
        SiteView(site: site)
            .background(site.theme.mainColor)
            .previewLayout(.fixed(width:400, height: 60))
    }
}
