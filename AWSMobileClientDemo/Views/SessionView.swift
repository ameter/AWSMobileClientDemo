import SwiftUI
import AWSMobileClientXCF
import SwiftUIComponents

struct SessionView: View {
    @EnvironmentObject var mobileClientManager: MobileClientManager
    @State var showingSignIn = false
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                Button("Start", action: mobileClientManager.start)
                    .pretty()
                
                Button("Sign In") {
                    showingSignIn = true
                }
                    .pretty()
                
                Button("Get Tokens", action: mobileClientManager.getTokens)
                    .pretty()
            }
            .fixedSize(horizontal: true, vertical: false)
            
            Spacer()
        }
        .sheet(isPresented: $showingSignIn) {
            LoginView()
        }
    }
}

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        SessionView()
    }
}
