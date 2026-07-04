# Full Implementation Plan: Scatter Mobile Port

This document outlines the step-by-step strategy to complete the port of the Scatter web app into a robust Flutter application. The plan is broken down into distinct, logical phases to ensure continuous progress and a 1:1 parity with the original React web application.

## Phase 1: Workspace Wiring & Tile Rendering
**Goal:** Make the canvas alive by rendering tiles from state and hooking up the primary controls.

1. **Populate Initial State:** 
   - Port the `INITIAL_TILES` and `COLOR_PALETTE` constants from `scatter_web/src/App.tsx` into Dart.
   - Initialize `TilesState` (Riverpod) with these default tutorial/onboarding tiles.
2. **Render the Grid:**
   - Modify `ScatterBoardPage` to watch `tilesStateProvider`.
   - Render the list of `ChromaTileWidget`s inside the main canvas `Stack`.
3. **Wire Radial Menu Controls:**
   - Embed `RadialMenuWidget` into `ScatterBoardPage`.
   - Implement the `onAddTile` callback to calculate the center of the current viewport and spawn a new note.
   - Implement `onClearCanvas` to wipe the `TilesState`.
   - Implement `onResetCamera` to animate the viewport back to `(0,0, 1.0)`.

## Phase 2: Ink & Stylus Sketching Engine
**Goal:** Enable seamless stylus-driven sketching directly on the tiles.

1. **Stroke Capture Logic:**
   - Update `ChromaTileWidget`'s pointer event listeners (`_handlePointerDown`, `_handlePointerMove`, `_handlePointerUp`) to only capture `PointerDeviceKind.stylus` (and touch).
   - Track local stroke points efficiently to avoid full-app rebuilds while drawing.
2. **Stroke Rendering:**
   - Implement `_StrokesPainter` inside `chroma_tile_widget.dart` to draw smooth Bézier curves or standard poly-lines based on the captured points, matching the web app's visual style.
3. **State Persistance:**
   - On `PointerUp`, push the completed local `Stroke` into the `tiles_provider` so it persists on the tile.

## Phase 3: Magnetic Grouping & Clustering Physics
**Goal:** Bring the notes to life with the signature magnetic grouping feature.

1. **Proximity Detection:**
   - Inside `tiles_provider`, whenever a tile's position is updated (dragged), check the Euclidean distance to other tiles.
   - If a tile gets within the threshold (e.g., 50px), assign them a shared `clusterId`.
2. **Cluster Dragging:**
   - Modify the `updateTilePosition` logic: if the target tile has a `clusterId`, apply the exact same `(dx, dy)` translation to *all* other tiles sharing that `clusterId`.

## Phase 4: NLP Semantic Bridges & Sunken Thoughts
**Goal:** Port the intelligence and line-crossing physics of Scatter.

1. **Semantic Parsing:**
   - Port the TypeScript `nlp.ts` logic (`computeSemanticRelations`, `findMatchingNoteByKeyword`) into Dart (`lib/core/utils/nlp.dart`).
   - Determine which tiles share matching concepts in real-time as state changes.
2. **Bridge Rendering:**
   - Create a `CustomPaint` overlay at the bottom of the canvas stack (behind the tiles) to draw glowing, animated amber Bézier curves between semantically connected tiles.
3. **Strikethrough / Sinking Logic:**
   - Analyze completed strokes to detect horizontal lines crossing out text.
   - Update tile state with `struckLineIndices` and `isSunk`.
   - Visually update sunken tiles (lower opacity, push to background layer).

## Phase 5: Focused Writing Board (Macro Mode)
**Goal:** Allow users to dive deep into a note and edit its text content.

1. **Build `FocusedWritingBoard` Widget:**
   - Create a new full-screen modal/overlay widget that accepts a `ChromaTile`.
   - Include standard Flutter `TextField`s for editing the title and body text.
2. **Hero Transitions:**
   - Implement double-tap listeners on `ChromaTileWidget` to trigger the focus mode.
   - Use Flutter's `Hero` animations to smoothly transition the sticky note from the infinite canvas into the focused view.

## Phase 6: Polish (Familiar & Satellite FX)
**Goal:** Add the final delightful micro-interactions.

1. **Integrate the Familiar:**
   - Render `FamiliarWidget` floating near the radial menu.
   - Connect it to the "Orbit Mode" and theme toggles for visual feedback.
2. **Satellite Flight Particles:**
   - Hook up `SatelliteFlightRenderer` to trigger whenever a new tile is spawned or an action is performed, replicating the energetic particle effects from the web app.

## Verification Protocol
After every phase, the active agent must:
1. Run `flutter analyze` to ensure zero compilation or syntax warnings.
2. Commit the changes strictly isolated to the phase completed.
3. Keep this `PLAN.md` document updated by marking phases as done (e.g. `[x] Phase 1`).
