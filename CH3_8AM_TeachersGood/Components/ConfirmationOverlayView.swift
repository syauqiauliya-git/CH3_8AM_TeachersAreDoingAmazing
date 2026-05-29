import SwiftUI

struct ConfirmationOverlayView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            // 1. Background Dim/Gelap Transparan semu-semu abu seperti di gambar
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                // Menutup pop-up jika area luar diketuk (opsional)
                .onTapGesture {
                    withAnimation {
                        isPresented = false
                    }
                }
            
            // 2. Kotak Putih Pop-up Konten
            VStack(spacing: 20) {
                // Ikon Centang Hijau
                ZStack {
                    Circle()
                        .fill(Color(red: 92/255, green: 184/255, blue: 60/255)) // Warna hijau sukses
                        .frame(width: 76, height: 76)
                    
                    Image(systemName: "checkmark")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.white)
                }
                .padding(.top, 10)
                
                // Teks Konfirmasi
                Text("Your voice entry has been sent!")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(Color(red: 112/255, green: 111/255, blue: 207/255)) // Sesuaikan tone ungu teksnya
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
            }
            .frame(width: 280, height: 200)
            .background(Color.white)
            .cornerRadius(24)
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        }
    }
}

#Preview {
    ConfirmationOverlayView(isPresented: .constant(true))
}