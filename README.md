# GLB Export for HOLOPHONIX (SketchUp extension)

A lightweight SketchUp extension that exports models to glTF 2.0 (`.glb` / `.gltf`) for use with HOLOPHONIX spatial audio systems.

**Version 3.1.0** — pure Ruby, no external dependencies, ready for Trimble extension signing.

## Overview

GLB Export for HOLOPHONIX bridges SketchUp's 3D modeling capabilities and HOLOPHONIX spatial audio systems. Originally developed by Yulio Technologies, this version has been refactored for HOLOPHONIX workflows, letting sound designers and audio engineers visualize spatial audio arrangements in a 3D room model.

## Features

- Export SketchUp models to binary glTF 2.0 (`.glb`) or embedded glTF 2.0 (`.gltf`)
- Preserves geometry, scene hierarchy, and cameras
- Preserves material colors: base color, metallic/roughness, emissive, transparency, double-sided
- Skips hidden entities and entities on hidden layers
- No external dependencies — pure Ruby, no native binaries
- Lightweight, with minimal impact on SketchUp performance

> **Note:** Image-mapped textures are not exported. Surfaces are exported with their material base colors, which is what HOLOPHONIX spatial-audio visualization needs. Removing texture export also removed the GraphicsMagick/ImageMagick dependency, which is what makes the extension distributable and signable.

## Quick Start

### Installation (recommended: RBZ)

1. Build the package:

    ```bash
    ./scripts/build_rbz.sh
    ```

    This produces `dist/HOLOPHONIX_gltf_export.rbz`.

1. In SketchUp: `Window → Extension Manager → Install Extension…`, select the `.rbz`, and confirm.

1. Restart SketchUp.

### Installation (manual / development)

Copy the `HOLOPHONIX_gltf_export` folder and the `HOLOPHONIX_gltf_export.rb` file from `src/` into your SketchUp Plugins directory, e.g.:

```bash
~/Library/Application Support/SketchUp 2026/SketchUp/Plugins
```

On macOS, `./scripts/install_extension.sh` does this for you and auto-detects the newest installed SketchUp version. You can also pass the Plugins directory explicitly:

```bash
./scripts/install_extension.sh "$HOME/Library/Application Support/SketchUp 2025/SketchUp/Plugins"
```

Restart SketchUp after installing.

## Usage

1. In SketchUp, open `Extensions → GLB Export for HOLOPHONIX`.

1. Choose an export format:
   - `Export Binary glTF 2.0 (.glb)` — single self-contained binary file (recommended for HOLOPHONIX)
   - `Export Embedded glTF 2.0 (.gltf)` — JSON with embedded buffers

1. Choose a destination file. The dialog defaults to the model's own folder and name.

1. A summary dialog reports the exported counts (materials, nodes, meshes, cameras, triangles, vertices) and the output path.

### Orientation in HOLOPHONIX

Starting with 3.1.0, the export keeps SketchUp's axes, which are the same as HOLOPHONIX's: X = right, Y = front, Z = up. Lengths are only converted from inches to metres. Import the model with **Model 3D → Rot X / Rot Y / Rot Z = 0°**.

Model the venue so that the audience faces **+Y** (the green axis), i.e. the stage is on the +Y side, as seen from SketchUp's Front view.

> **Upgrading from 3.0.x or earlier:** older exports were mirrored and needed manual rotations in HOLOPHONIX. Re-export with 3.1.0 and reset the project's Rot X / Y / Z to `0°`.
>
> **Note:** because the output is Z-up, generic glTF viewers (which assume Y-up) show the model lying on its back. This is expected; the file is intended for HOLOPHONIX.

## Compatibility

| Component | Supported |
|-----------|-----------|
| SketchUp | 2023 – 2026 |
| Operating System | macOS, Windows *(the extension is pure Ruby and platform-independent; the `scripts/` helpers are bash and target macOS)* |
| HOLOPHONIX | 2.2.2 and later |

## Troubleshooting

### Extension not appearing in SketchUp

- Verify that both the `HOLOPHONIX_gltf_export` folder and `HOLOPHONIX_gltf_export.rb` file are in the Plugins directory
- Check `Window → Extension Manager` — the extension should be listed and enabled
- Restart SketchUp completely after installing
- Check the Ruby Console (`Window → Ruby Console`) for load errors

### Export fails or reports errors

- The export summary lists any entities that could not be exported; the most common cause is perspective-mapped (UVW) texture coordinates, which are not supported
- Ensure your model is properly structured with no geometry errors
- Verify you have write permissions for the destination folder
- Simplify very large models if the export is slow

## Development

- Source lives under `src/`: `HOLOPHONIX_gltf_export.rb` (the loader, which holds the single `VERSION` constant) and `HOLOPHONIX_gltf_export/` (the implementation).
- Style: `bundle exec rubocop` (see `.rubocop.yml`).
- Syntax check: `ruby -c src/**/*.rb`.
- Package: `./scripts/build_rbz.sh`.

Contributions are welcome — see [CONTRIBUTING.md](CONTRIBUTING.md).

## Support

This tool is provided as-is, with no warranty or formal support. For questions related to integration with HOLOPHONIX spatial audio systems, please visit [our website](https://www.holophonix.xyz).

## Acknowledgments

- [Yulio Technologies Inc.](https://github.com/YulioTech/SketchUp-glTF-Exporter-Ruby) for the original SketchUp glTF Exporter
- HOLOPHONIX Development Team for refactoring and maintaining the tool

## License

MIT License. See [LICENSE](LICENSE) for details.
