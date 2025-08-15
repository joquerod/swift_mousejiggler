# Mouse Jiggler for macOS

A lightweight Swift command-line utility that prevents your Mac from going to sleep by periodically moving the mouse cursor imperceptibly.

## Features

- 🖱️ Moves mouse cursor by 1 pixel every 30 seconds (imperceptible to the user)
- 🚀 Lightweight and efficient - written in Swift with minimal resource usage
- 📊 Real-time activity logging with timestamps and runtime statistics
- 🛑 Graceful shutdown with Ctrl+C
- 🎯 No dependencies or installation required
- 🔧 Configurable jiggle interval and distance (modify constants in source)

## Requirements

- macOS 10.10 or later
- Swift runtime (included with macOS)

## Installation

### Quick Start

1. Clone this repository:
```bash
git clone https://github.com/YOUR_USERNAME/mouse-jiggler-macos.git
cd mouse-jiggler-macos
```

2. Make the script executable:
```bash
chmod +x mouse-jiggler.swift
```

3. Run the jiggler:
```bash
./mouse-jiggler.swift
```

### Alternative: Direct Download

Download the `mouse-jiggler.swift` file directly and run:
```bash
curl -O https://raw.githubusercontent.com/YOUR_USERNAME/mouse-jiggler-macos/main/mouse-jiggler.swift
chmod +x mouse-jiggler.swift
./mouse-jiggler.swift
```

## Usage

Simply run the script from Terminal:
```bash
./mouse-jiggler.swift
```

You'll see output like:
```
Mouse Jiggler v1.0.0
====================
Preventing system sleep by moving mouse every 30 seconds
Press Ctrl+C to stop

Starting... (performing initial jiggle)
[14:23:15] Jiggle #1 | Runtime: 0s

[14:23:45] Jiggle #2 | Runtime: 30s
[14:24:15] Jiggle #3 | Runtime: 1m 0s
```

To stop the jiggler, press `Ctrl+C`.

## How It Works

The script uses macOS's Core Graphics framework to:
1. Get the current mouse position
2. Move the cursor 1 pixel to the right
3. Immediately move it back to the original position

This movement is so small and quick that it's imperceptible to the user but sufficient to prevent the system from detecting inactivity.

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

### Permission Issues

If you encounter permission errors, ensure the Terminal app has accessibility permissions:
1. Open System Preferences → Security & Privacy → Privacy tab
2. Select "Accessibility" from the left panel
3. Add Terminal.app to the list (may require admin password)

### Script Not Running

Make sure the script is executable:
```bash
chmod +x mouse-jiggler.swift
```

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