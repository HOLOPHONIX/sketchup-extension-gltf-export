# Plan: Make HOLOPHONIX glTF Export signing-ready for Trimble Extension Warehouse

Context

The end goal is a fully functioning SketchUp extension that Trimble will digitally sign and approve for the public Extension Warehouse. The repo is a fork of Yulio's glTF exporter, rebranded
for HOLOPHONIX (spatial-audio room visualization).

Research established (sources: help.sketchup.com extension signing/best-practices, ruby.sketchup.com):

- Trimble signing is free and automatic on upload; for an MIT open-source extension we sign without encryption, so the existing require/Sketchup.require pattern is fine.
- Apple "notarization" does not apply to pure-Ruby RBZ extensions — "sign and notarize" here means Trimble's signature. (It would only matter if we shipped a native binary — which is exactly
  the GraphicsMagick dependency we're removing.)
- Signed/Warehouse extensions must not modify $LOAD_PATH, must avoid undisclosed external binaries, and must be a clean root.rb + matching folder RBZ.

Phase 1 (6 correctness bug fixes + install-script auto-detect) is already committed and pushed on branch fix/audit-correctness (commits f3da8f7, c485a6d).

Decisions locked with the user

1. Drop texture export entirely. HOLOPHONIX needs room geometry with flat material colors, not image-mapped textures. This simultaneously removes the GraphicsMagick dependency, the vendored
    mini_magick, and the $LOAD_PATH signing blocker.
2. Distribution: public Extension Warehouse (requires icon + polished metadata + passing review).
3. Scope: signing blockers + essential polish. Not the full dead-code sweep (leave exportWithMatrix, commented Microsoft scaffolding, @warning/@isWarning, broad RuboCop debt for a later pass).

Work items

A. Remove texture/image export (clears the $LOAD_PATH signing blocker + native dep)

Material base colors (RGBA) are independent of textures (gltf_materials.rb extracts material.color), so geometry stays colored — just not image-mapped.

- src/HOLOPHONIX_gltf_export/gltf_export.rb
  - Remove Sketchup.require of gltf_textures and gltf_images (lines 37, 39).
  - Remove @images = GltfImages.new(...) (82) and @textures = GltfTextures.new(@images) (85). Keep the empty-buffer init on line 83 (its comment confirms it exists for the no-textures case —
    preserves buffer-index consistency).
  - @materials = GltfMaterials.new(@textures) (89) → GltfMaterials.new.
  - Remove the export["images"] / export["textures"] / export["samplers"] assembly block (298–310).
  - Remove the images/textures lines from the summary (346–347).
- src/HOLOPHONIX_gltf_export/gltf_materials.rb
  - initialize(textures) → initialize (drop @textures).
  - Remove the if (material.texture != nil) ... @textures.add_texture(face) branch (273–276); always call add_material_node with nil texture.
  - Simplify add_material_node: drop the texture_id parameter and the now-dead baseColorTexture block (79–99) and texture-driven alphaMode block (167–170). Keep the alpha < 1.0 → BLEND path.
    Update the two internal callers (the default-material call ~219 and the two final add_material_node calls).
  - Apply the #1 fix context: add_material_by_material (still dead) — delete it as part of this simplification rather than carry an unused method.
- Delete files: gltf_images.rb, gltf_textures.rb, mini_gmagick.rb, mini_magick.rb, the entire mini_magick/ directory (~20 files), and Grey_Texture.jpg.
- Locale .strings (all 4): remove the now-unused unsupportedImage key (and the images/textures summary keys if the summary lines are dropped). Leave badUVW (unrelated, fixed in Phase 1).

B. Remove dead/unsafe debug code (signing hygiene — Trimble review flags these)

- gltf_export.rb: delete the disabled profiler block (~228–240) containing the hardcoded e:/Downloads/glTF_exporter_profile.txt Windows path, plus the related commented print_profile($stderr)
  (335) and #require 'profiler' (29).
- mesh_geometry_collect.rb:96: remove the active puts e.class (console output is ignored in signed mode and flagged in review). Confirm no other active puts/print remain in shipped code
  (Phase-1 scan showed this is the only live one).

C. Metadata / branding polish (Warehouse submission requirements)

- src/HOLOPHONIX_gltf_export.rb: introduce a single version constant (e.g. VERSION in HOLOPHONIX::GltfExporter) and reference it from ex.version; fix ex.copyright = '©2019' → '©2019–2026
  HOLOPHONIX S.A.S.'. Propose bumping the version to reflect the texture-removal change (recommend 3.0.0; confirm number at implementation).
- Reconcile the hardcoded generator string and changelog comments to the single version source where they appear (the audit noted version in 3+ places).
- README.md: fix the hardcoded "SketchUp 2023" install path (→ 2023–2026 / generic), update Compatibility (no GraphicsMagick; cross-platform now that the native dep is gone — confirm Windows
  is in scope), and note textures are not exported (geometry + material colors only).
- CONTRIBUTING.md: fix the wrong clone URL (sketchup-extension-vscode-project.git → correct repo).

D. Packaging for signing/submission

- Add scripts/build_rbz.sh: zip HOLOPHONIX_gltf_export.rb + HOLOPHONIX_gltf_export/ from src/, excluding .DS_Store, output HOLOPHONIX_gltf_export.rbz. (Mirrors the existing
  install_extension.sh resolution style.)
- Extension icon: the Warehouse listing requires an icon (PNG, ~128–200px). This is an art asset the user must supply — flagged as a submission to-do, not a code change.
- Add .DS_Store to .gitignore if not already covered, and ensure no .DS_Store lands in the RBZ.

Critical files

- Edit: src/HOLOPHONIX_gltf_export/gltf_export.rb, gltf_materials.rb, mesh_geometry_collect.rb, src/HOLOPHONIX_gltf_export.rb, the 4 Resources/\*/HOLOPHONIX_gltf_export.strings, README.md,
  CONTRIBUTING.md
- Delete: gltf_images.rb, gltf_textures.rb, mini_gmagick.rb, mini_magick.rb, mini_magick/\*\*, Grey_Texture.jpg
- Add: scripts/build_rbz.sh

Branching

Continue on fix/audit-correctness or branch fresh from it (e.g. feat/signing-readiness). Recommend a new branch so the texture-removal/signing work is a reviewable PR distinct from the Phase-1
bug fixes.

Verification

1. Syntax: ruby -c on every edited .rb.
2. Load test: confirm src/HOLOPHONIX_gltf_export.rb and gltf_export.rb have no dangling references to GltfImages/GltfTextures/@textures/@images (grep), and no remaining $LOAD_PATH (grep -rn
    '\$LOAD_PATH' src/).
3. Manual export in SketchUp 2026 (user, as before): install via scripts/install_extension.sh, export a model that has textured materials → verify it exports successfully and surfaces render
    with their base colors (no crash, no missing-texture error). Export a model with plain colored materials → unchanged.
4. RBZ build: run scripts/build_rbz.sh, confirm the archive contains exactly HOLOPHONIX_gltf_export.rb + the folder, no .DS_Store, no mini_magick.
5. Pre-submission check against Trimble criteria: no $LOAD_PATH/eval/global vars/active console output; valid root+folder structure; complete SketchupExtension metadata.

Out of scope (deferred)

Full dead-code sweep (exportWithMatrix/@use_matrix, commented Microsoft/Paint3D scaffolding, @warning vs @isWarning, duplicate require), broad RuboCop autocorrect, and a CI lint/smoke-test
job. Can be a follow-up PR after signing is achieved.

Status

Signing-readiness work (items A–D above) is merged to main (PR #1), and the Warehouse icon is in PR #2. VERSION is now 3.1.0, which fixes the export orientation (see below).

# HOLOPHONIX coordinate system and export orientation

HOLOPHONIX side (repo ../holophonix, three.js / react-three-fiber):
- The world is Z up: X = right, Y = front (azim 0°), Z = up (src/common/3DTools.ts; grids rotated into XY; groups use up=[0,0,1]).
- The venue model is loaded with useGLTF and no axis conversion (src/client/UI/Windows/Venue3D/Model3D/Model3D.tsx). The only adjustment is manifest.model3D.rotation (degrees, three.js Euler XYZ, default 0/0/0), set from the "Rot X/Y/Z" inspector sliders.

Exporter side (src/HOLOPHONIX_gltf_export/gltf_export.rb, export):
- SketchUp is also right-handed Z-up (red X = right, green Y = away from the Front-view camera, blue Z = up), so the SketchUp and HOLOPHONIX frames are identical. Since 3.1.0, get_default_matrix is a pure inches → metres scaling. The output is deliberately Z-up (non-standard for glTF, which is Y-up).
- The matrix is baked into vertex positions (mesh.transform!, @use_matrix = false), and the root node carries no matrix. A negative determinant would reverse the triangle winding, but pure scaling has a positive one.
- History: up to 3.0.x the root matrix was get_default_matrix (standard Z-up → Y-up rotation) * swap_matrix (Y/Z swap, determinant -1) * rotation_matrix (180° about X), a net mapping of (x, -y, z), i.e. mirrored. An interim 3.1.0 draft pre-multiplied a -90° X correction, giving (x, z, y), still mirrored. Verified with glb-tester-4 (3D-text labels FRONT/REAR/LEFT/RIGHT/TOP/STAGE): in HOLOPHONIX at Rot X 90 / Rot Y 180, every label read backwards and LEFT/RIGHT were swapped, which led to the pure-scaling fix. Re-exported with the pure scaling, the test model was confirmed correct in HOLOPHONIX at Rot 0/0/0 (labels readable, LEFT/RIGHT correct, stage at +Y).
- Cameras (gltf_cameras.rb) use their own hardcoded "Camera Group" matrix and were not updated. HOLOPHONIX ignores cameras in venue models.
