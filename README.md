# Mouse Jiggler for macOS

A lightweight Swift command-line utility that prevents your Mac from going to sleep using proper system APIs (IOKit power assertions or caffeinate) combined with periodic mouse cursor movements for visual feedback.

> **Note:** Mouse movement alone does NOT prevent sleep on modern macOS. This tool uses proper power management APIs to actually keep your Mac awake.

## Features

- 💤 **Actually prevents sleep** using IOKit power assertions or caffeinate
- 🖱️ Moves mouse cursor by 1 pixel every 30 seconds (visual feedback)
- 🚀 Two implementations: IOKit (cleaner) and caffeinate (more reliable)
- 📊 Real-time activity logging with timestamps and runtime statistics
- 🛑 Graceful shutdown with Ctrl+C (properly releases power assertions)
- 🎯 No dependencies or installation required
- 🔧 Configurable jiggle interval and distance (modify constants in source)

## Requirements

- macOS 10.10 or later
- Swift runtime (included with macOS)

## Installation

### Quick Start

1. Clone this repository:
```bash
git clone https://github.com/joquerod/swift_mousejiggler.git
cd swift_mousejiggler
```

2. Make the scripts executable:
```bash
chmod +x mouse-jiggler.swift
chmod +x mouse-jiggler-caffeinate.swift
```

3. Run the jiggler (choose one):
```bash
# Main version (using IOKit power assertions)
./mouse-jiggler.swift

# Alternative version (using caffeinate)
./mouse-jiggler-caffeinate.swift
```

### Alternative: Direct Download

Download the `mouse-jiggler.swift` file directly and run:
```bash
curl -O https://raw.githubusercontent.com/joquerod/swift_mousejiggler/main/mouse-jiggler.swift
chmod +x mouse-jiggler.swift
./mouse-jiggler.swift
```

## Usage

Choose between two versions:

### Option 1: IOKit Version (Recommended)
```bash
./mouse-jiggler.swift
```
Uses IOKit power assertions for clean, integrated sleep prevention.

### Option 2: Caffeinate Version
```bash
./mouse-jiggler-caffeinate.swift
```
Uses macOS's built-in caffeinate command (more reliable on some systems).

You'll see output like:
```
Mouse Jiggler v1.0.0
====================
Preventing system sleep by:
  • Moving mouse every 30 seconds
  • Asserting display wake lock
Press Ctrl+C to stop

Starting... (performing initial jiggle)
[14:23:15] Jiggle #1 | Runtime: 0s

[14:23:45] Jiggle #2 | Runtime: 30s
[14:24:15] Jiggle #3 | Runtime: 1m 0s
```

To stop the jiggler, press `Ctrl+C`.

## How It Works

The script prevents sleep using two methods:

### 1. Power Management (Primary)
- **IOKit Version**: Creates a `kIOPMAssertionTypeNoDisplaySleep` assertion
- **Caffeinate Version**: Runs caffeinate subprocess with `-disu` flags

### 2. Mouse Movement (Visual Feedback)
Uses Core Graphics to periodically move the mouse:
1. Get the current mouse position
2. Move the cursor 1 pixel to the right
3. Immediately move it back to the original position

> **Important:** The mouse movement alone does NOT prevent sleep on modern macOS - it's just visual confirmation the script is running. The actual sleep prevention comes from the power assertions.

## Customization

You can modify the behavior by editing these constants at the top of the script:

```swift
let JIGGLE_INTERVAL: TimeInterval = 30.0  // Seconds between jiggles
let JIGGLE_DISTANCE: CGFloat = 1.0        // Pixels to move
```

## Security & Privacy

- **No network access**: The script runs entirely locally
- **No data collection**: No information is stored or transmitted
- **Open source**: Full source code available for inspection
- **Minimal permissions**: Only requires standard user permissions

## Use Cases

- Preventing sleep during long downloads or uploads
- Keeping your Mac awake during presentations
- Maintaining active status in communication apps
- Preventing screen lock during monitoring tasks
- Keeping SSH connections alive

## Troubleshooting

### Mac Still Sleeping?

1. **Verify power assertions are active**:
   ```bash
   # In another terminal, run:
   pmset -g assertions | grep "Mouse Jiggler"
   ```
   You should see the assertion listed.

2. **Try the caffeinate version** if IOKit version isn't working:
   ```bash
   ./mouse-jiggler-caffeinate.swift
   ```

3. **Check Activity Monitor** to ensure the process is running.

### Permission Issues

If you encounter permission errors, ensure the Terminal app has accessibility permissions:
1. Open System Preferences → Security & Privacy → Privacy tab
2. Select "Accessibility" from the left panel
3. Add Terminal.app to the list (may require admin password)

### Script Not Running

Make sure the script is executable:
```bash
chmod +x mouse-jiggler.swift
chmod +x mouse-jiggler-caffeinate.swift
```

### Choosing Between Versions

- **IOKit version**: Cleaner, no extra processes, but may require additional permissions
- **Caffeinate version**: More reliable, uses Apple's official tool, shows as separate process

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Author

Created by Jorge Quezada

## License

MIT License

Copyright (c) 2024 Jorge Quezada

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.