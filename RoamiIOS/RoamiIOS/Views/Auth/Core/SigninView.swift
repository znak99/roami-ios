//
//  SigninView.swift
//  RoamiIOS
//
//  Created by seungwoo on 2025/04/09.
//

import SwiftUI

struct SigninView: View {
    
    @StateObject private var vm: SigninViewModel = .init()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.appBG.ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("ROAMI")
                        .font(.custom(AppFont.novaRound, size: 28))
                        .foregroundStyle(Color.black)
                    Spacer()
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(Color.gray)
                            .frame(width: 20)
                    }
                    .disabled(vm.isLoading)
                }
                
                VStack {
                    Text("Sign In")
                        .font(.custom(AppFont.robotoSemiBold, size: 32))
                        .foregroundStyle(LinearGradient(colors: [.blue, .purple],
                                                        startPoint: .topLeading, endPoint: .bottomTrailing))
                    Text("Access to your account")
                        .font(.custom(AppFont.robotoRegular, size: 16))
                        .foregroundStyle(.gray)
                }
                .padding()
                
                if vm.errorMessage.count > 0 {
                    HStack(spacing: 4) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.system(size: 12))
                        Text(vm.errorMessage)
                            .font(.custom(AppFont.robotoLight, size: 12))
                    }
                    .foregroundStyle(Color.red)
                }
                
                VStack(spacing: 12) {
                    HStack {
                        ZStack {
                            TextField("Email", text: $vm.email)
                                .font(.custom(AppFont.robotoRegular, size: 16))
                                .padding()
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 4))
                                .autocorrectionDisabled()
                                .textInputAutocapitalization(.never)
                                .textContentType(.emailAddress)
                                .keyboardType(.emailAddress)
                                .disabled(vm.isLoading)
                                .onChange(of: vm.email) {
                                    withAnimation {
                                        vm.validateEmail()
                                    }
                                }
                            
                            if vm.email.count > 0 {
                                HStack {
                                    Spacer()
                                    
                                    Button(action: { vm.email = "" }) {
                                        Image(systemName: "xmark")
                                            .foregroundStyle(.gray)
                                    }
                                    .padding(.trailing, 12)
                                    .disabled(vm.isLoading)
                                }
                            }
                        }
                            
                        if vm.isEmailValidated {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.green)
                        }
                    }
                    
                    HStack {
                        ZStack {
                            Group {
                                if vm.isPasswordVisible {
                                    TextField("Password", text: $vm.password)
                                        .keyboardType(.asciiCapable)
                                } else {
                                    SecureField("Password", text: $vm.password)
                                }
                            }
                            .font(.custom(AppFont.robotoRegular, size: 16))
                            .padding()
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                            .autocorrectionDisabled()
                            .textContentType(.password)
                            .textInputAutocapitalization(.never)
                            .disabled(vm.isLoading)
                            .onChange(of: vm.password) {
                                withAnimation {
                                    vm.validatePassword()
                                }
                            }
                            
                            if vm.password.count > 0 {
                                HStack {
                                    Spacer()
                                    Button(action: { vm.isPasswordVisible.toggle() }) {
                                        Image(systemName: vm.isPasswordVisible ? "eye.slash" : "eye")
                                            .foregroundStyle(.gray)
                                    }
                                    .padding(.trailing, 12)
                                    .disabled(vm.isLoading)
                                }
                            }
                        }
                        if vm.isPasswordValidated {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.green)
                        }
                    }
                }
                
                Button(action: vm.signin) {
                    HStack {
                        Spacer()
                        if vm.isLoading {
                            ProgressView()
                                .font(.system(size: 16))
                                .tint(Color.white)
                        } else {
                            Text("Sign In")
                                .font(.custom(AppFont.robotoMedium, size: 16))
                                .foregroundStyle(.white)
                        }
                        Spacer()
                    }
                    .padding(.vertical, 12)
                    .background(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .topTrailing))
                    .clipShape(RoundedRectangle(cornerRadius: 2))
                }
                .disabled(!vm.isEmailValidated || !vm.isPasswordValidated)
                .padding(.top)
                
                NavigationLink(destination: EmptyView()) {
                    HStack {
                        Text("Forgot your password?")
                            .font(.custom(AppFont.robotoMedium, size: 16))
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .foregroundStyle(.black)
                    .padding(12)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 2))
                }
                .padding(.top)
                .disabled(vm.isLoading)
                
                Spacer()
            }
            .padding([.top, .horizontal])
            .alert("Authentication", isPresented: $vm.isShowSignedInAlert) {
                Button("OK", role: .cancel) {
                    dismiss()
                }
            } message: {
                Text("Signed in successfully!")
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EmptyView()
            }
        }
        .background {
            if !self.vm.isLoading {
                EnableBackSwipeGesture()
            }
        }
    }
}



#Preview {
    SigninView()
}
