//
//  SwiftUIView.swift
//  DemoDrawer
//
//  Created by Matt H on 2023-02-20.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        
        Home()
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}

// Halfsheet view
struct Home: View {
    @State var showSheet: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Button(action: {
                    showSheet.toggle()
                }) {
                    Text("Activate now with eSIM")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.init(hex: "2FC4C7"))
                        .cornerRadius(10)
                }
                
                .halfSheet(showSheet: $showSheet) {
                    VStack {
                        Image("dual-sim.png")
                            .resizable()
                            .frame(width: 60, height: 60)
                        Text("eSIM detected!")
                            .font(.title.bold())
                        Button(action: {
                            // using an eSIM
                        }) {
                            Text("Activate now with eSIM")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 30)
                                .background(Color.init(hex: "58D6A4"))
                                .cornerRadius(10)
                        }
                        .padding(.bottom, 20)
                        
                        // button/link? for physical SIM
                        Button(action: {
                        }) {
                            Text("Activate a physical SIM")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 30)
                                .background(Color.init(hex: "2FC4C7"))
                                .cornerRadius(10)
                        }
                        
                        /*
                        Text("You can cancel you plan at anytime by calling your \nsupport line at (808) 723-1111 or by porting your \nnumber to another carrier.")
                            .padding(.top, 20)
                            .font(.system(size: 10))
                            .font(.headline)
                         */
                    }
                    .padding(.horizontal)
                    .background(Color.white)
                    .edgesIgnoringSafeArea(.all)
                } onEnd: {
                    print("Half Sheet Dismissed")
                }
            }
            .navigationTitle("") // set empty string to hide default navigation title
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Spacer()
                        Button(action: {
                            // handle button tap
                        }) {
                            Text("Log in")
                        }
                    }
                }
            }
        }
    }
}





// Custom Half Sheet Modifier
extension View {
    
    
    // Binding show variable
    func halfSheet<SheetView: View>(showSheet: Binding<Bool>, @ViewBuilder
                                    sheetView: @escaping () ->SheetView,onEnd: @escaping()->())->some View {
        
        
        // Overlay or background is used
        // to automatically use the swiftui frame size
        return self
            .background(
                HalfSheetHelper(sheetView: sheetView(), showSheet: showSheet, onEnd: onEnd)
            )
    }
}
                
// UIKit integration
                
struct HalfSheetHelper<SheetView: View>: UIViewControllerRepresentable {
    var sheetView: SheetView
    @Binding var showSheet: Bool
    var onEnd: ()->()
                    
    let controller = UIViewController()
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        controller.view.backgroundColor = .clear
        
        return controller
    }
                    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
        if showSheet {
            
            // presenting Modal View
                            
            let sheetController = CustomHostingController(rootView: sheetView)
            
            // Set the sheet controller's view to take up the full width of the screen
            sheetController.view.frame = CGRect(x: 0, y: 0, width: uiViewController.view.bounds.width, height: uiViewController.view.bounds.height)
            
            // Dual SIM icon insertion
            let imageView = UIImageView(image: UIImage(named: "dual-sim.png"))
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            sheetController.view.addSubview(imageView)
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: 50),
                imageView.heightAnchor.constraint(equalToConstant: 50),
                imageView.centerXAnchor.constraint(equalTo: sheetController.view.centerXAnchor),
                imageView.topAnchor.constraint(equalTo: sheetController.view.topAnchor, constant: 20)
            ])
            
            uiViewController.present(sheetController, animated: true) {
                DispatchQueue.main.async {
                    self.showSheet.toggle()
                }
            }
        }
    }
    
    // On Dismiss...
    class Coordinator: NSObject, UISheetPresentationControllerDelegate {
        
        var parent: HalfSheetHelper
        
        init(parent: HalfSheetHelper) {
            self.parent = parent
        }
        
        func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            parent.showSheet = false
            parent.onEnd()
        }
    }
}
        
        
// Custom UIHostingController for halfsheet

class CustomHostingController<Content: View>: UIHostingController<Content>{
                    
    override func viewDidLoad() {
                        
        // setting presentation
        if let presentationController = presentationController as?
            UISheetPresentationController {
            
            presentationController.detents = [
                
                .medium(),
                .large()
            
            ]
            
            // to show grab portion
            presentationController.prefersGrabberVisible = true
        }
    }
}
        
        
