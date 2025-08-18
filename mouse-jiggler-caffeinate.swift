#!/usr/bin/env swift

//
//  mouse-jiggler-caffeinate.swift
//  Alternative implementation using caffeinate command
//
//  Created by Jorge Quezada
//  License: MIT
//

import Cocoa
import Foundation

// Ensure unbuffered output for real-time feedback
setbuf(stdout, nil)

// Configuration
let JIGGLE_INTERVAL: TimeInterval = 30.0  // Seconds between jiggles
let JIGGLE_DISTANCE: CGFloat = 1.0        // Pixels to move (1 pixel is imperceptible)

// Start caffeinate process to prevent sleep
let caffeinateProcess = Process()
caffeinateProcess.executableURL = URL(fileURLWithPath: "/usr/bin/caffeinate")
caffeinateProcess.arguments = ["-disu"]  // Prevent display, idle, and system sleep

do {
    try caffeinateProcess.run()
    print("Caffeinate process started (PID: \(caffeinateProcess.processIdentifier))")
} catch {
    print("Warning: Could not start caffeinate process: \(error)")
}

// Display welcome message
print("Mouse Jiggler v1.0.0 (Caffeinate Edition)")
print("==========================================")
print("Preventing system sleep by:")
print("  • Moving mouse every \(Int(JIGGLE_INTERVAL)) seconds")
print("  • Running caffeinate process")
print("Press Ctrl+C to stop\n")

// Handle graceful shutdown on Ctrl+C
signal(SIGINT) { _ in
    print("\n\nTerminating caffeinate process...")
    caffeinateProcess.terminate()
    print("Mouse Jiggler stopped")
    fflush(stdout)
    exit(0)
}

// Statistics
var jiggleCount = 0
let startTime = Date()

// Function to perform mouse jiggle
func jiggleMouse() {
    // Get current mouse position
    let currentLocation = NSEvent.mouseLocation
    
    // Convert to screen coordinates and move cursor
    if let screen = NSScreen.main {
        let screenFrame = screen.frame
        let currentX = currentLocation.x
        let currentY = screenFrame.height - currentLocation.y
        
        // Move mouse slightly
        let newPosition = CGPoint(x: currentX + JIGGLE_DISTANCE, y: currentY)
        CGWarpMouseCursorPosition(newPosition)
        
        // Brief pause
        Thread.sleep(forTimeInterval: 0.01)
        
        // Return to original position
        CGWarpMouseCursorPosition(CGPoint(x: currentX, y: currentY))
        
        jiggleCount += 1
        
        // Log activity with timestamp
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let runtime = formatRuntime(Date().timeIntervalSince(startTime))
        print("[\(formatter.string(from: Date()))] Jiggle #\(jiggleCount) | Runtime: \(runtime)")
        fflush(stdout)
    } else {
        print("Warning: Unable to access main screen")
        fflush(stdout)
    }
}

// Format runtime duration
func formatRuntime(_ seconds: TimeInterval) -> String {
    let hours = Int(seconds) / 3600
    let minutes = (Int(seconds) % 3600) / 60
    let secs = Int(seconds) % 60
    
    if hours > 0 {
        return String(format: "%dh %dm %ds", hours, minutes, secs)
    } else if minutes > 0 {
        return String(format: "%dm %ds", minutes, secs)
    } else {
        return String(format: "%ds", secs)
    }
}

// Perform initial jiggle to confirm it's working
print("Starting... (performing initial jiggle)")
jiggleMouse()
print("")

// Main loop
while true {
    // Wait for next jiggle interval
    Thread.sleep(forTimeInterval: JIGGLE_INTERVAL)
    
    // Perform jiggle in autorelease pool for memory efficiency
    autoreleasepool {
        jiggleMouse()
    }
}