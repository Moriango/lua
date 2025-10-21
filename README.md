# Neovim Configuration for NvChad

This repository contains my personal configuration for NvChad, a Neovim framework for building custom configurations.

## Features

- **Custom Keybindings:** 
  - Personalized key mappings for improved workflow and efficiency.
  - Easy navigation between files and buffers.
  - Custom shortcuts for common actions like saving, quitting, and searching.

- **Plugins:**
  - A curated list of plugins to enhance functionality and productivity.
  - Plugin management using NvChad's built-in plugin manager.
  - Includes popular plugins like Telescope for fuzzy finding, Nvim-Tree for file exploration, and more.

- **Themes:**
  - Custom themes for a better visual experience.
  - Support for multiple color schemes to suit different preferences.
  - Easy switching between themes.

- **LSP Configuration:**
  - Language Server Protocol settings for various programming languages.
  - Auto-completion, go-to-definition, and other IDE-like features.
  - Pre-configured LSP servers for languages like Python, JavaScript, Go, and more.

- **Treesitter:**
  - Advanced syntax highlighting and code navigation.
  - Better code folding and text objects.
  - Improved performance and accuracy for large codebases.

- **Status Line:**
  - Customized status line with useful information like file type, encoding, and cursor position.
  - Integration with Git to show branch and changes status.

- **Git Integration:**
  - Git signs and diffs in the gutter.
  - Easy access to Git commands and workflows within Neovim.

- **File Explorer:**
  - Integrated file explorer for easy navigation and file management.
  - Tree view with icons and git status indicators.

- **Terminal Integration:**
  - Built-in terminal emulator for running shell commands within Neovim.
  - Split and toggle terminal windows easily.

### Enabled Plugins

#### Core Plugins
- **conform.nvim** - Code formatting with multiple formatters
- **nvim-lspconfig** - Language Server Protocol configuration
- **nvim-tree.lua** - File explorer with tree view
- **telescope.nvim** - Fuzzy finder with vertical layout

#### Git Integration
- **fugitive.lua** - Git commands and workflow integration
- **gitsigns** - Git signs and diff indicators in gutter
- **gitblame.lua** - Git blame annotations
- **diffview.lua** - Enhanced diff viewing
- **lazygit.lua** - LazyGit integration

#### AI & Completion
- **copilot-cmp** - GitHub Copilot completion integration
- **copilot-chat** - GitHub Copilot chat functionality

#### Navigation & Search
- **cd-project.lua** - Project directory changing
- **goto-preview.lua** - Preview definitions and references
- **tmux-navigator.lua** - Seamless tmux navigation

#### UI & Visual Enhancements
- **render-markdown.lua** - Enhanced markdown rendering
- **vim-illuminate.lua** - Highlight word under cursor
- **zen-mode.lua** - Distraction-free writing mode
- **screenkey.lua** - Display pressed keys on screen
- **ufo.lua** - Enhanced folding capabilities

#### Development Tools
- **comment.lua** - Smart commenting
- **hover.lua** - Enhanced hover information
- **live-server.lua** - Live server for web development
- **mason_tool_installer.lua** - Automatic tool installation
- **md-preview.lua** - Markdown preview functionality
- **todo.lua** - TODO comments highlighting
- **undotree.lua** - Undo history visualization

#### Custom Configurations
- **nvim-tree** (custom config) - Enhanced file tree settings
