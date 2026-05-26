# Render Deployment

Use Render `Static Site` for this project.

Recommended setup:

1. Create a new `Static Site` in Render.
2. Point it at this repository.
3. Use these build settings:
   - Build Command: `npm ci && npm run build`
   - Publish Directory: `dist`
4. Deploy.

What the build does:

- copies the checked-in native OpenFL HTML5 export from `native-port/Export/html5/bin`
- wraps it in the site shell under `site/`
- outputs the final deployable site into `dist/`

Optional alternative:

- If you import from `render.yaml`, choose `Blueprint`.
- The blueprint should still publish the same `dist` directory.
