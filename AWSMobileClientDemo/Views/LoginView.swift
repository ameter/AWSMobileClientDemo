import SwiftUI
import SwiftUIComponents

struct LoginView: View {
    @EnvironmentObject var mobileClientManager: MobileClientManager
    @Environment(\.presentationMode) var presentationMode
    
    @State var username = ""
    @State var password = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            TextField("Username", text: $username).pretty()
            SecureField("Password", text: $password).pretty()
            
            VStack {
                Button("Sign In") {
                    mobileClientManager.signIn( username: username, password: password)
                    presentationMode.wrappedValue.dismiss()
                }
                    .pretty()
            }
            .fixedSize(horizontal: true, vertical: false)
            Spacer()
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
