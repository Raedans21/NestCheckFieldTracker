import SwiftUI

struct DataEntryAddView: View {
    @Binding var tempEntryData: FieldSite.DataEntry.TempDataEntry
    
    var body: some View {
        Form {
            Section(header: Text("Nest Height")) {
                HStack {
                    Slider(value: $tempEntryData.nestHeight, in: 0...12, step: 0.5) {
                        Text("Nest Height")
                    }
                    Spacer()
                    Text("\(tempEntryData.nestHeight.formatted()) inches")
                }
            }
            .frame(width: 280, height: 40, alignment: .leading)
            Section {
                HStack {
                    TextField("Number of Eggs", text: $tempEntryData.numberOfEggs)
                        .keyboardType(.decimalPad)
                    Text("# Eggs")
                }
                HStack {
                    TextField("Eggs Incubating?", text: $tempEntryData.eggsIncubating)
                    Text("Eggs Incubating?")
                }
                HStack {
                    TextField("Number of Nestlings", text: $tempEntryData.numberOfNestlings)
                        .keyboardType(.decimalPad)
                    Text("# Nestlings")
                }
                HStack {
                    TextField("Cup Status", text: $tempEntryData.cupStatus)
                    Text("Cup Status")
                }
            }
            .frame(width: 280, height: 40, alignment: .center)
        }
        .padding(.all)
        .navigationBarTitle("\(tempEntryData.logDate.formatted())")
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
}

struct DataEntryAddView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DataEntryAddView(tempEntryData: .constant(FieldSite.sampleDataEntries1[0].tempDataEntry))
        }
    }
}
