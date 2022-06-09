import SwiftUI

struct DataEntryView: View {
    @Binding var site: FieldSite
    @Binding var dataEntry: FieldSite.DataEntry
        
    var body: some View {
        Text(site.name)
            .font(.largeTitle)
        List {
            Section(header: Text("\("Entry from \(dataEntry.logDate.formatted())")")) {
                HStack {
                    Text("Nest Height")
                    Spacer()
                    Text("\(dataEntry.nestHeight.formatted())")
                }
                HStack {
                    Text("Number of Eggs")
                    Spacer()
                    Text(dataEntry.numberOfEggs)
                }
                HStack {
                    Text("Eggs Incubating")
                    Spacer()
                    Text(dataEntry.eggsIncubating)
                }
                HStack {
                    Text("Number of Nestlings")
                    Spacer()
                    Text(dataEntry.numberOfNestlings)
                }
                HStack {
                    Text("Cup Status")
                    Spacer()
                    Text(dataEntry.cupStatus)
                }
            }
        }
        Button(action: {
            site.findAndRemove(dataEntries: site.dataEntries, dataEntry: dataEntry)
        }, label: { Text("Delete")})
    }
}

struct DataEntryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DataEntryView(site: .constant(FieldSite.sampleSites[0]), dataEntry: .constant(FieldSite.sampleDataEntries1[0]))
        }
    }

}
