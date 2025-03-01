import SwiftUI

struct ConfettiView: View {
    @State private var particles = [Particle]()
    let colors: [Color] = [.red, .pink, .purple]
    
    struct Particle: Identifiable {
        let id = UUID()
        var position: CGPoint
        var finalPosition: CGPoint
        var scale: CGFloat
        var opacity: Double
        var rotation: Double
        var color: Color
    }
    
    func createParticles(at position: CGPoint) {
        for _ in 0..<20 {
            let randomX = Double.random(in: -100...100)
            let randomY = Double.random(in: -50...50)
            let particle = Particle(
                position: position,
                finalPosition: CGPoint(
                    x: position.x + randomX,
                    y: position.y + randomY - 200
                ),
                scale: CGFloat.random(in: 0.2...0.5),
                opacity: 1,
                rotation: Double.random(in: 0...360),
                color: colors.randomElement() ?? .red
            )
            particles.append(particle)
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(particles) { particle in
                    HeartShape()
                        .fill(particle.color)
                        .frame(width: 20, height: 20)
                        .scaleEffect(particle.scale)
                        .opacity(particle.opacity)
                        .rotationEffect(.degrees(particle.rotation))
                        .position(particle.position)
                }
            }
            .onTapGesture { location in
                createParticles(at: location)
                
                for index in particles.indices {
                    withAnimation(.easeOut(duration: 1)) {
                        particles[index].position = particles[index].finalPosition
                        particles[index].opacity = 0
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    particles.removeAll()
                }
            }
        }
    }
}

#Preview {
    ConfettiView()
}
