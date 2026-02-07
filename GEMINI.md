# Gemini Project Context: hugo-mods.github.io

This document provides context for the Gemini AI agent to understand and assist with the development of this project.

## Project Overview

This is a **code project** for a static website built with the **Hugo** static site generator.

*   **Purpose**: The repository contains the source code for the "Hugo Community Modules" website, available at [https://hugo-mods.github.io](https://hugo-mods.github.io). It serves as a showcase for various Hugo modules, such as `icons` and `lazyimg`.
*   **Technologies**:
    *   **Hugo**: The core static site generator. The main configuration is in `config.yaml`.
    *   **Go Modules**: Used to manage Hugo dependencies, including the theme (`osprey-delight`) and other feature modules. Dependencies are defined in `go.mod`.
    *   **Sass/SCSS**: The project uses Sass for styling, as evidenced by the `assets/sass/` directory and the installation of Dart Sass in the build workflow.
    *   **GitHub Actions**: A CI/CD pipeline defined in `.github/workflows/gh-pages.yml` automates the building and deployment of the site to GitHub Pages, using Hugo version `0.123.0`.

*   **Architecture**: The project follows a standard Hugo directory structure. It imports a main theme and several other modules to provide features, demonstrating a modular architecture.

## Building and Running

### Local Development

To run the website on a local server with live reloading, use the standard Hugo command:

```bash
hugo server
```

### Production Build

To generate the production-ready static files in the `public/` directory, use the following command. The build process from the GitHub Actions workflow uses:

```bash
hugo --gc --minify
```

### Testing

There are no dedicated test scripts. The primary validation is a successful `hugo` build.

## Development Conventions

*   **Dependency Management**: Hugo module dependencies are managed with Go Modules. To update existing modules, use the command referenced in the site's own tagline:
    ```bash
    hugo mod get -u
    ```
    To add a new module, edit the `[module.imports]` section of `config.yaml` and run `hugo mod get`.

*   **CI/CD**: All builds and deployments are automated via GitHub Actions using the `.github/workflows/gh-pages.yml` workflow. This workflow uses official GitHub Actions (e.g., `actions/configure-pages`, `actions/upload-pages-artifact`, `actions/deploy-pages`), separating the process into `build` and `deploy` jobs. It explicitly installs Hugo CLI version `0.123.0` and Dart Sass.

*   **Code Style**: No explicit style guide is present, but the codebase follows standard Hugo conventions. The use of `pygmentsUseClasses: true` suggests a preference for CSS-based syntax highlighting.
