# Mathematical-Modeling-FCO (MATLAB)

A MATLAB project repository. This README explains how to install the required tools (MATLAB + VS Code), install the MATLAB extension for VS Code, and run the project by downloading the repository as a ZIP and executing `main.m`.

---

## Table of Contents

- [Mathematical-Modeling-FCO (MATLAB)](#mathematical-modeling-fco-matlab)
  - [Table of Contents](#table-of-contents)
  - [Optional - Prerequisites](#optional---prerequisites)
  - [Recommended - Download This Repository (ZIP)](#recommended---download-this-repository-zip)
  - [Recommended - Run the Project in MATLAB](#recommended---run-the-project-in-matlab)
    - [Method 1 — Set Folder and Run `main.m`](#method-1--set-folder-and-run-mainm)
    - [Method 2 — Add Project Folder to Path (if needed)](#method-2--add-project-folder-to-path-if-needed)
  - [Optional - Install MATLAB](#optional---install-matlab)
  - [Optional - Install Visual Studio Code (VS Code)](#optional---install-visual-studio-code-vs-code)
  - [Optional - Install the MATLAB Extension in VS Code](#optional---install-the-matlab-extension-in-vs-code)
    - [Choice A — Install from the Extensions panel](#choice-a--install-from-the-extensions-panel)
    - [Choice B — Install from the Marketplace page](#choice-b--install-from-the-marketplace-page)

---

## Optional - Prerequisites
- Installed MATLAB on your system
- Visual Studio Code (VS Code)
  - Installed MATLAB extension
---
---

## Recommended - Download This Repository (ZIP)

The code can be downloaded using GitHub's Download ZIP:

1. Find and click the green **`<> Code`** button.
2. Click **Download ZIP**.
3. Extract/unzip the downloaded file to a folder on your computer.

You should end up with a project folder containing files such as:
- `src/` (source folder)
- `src/resources/` (resources folder for data)
- `src/main.m` (main class (file))

---

## Recommended - Run the Project in MATLAB

### Method 1 — Set Folder and Run `main.m`
1. Open **MATLAB**
2. In MATLAB, click **Home → Open** (or use the Current Folder panel)
3. Navigate to the extracted repository folder
4. Ensure MATLAB’s **Current Folder** is set to the project root (the folder that contains `main.m`)
5. Run:
   - Click **Run** (green triangle) while `main.m` is open, or type in the Command Window:
     ```matlab
     main
     ```

### Method 2 — Add Project Folder to Path (if needed)
If MATLAB cannot find files inside subfolders (e.g., `src`), add the project directory:
```matlab
addpath(genpath(pwd))
main
```

---

## Optional - Install MATLAB

1. Go to the official MathWorks MATLAB page:
   - https://www.mathworks.com/products/matlab.html

2. Download MATLAB:
   - Sign in with your MathWorks account (or create one).
   - Choose the installer for your operating system.

3. Install MATLAB:
   - Run the installer.
   - Follow the on-screen instructions.
   - Sign in / activate using your license.
   - Finish installation.

4. Verify MATLAB works:
   - Launch MATLAB.
   - Confirm you can open the Command Window and run a basic command, e.g.:
     ```matlab
     disp("MATLAB is working.")
     ```

---

## Optional - Install Visual Studio Code (VS Code)

1. Download VS Code:
   - https://code.visualstudio.com/

2. Install VS Code:
   - Run the installer and follow the prompts.

3. Verify installation:
   - Open VS Code.
   - You should see the Welcome page.

---

## Optional - Install the MATLAB Extension in VS Code

There are two common ways to install extensions:

### Choice A — Install from the Extensions panel
1. Open **VS Code**
2. Go to **Extensions**:
   - Click the Extensions icon on the left sidebar, or press:
     - Windows/Linux: `Ctrl + Shift + X`
     - macOS: `Cmd + Shift + X`
3. Search for:
   - **MATLAB**
4. Install the MATLAB extension (published by MathWorks).

### Choice B — Install from the Marketplace page
1. Visit the VS Code Marketplace:
   - https://marketplace.visualstudio.com/vscode
2. Search for “MATLAB”
3. Click **Install** and follow prompts to open VS Code.

> After installing, you may need to reload VS Code for the extension to activate.


