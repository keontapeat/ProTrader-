import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            DashboardView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Dashboard")
                }
                .tag(0)
            
            JournalView()
                .tabItem {
                    Image(systemName: "note.text")
                    Text("Journal")
                }
                .tag(1)
            
            AnalysisView()
                .tabItem {
                    Image(systemName: "chart.pie.fill")
                    Text("Analysis")
                }
                .tag(2)
            
            TradingPlanView()
                .tabItem {
                    Image(systemName: "list.bullet.clipboard")
                    Text("Plan")
                }
                .tag(3)
            
            CalendarView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar")
                }
                .tag(4)
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
                .tag(5)
        }
    }
}

// Preview provider
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// End of file. No additional code.
