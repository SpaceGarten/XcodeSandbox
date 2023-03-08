import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(red: 0.2, green: 0.26, blue: 0.30)
                .ignoresSafeArea()
            Image("ic-question")
                .resizable()
                .frame(width: 35, height: 35)
                .offset(y: -UIScreen.main.bounds.height * 0.38)
            
            Image("ic-logo")
                .resizable()
                .frame(width: 58, height: 52)
                .offset(y: -UIScreen.main.bounds.height * 0.27)
            
            Image("ic-text1")
                .offset(y: -UIScreen.main.bounds.height * 0.12)
            
            Image("ic-text2")
                .offset(y: UIScreen.main.bounds.height * 0.05)
            
            Image("ic-oval")
                .offset(y: UIScreen.main.bounds.height * 0.18)
            
            Image("ic-continue")
                .offset(y: UIScreen.main.bounds.height * 0.27)
            
            Image("ic-login")
                .offset(y: UIScreen.main.bounds.height * 0.36)
            
            
        
        }
        .foregroundColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
