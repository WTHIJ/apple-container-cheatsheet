# Apple Containers CLI Cheatsheet

*A printable A4 landscape 4-column quick reference guide for Apple's `container` CLI tool on macOS.*

---

<div align="center">

![Stars](https://img.shields.io/github/stars/WTHIJ/apple-container-cheatsheet?style=for-the-badge&logo=github)
![Issues](https://img.shields.io/github/issues/WTHIJ/apple-container-cheatsheet?style=for-the-badge&logo=github)
![Forks](https://img.shields.io/github/forks/WTHIJ/apple-container-cheatsheet?style=for-the-badge&logo=github)
![Repo Size](https://img.shields.io/github/repo-size/WTHIJ/apple-container-cheatsheet?style=for-the-badge&logo=github)
![Contributors](https://img.shields.io/github/contributors/WTHIJ/apple-container-cheatsheet?style=for-the-badge&logo=github)
![Watchers](https://img.shields.io/github/watchers/WTHIJ/apple-container-cheatsheet?style=for-the-badge&logo=github)
![License](https://img.shields.io/github/license/WTHIJ/apple-container-cheatsheet?style=for-the-badge)
![Made with Typst](https://img.shields.io/badge/Made%20with-Typst-blue?style=for-the-badge&logo=typst)

</div>

---

## Table of Contents

- [Apple Containers CLI Cheatsheet](#apple-containers-cli-cheatsheet)
  - [Table of Contents](#table-of-contents)
  - [Description](#description)
  - [📂 Project Structure](#-project-structure)
  - [Features](#features)
  - [Requirements](#requirements)
  - [Installation \& Usage](#installation--usage)
    - [Option 1 — Compile locally (recommended)](#option-1--compile-locally-recommended)
    - [Option 2 — Compile via the web editor](#option-2--compile-via-the-web-editor)
  - [🤝 Contributing](#-contributing)
    - [Guidelines](#guidelines)
    - [Pull request checklist](#pull-request-checklist)
  - [License](#license)
  - [Acknowledgments](#acknowledgments)
  - [📬 Contact \& Support](#-contact--support)


## Description

This project provides a **single-page, print-ready A4 landscape cheatsheet** for Apple's official [`container`](https://github.com/apple/container) CLI tool on macOS.

Each section maps directly to real `container` subcommands — from system management and image building to networking, machine control, and advanced run flags. It is designed to be pinned to a terminal corner, printed as a wall poster, or kept on a second monitor.

> ⚠️ **Prerequisite:** This cheatsheet describes commands available in **Apple Containers**. Commands will only work on a macOS system with Apple Containers installed. For installation instructions, visit the [official Apple Container repository](https://github.com/apple/container).

---

## 📂 Project Structure

```
apple-container-cheatsheet/
├── cheatsheet.typ       # Typst source file (single-page, 4-col layout)
├── cheatsheet.pdf       # Rendered PDF output (A4 landscape)
├── README.md            # This file
└── LICENSE              # MIT License
```

---

## Features

| Category | Description |
|---|---|
| **System Management** | `container system start` / `stop` / `logs` |
| **Image Management** | Build, pull, push, list, inspect, delete, prune |
| **Container Lifecycle** | Run, create, start, stop, restart, pause, unpause |
| **Inspect & Execute** | `container inspect`, `exec` interactive and detached |
| **Volumes** | Create, list, inspect, delete, mount, anonymous volumes |
| **Builder** | Build images from source directories and Dockerfiles |
| **Cleanup** | Delete, prune stopped containers and stopped machines |
| **Networking** | Create, list, delete custom/internal/subnet networks (macOS 26+) |
| **Machine Management** | Create, list, delete, boot, shell into VM sandboxes |
| **Kernel & Properties** | Set/get DNS, kernel properties; attach/detach networks |
| **Advanced Run Flags** | Resource limits, environment, init process, log drivers, GPU passthrough |

---

## Requirements

| Requirement | Details |
|---|---|
| **Typst** | Required to compile the source `.typ` file into PDF. Install from [typst.app](https://typst.app) or via your package manager. |
| **macOS + Apple Containers** | Required to actually run the documented commands. See [apple/container](https://github.com/apple/container) for installation. |
| **PDF Viewer** | Any viewer capable of rendering A4 landscape PDFs (preview on macOS, Okular on Linux, etc.). |

---

## Installation & Usage

### Option 1 — Compile locally (recommended)

```bash
# 1. Clone the repository
git clone https://github.com/WTHIJ/apple-container-cheatsheet.git
cd apple-container-cheatsheet

# 2. Compile the Typst source to PDF (already included in the repo)
typst compile cheatsheet.typ apple-container-cheatsheet.pdf

# 3. Open the PDF
open apple-container-cheatsheet.pdf
```

### Option 2 — Compile via the web editor

1. Open [typst.app](https://typst.app) in your browser.
2. Upload `cheatsheet.typ` to the editor.
3. Click **Download PDF** to get your rendered cheatsheet.

---

## 🤝 Contributing

Contributions are welcome! This is an open-source community project. Please read the contributing guidelines before submitting a pull request.

### Guidelines

- **Keep the single-page layout intact** - do not break the cheatsheet into multiple pages.
- **Follow the existing helper functions** - the Typst file uses `#section()`, `#subsection()`, `#code()`, and `#note()` helpers. New content must use the same pattern to maintain visual consistency.
- **One logical block per subsection** - aim for 3 to 6 command lines per subsection.
- **Cross-reference the official docs** - all commands must be verified against [apple/container](https://github.com/apple/container) before submission.
- **Test the output** - always run `typst compile cheatsheet.typ` and visually verify the PDF before opening a PR.

### Pull request checklist

- [ ] All new commands are tested and verified against the official Apple Containers CLI.
- [ ] The PDF compiles without errors (`typst compile cheatsheet.typ` exits with code 0).
- [ ] New sections use the existing Typst helper functions.
- [ ] The cheatsheet fits within one A4 landscape page.
- [ ] This README is updated if the project structure changes.

---

## License

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.

---

## Acknowledgments

This cheatsheet is inspired by and adapted from the official **Apple Container** project:

- 🔗 [github.com/apple/container](https://github.com/apple/container)
- 🔗 [Apple Containers Documentation](https://github.com/apple/container#readme)

---

## 📬 Contact & Support

- **Bug reports & feature requests:** Open an issue on [GitHub Issues](https://github.com/OWNER/apple-container-cheatsheet/issues)
- **Discussions:** Use the [GitHub Discussions](https://github.com/OWNER/apple-container-cheatsheet/discussions) tab
- **PRs:** All contributions welcome - see the contributing section above for guidelines.

---

<div align="center">

*Made with Typst · Designed for the Apple Containers community*

</div>
