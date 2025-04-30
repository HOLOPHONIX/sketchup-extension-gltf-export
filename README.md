# SketchUp Extension glTF Export for HOLOPHONIX

A lightweight extension for exporting SketchUp models to HOLOPHONIX spatial audio systems in glTF 2.0 (.glb) format.

## Overview

The HOLOPHONIX glTF Exporter enables seamless integration between SketchUp's 3D modeling capabilities and HOLOPHONIX spatial audio systems. Originally developed by Yulio Technologies, this refactored version has been optimized specifically for HOLOPHONIX workflows, allowing sound designers and audio engineers to visualize spatial audio arrangements in 3D environments.

## Features

1. Export SketchUp models directly to glTF 2.0 (.glb) format
1. Optimized for HOLOPHONIX spatial audio system compatibility
1. Preserve material properties and textures during export
1. Lightweight implementation with minimal impact on SketchUp performance

## Quick Start

### Installation

1. Locate the SketchUp Plugins Directory, usually found at:

    ```bash
    ~/Library/Application Support/SketchUp 2023/SketchUp/Plugins
    ```

1. Copy the HOLOPHONIX_gltf_export folder and HOLOPHONIX_gltf_export.rb file into the Plugins directory.

1. Restart SketchUp.

## Usage

1. In SketchUp, navigate to: `Extensions → HOLOPHONIX gLTF Export`

1. Select: `Export Binary glTF 2.0 (.glb)`

1. Choose a destination folder for the .glb file.

1. A summary will appear once the export is complete.

## Compatibility

| Component | Supported Versions |
|-----------|-------------------|
| Operating System | macOS |
| SketchUp | 2023 to 2025 |
| HOLOPHONIX | 2.2.2 and later |

## Troubleshooting

### Extension Not Appearing in SketchUp

- Verify that both the `HOLOPHONIX_gltf_export` folder and `HOLOPHONIX_gltf_export.rb` file are in the correct Plugins directory
- Restart SketchUp completely after installation
- Check the Ruby Console (Window → Ruby Console) for any error messages

### Export Fails

- Ensure your model is properly structured with no geometry errors
- Verify you have write permissions for the destination folder
- Simplify complex models if necessary

### Debugging

Add the following to `HOLOPHONIX_gltf_export.rb` to enable debug output:

```ruby
puts "Loading HOLOPHONIX glTF Exporter..."
```

Then check the Ruby Console for confirmation messages.

## Support

This tool is provided as-is, with no warranty or formal support. For questions related to integration with HOLOPHONIX spatial audio systems, please visit [our website](https://www.holophonix.xyz).

## Acknowledgments

- [Yulio Technologies Inc.](https://github.com/YulioTech/SketchUp-glTF-Exporter-Ruby) for the original SketchUp glTF Exporter
- HOLOPHONIX Development Team for refactoring and maintaining the tool

## License

This extension is available under the MIT License. See the LICENSE file for details.
