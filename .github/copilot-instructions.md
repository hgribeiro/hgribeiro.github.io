# Copilot Instructions: hugo-mods.github.io

This is a Hugo static site project showcasing community modules for Hugo. The site is built with Hugo Extended and deployed to GitHub Pages.

## Build and Development Commands

### Local Development
```bash
# Run development server with live reload
hugo server

# Run server with drafts visible
hugo server -D
```

### Production Build
```bash
# Build for production (used by CI/CD)
hugo --gc --minify

# Build with specific baseURL
hugo --gc --minify --baseURL "https://hugo-mods.github.io/"
```

### Dependency Management
```bash
# Update all Hugo modules
hugo mod get -u

# Update specific module
hugo mod get -u github.com/kdevo/osprey-delight

# Add new module (edit config.yaml first, then run)
hugo mod get

# Clean module cache
hugo mod clean

# View module dependency graph
hugo mod graph

# Download/sync modules
hugo mod vendor
```

### Validation
There are no dedicated tests. Validation is done by successful build:
```bash
hugo --gc --minify
```

## Project Architecture

### Hugo Module System
This project uses **Hugo Modules** (Go modules) for dependency management, not Git submodules:

- **Theme**: `github.com/kdevo/osprey-delight` - Main theme providing layout and styling
- **Feature Modules**:
  - `github.com/hugo-mods/icons` - SVG icon system
  - `github.com/hugo-mods/lazyimg` - Lazy-loading image optimization

All module imports are declared in `config.yaml` under `module.imports`, and actual dependencies are locked in `go.mod`/`go.sum`.

### Content Structure
- **Gallery items** (`content/gallery/*.md`) - Showcase individual Hugo modules
  - Each gallery item uses front matter with `github.repo`, `buttons`, and metadata
  - Gallery items appear on the homepage in the "Mods" section
- **Blog posts** (`content/blog/*.md`) - Documentation and guides
- **About page** (`content/about.md`) - Site introduction

### Customization Points
- **`layouts/partials/head-extended.html`** - Custom HTML injected into `<head>`
- **`layouts/shortcodes/lazyimg.html`** - Custom shortcode wrapper for lazy image loading
- **`assets/sass/_custom.scss`** - Custom Sass styling that extends the theme
- **`assets/sass/themes/`** - Theme-specific style overrides

### Image Handling
The project uses a sophisticated image pipeline configured in `config.yaml`:

- **lazyimg configuration** (`Params.lazyimg`):
  - Automatic resizing with responsive sizes (320x to 1920x)
  - LQIP (Low-Quality Image Placeholder) for progressive loading
  - WebP format generation for modern browsers
  - Configured with `resizer: auto` and `renderer: lqip-webp`

- **Image resources**: Place images in `assets/` or page bundles for auto-processing

## Key Conventions

### Module Updates
When updating modules, **always use `hugo mod get -u`** as shown in the site's tagline. This is the canonical way to update dependencies in this project.

### Gallery Item Front Matter
Gallery items follow a specific front matter structure:
```yaml
---
title: "Module Name"
subtitle: "Short description"
image: "gallery/image.png"  # Relative to assets/
github:
  repo: "hugo-mods/module-name"
  showInfo: true
  showButtons: false
buttons:
  - i18n: learn
    icon: learn
    url: './blog/module-name/'
  - i18n: get
    icon: get
    url: "https://github.com/hugo-mods/module-name"
---
```

### Shortcode Usage
The `lazyimg` shortcode supports both positional and named parameters:
```markdown
{{</* lazyimg "path/to/image.jpg" */>}}
{{</* lazyimg img="path/to/image.jpg" alt="Description" */>}}
```

### CSS Customization
- Add custom styles to `assets/sass/_custom.scss`
- Theme-specific overrides go in `assets/sass/themes/`
- The project uses `pygmentsUseClasses: true` for CSS-based syntax highlighting

## CI/CD

**Hugo Version**: The project is pinned to Hugo Extended **0.123.0** in `.github/workflows/gh-pages.yml`.

**Deployment**: Automated via GitHub Actions on pushes to `main`:
1. Build job: Installs Hugo Extended + Dart Sass, builds with `hugo --gc --minify`
2. Deploy job: Publishes to GitHub Pages

**Environment Variables**:
- `HUGO_ENVIRONMENT=production`
- `HUGO_ENV=production`

When modifying the build process, ensure changes work with Hugo Extended 0.123.0.

## Configuration

Main configuration is in `config.yaml` (not TOML). Key settings:

- **Theme parameters** under `Params` - Controls appearance and features
- **Module imports** under `module.imports` - Declares Hugo module dependencies
- **Menu items** under `Menu.Main` - Auto-generates navbar
- **Feature flags** under `Params.Feat` - Toggle theme features (Termynal, structured data, etc.)

The site is designed as a single-page application with sections (`#about`, `#mods`, `#blog`, `#join`).
