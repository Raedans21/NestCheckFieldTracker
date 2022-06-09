import SwiftUI

struct SiteInfoView: View {
    @Binding var site: FieldSite
    @State private var isPresentingNewEntryView = false
    @State private var editingNotAdding = false
    @State private var tempDataEntry = FieldSite.DataEntry.TempDataEntry()
    
    func setTempData(dataEntry: FieldSite.DataEntry) {
        tempDataEntry.logDate = dataEntry.logDate
        tempDataEntry.nestHeight = dataEntry.nestHeight
        tempDataEntry.numberOfEggs = dataEntry.numberOfEggs
        tempDataEntry.eggsIncubating = dataEntry.eggsIncubating
        tempDataEntry.numberOfNestlings = dataEntry.numberOfNestlings
        tempDataEntry.cupStatus = dataEntry.cupStatus
    }
    
    func deleteItems(at offsets: IndexSet) {
        site.dataEntries.remove(atOffsets: offsets)
    }
    
    var body: some View {
        List {
            ForEach($site.dataEntries) { $dataEntry in
                NavigationLink(destination: DataEntryView(site: $site, dataEntry: $dataEntry)) {
                    DataCardView(entry: dataEntry)
                }
                .swipeActions {
                    Button("Edit", action: {
                        setTempData(dataEntry: dataEntry)
                        editingNotAdding = true
                        isPresentingNewEntryView = true
                    })
                    .tint(.green)
                }
                .listRowBackground(site.theme.mainColor)
                .foregroundColor(site.theme.accentColor)
            }
            .onDelete(perform: deleteItems)
            
        }
        .navigationTitle(site.name)
        .foregroundColor(site.theme.accentColor)
        .toolbar {
            Button(action: {
                isPresentingNewEntryView = true
            }) {
                Image(systemName: "pencil.circle")
            }
        }
        .sheet(isPresented: $isPresentingNewEntryView) {
            NavigationView {
                DataEntryAddView(tempEntryData: $tempDataEntry)
                    .toolbar{
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingNewEntryView = false
                                tempDataEntry = FieldSite.DataEntry.TempDataEntry()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Confirm") {
                                if editingNotAdding {
                                    var logTimes: [Date] = []
                                    for entry in site.dataEntries {
                                        logTimes.append(entry.logDate)
                                    }
                                    if let pos = logTimes.firstIndex(of: tempDataEntry.logDate) {
                                        let newEntry = FieldSite.DataEntry(tempDataEntry: tempDataEntry)
                                        site.dataEntries[pos] = newEntry
                                    }
                                }
                                if !editingNotAdding {
                                    let newEntry = FieldSite.DataEntry(tempDataEntry: tempDataEntry)
                                    if newEntry.nestHeight != 0 || newEntry.cupStatus != ""  || newEntry.numberOfNestlings != "" || newEntry.numberOfEggs != "" || newEntry.eggsIncubating != "" {
                                    let newEntry = FieldSite.DataEntry(tempDataEntry: tempDataEntry)
                                    site.dataEntries.append(newEntry)
                                    }
                                }
                                isPresentingNewEntryView = false
                                editingNotAdding = false
                                tempDataEntry = FieldSite.DataEntry.TempDataEntry()
                            }
                        }
                    }
            }
        }
    }
}

struct SiteInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SiteInfoView(site: .constant(FieldSite.sampleSites[1]))
    }
}
