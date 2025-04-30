# SketchUp Extension glTF Export for HOLOPHONIX

Version: 1.0.0
Tested with: HOLOPHONIX 2.3.0, SketchUp 2023 (macOS 14.7.5)
License: MIT License

## Overview

The HOLOPHONIX glTF Exporter is a refactored version of the original Yulio Technologies exporter. It has been adapted and maintained by the HOLOPHONIX Development Team as a practical, free tool for spatial audio workflows involving HOLOPHONIX.

This tool is designed for internal and non-commercial use and is not intended for commercial redistribution or resale.

## Features

    Export SketchUp models to glTF 2.0 (.glb) format.
    Optimized for use with HOLOPHONIX spatial audio systems.
    Lightweight and easy to integrate into existing workflows.

## Quick Start

### Installation

    Locate the SketchUp Plugins Directory:
    text

    ~/Library/Application Support/SketchUp 2023/SketchUp/Plugins

    Copy the Extension Files:
        Copy the HOLOPHONIX_gltf_export folder and HOLOPHONIX_gltf_export.rb file into the Plugins directory.

    Restart SketchUp.

## Usage

    In SketchUp, navigate to:
    text

Extensions → HOLOPHONIX_gltf_export

Select:
text

    Export Binary glTF 2.0 (.glb)

    Choose a destination folder for the .glb file.

    A summary will appear once the export is complete.

## Compatibility

    Operating Systems: macOS
    SketchUp Versions: 2023
    HOLOPHONIX Versions: 2.2.2 and later

## Support

This tool is provided as-is, with no warranty or formal support. For questions related to integration with HOLOPHONIX systems, visit [our website](www.holophonix.xyz).

## Troubleshooting

### Extension Not Appearing in SketchUp

    Ensure the HOLOPHONIX_gltf_export folder and HOLOPHONIX_gltf_export.rb file are correctly placed in the SketchUp Plugins directory.
    Restart SketchUp after installation.
    Check the Ruby Console (Window → Ruby Console) for any error messages.

### Export Fails

    Verify that the model is properly structured and contains no errors.
    Ensure you have sufficient permissions to write to the destination folder.

### Debugging

Add the following to HOLOPHONIX_gltf_export.rb to debug the extension:
ruby

puts "Loading HOLOPHONIX glTF Exporter..."

Check the Ruby Console for this message to confirm the extension is being loaded.

## Changelog

[1.0.0] - 2025-04-29

    Initial release of the HOLOPHONIX glTF Exporter for SketchUp.

## Acknowledgments

    Yulio Technologies Inc. for the original SketchUp glTF Exporter.
    HOLOPHONIX Development Team for refactoring and maintaining the tool.
