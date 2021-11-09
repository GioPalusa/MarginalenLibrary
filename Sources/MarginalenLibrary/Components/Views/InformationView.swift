//
//  InformationView.swift
//  Marginalen
//
//  Created by michaelst on 2021-03-26.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

struct InformationView: ViewModifier {
    @Binding var presentModal: Bool

    var status: InformationView.Status = .undeterminable
    var title: String? = ""
    var message: String
    var primaryButton: PrimaryButton
    var secondaryButton: SecondaryButton?

    init(status: InformationView.Status = .undeterminable,
         title: String? = "",
         message: String,
         primaryButton: PrimaryButton,
         secondaryButton: SecondaryButton? = nil,
         presentModal: Binding<Bool>) {
        self.status = status
        self.title = title
        self.message = message
        self.primaryButton = primaryButton
        self.secondaryButton = secondaryButton
        self._presentModal = presentModal
    }

    func body(content: Content) -> some View {
        content
            .overlay(
                VStack {
                    if presentModal {
                        VStack {
                            Spacer()
                            VStack(spacing: 0) {
                                BadgeImageView(status: status)
                                    .frame(width: 68, height: 68, alignment: .center)
                                    .padding(.top, 6).padding(.bottom, 24)
                                TitleText(status: status, title: title ?? "")
                                    .font(font: .regularTitle)
                                    .padding(.bottom, 8)
                                    .multilineTextAlignment(.center)
                                Text(message)
                                    .font(font: .body)
                                    .lineSpacing(6)
                                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 40, trailing: 24))
                                    .multilineTextAlignment(.center)
                                primaryButton
                                    .padding(.bottom, secondaryButton != nil ? 16 : 40)
                                if secondaryButton != nil {
                                    secondaryButton
                                        .padding(.bottom, 40)
                                }
                            }
                            .background(Color.clear.overlay(InformationViewBackground()))
                            .marginalenShadow()
                            .animation(.easeIn)
                            .zIndex(1)
                        }
                        .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .bottom)))
                        .edgesIgnoringSafeArea(.bottom)
                        .onAppear { hideKeyboard() }
                    }
                }.background(
                    fadedBackground
                        .transition(.opacity)
                        .onTapGesture {
                            withAnimation { presentModal = false }
                        }
                )
            )
    }

    var fadedBackground: some View {
        if presentModal {
            return AnyView(EmptyView().dimmed())
        } else {
            return AnyView(EmptyView())
        }
    }

    struct TitleText: View {
        var status: Status
        var title: String
        var body: some View {
            switch status {
            case .success:
                Text(title).foregroundColor(Color(UIColor.MarginalenColors.greenyBlue.color))
            case .failure:
                Text(title).foregroundColor(Color(UIColor.MarginalenColors.primaryRed.color))
            default:
                Text(title).foregroundColor(Color(UIColor.MarginalenColors.brightSkyBlue.color))
            }
        }
    }

    struct BadgeImageView: View {
        var status: Status
        var body: some View {
            switch status {
            case .success:
                Image("badge_success").resizable()
            case .failure:
                Image("badge_error").resizable()
            default:
                Image("badge_info").resizable()
            }
        }
    }

    enum Status {
        case success
        case failure
        case undeterminable
    }
}

struct InformationViewBackground: View {
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            Path { path in
                path.move(to: CGPoint(x: width / 2 + 26.8, y: 11.04))
                path.addCurve(to: CGPoint(x: width / 2 + 37.7, y: 27.5),
                              control1: CGPoint(x: width / 2 + 31.6, y: 15.49),
                              control2: CGPoint(x: width / 2 + 35.5, y: 21.12))
                path.addLine(to: CGPoint(x: width + 0.5, y: 27.5))
                path.addLine(to: CGPoint(x: width + 0.5, y: height))
                path.addLine(to: CGPoint(x: -0.5, y: height))
                path.addLine(to: CGPoint(x: -0.5, y: 27.5))
                path.addLine(to: CGPoint(x: width / 2 - 37.7, y: 27.5))
                path.addCurve(to: CGPoint(x: width / 2, y: 0.5),
                              control1: CGPoint(x: width / 2 - 31, y: 11.73),
                              control2: CGPoint(x: width / 2 - 17.27, y: 0.5))
                path.addCurve(to: CGPoint(x: width / 2 + 26.8, y: 11.04),
                              control1: CGPoint(x: width / 2 + 10.29, y: 0.5),
                              control2: CGPoint(x: width / 2 + 19.67, y: 4.48))
            }
            .fill(Color(UIColor.secondarySystemGroupedBackground))
        }
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {

        Group {
            Rectangle().frame(width: 375, height: 277, alignment: .center)
                .presentInformationView(status: .success, title: "Lorem ipsum", message: "We have a success", primaryButton: PrimaryButton(text: "Ok", action: {}), presentModal: .constant(true)).previewLayout(.sizeThatFits)
            Rectangle().frame(width: 375, height: 277, alignment: .center)
                .presentInformationView(status: .failure, title: "Lorem ipsum", message: "We have a failure", primaryButton: PrimaryButton(text: "Ok", action: {}), presentModal: .constant(true)).previewLayout(.sizeThatFits)
            Rectangle().frame(width: 375, height: 277, alignment: .center)
                .presentInformationView(status: .undeterminable, title: "Lorem ipsum", message: "We can't really decide", primaryButton: PrimaryButton(text: "Ok", action: {}), presentModal: .constant(true)).previewLayout(.sizeThatFits)
        }

    }
}
