//
//  ContentView.swift
//  login design
//
//  Created by Amjad R on 15/03/2023.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isAnimating: Bool = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.red, .yellow]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                LogoView()
                    .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.white)
                    .frame(width: 120, height: 120)
                    .rotationEffect(Angle.degrees(isAnimating ? 360 : 0))
                    .animation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false))
                
                Text("Login to Your Account")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 30)
                
                VStack(spacing: 20) {
                    TextField("Username", text: $username)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(8)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(8)
                    
                    Button(action: {
                        // login button action
                    }) {
                        Text("LOGIN")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.opacity(0.7))
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                HStack {
                    Text("Don't have an account?")
                        .foregroundColor(.white)
                    
                    Button(action: {
                        // sign up button action
                    }) {
                        Text("Sign Up")
                            .foregroundColor(.white)
                    }
                }
                .padding(.bottom, 30)
            }
            .padding(.bottom, 50)
            
            WaveView()
                .fill(Color.white.opacity(0.5))
                .offset(x: 0, y: isAnimating ? -50 : 0)
                .animation(Animation.easeInOut(duration: 1.5).delay(0.5).repeatForever(autoreverses: true))
        }
        .onAppear {
            isAnimating = true
        }
    }
}

struct LogoView: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.closeSubpath()
        
        let insetRect = rect.insetBy(dx: rect.width / 4, dy: rect.width / 4)
        let midPoint = CGPoint(x: insetRect.midX, y: insetRect.midY)
        let radius = insetRect.width / 2
        
        path.move(to: CGPoint(x: midPoint.x + radius, y: midPoint.y))
        path.addArc(center: midPoint, radius: radius, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: true)
        
        return path
    }
}

struct WaveView: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let width = rect.width
        let height = rect.height

        path.move(to: CGPoint(x: 0, y: height / 2))

        let midY = height * 0.7
        let quarterX = width / 4
        let threeQuarterX = width * 3 / 4
        let endX = width

        path.addQuadCurve(to: CGPoint(x: quarterX, y: midY), control: CGPoint(x: quarterX / 2, y: height))
        path.addQuadCurve(to: CGPoint(x: threeQuarterX, y: midY - 30), control: CGPoint(x: width / 2, y: midY + 50))
        path.addQuadCurve(to: CGPoint(x: endX, y: height / 2), control: CGPoint(x: threeQuarterX + quarterX / 2, y: midY - 80))
        path.addLine(to: CGPoint(x: endX, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.closeSubpath()

        return path
    }
}
