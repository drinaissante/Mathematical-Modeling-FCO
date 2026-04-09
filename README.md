# Mathematical-Modeling-FCO (MATLAB)

This group project was collaborated among BS Mathematics with Specialization in Computer Science (BSM CS 3B). 
The project was made by installing VS Code (and the MATLAB extension from MathWorks) and MATLAB.
However, you may follow the [recommended](#recommended---download-this-repository-zip) steps for hassle-free testing.

---

## Table of Contents

- [Mathematical-Modeling-FCO (MATLAB)](#mathematical-modeling-fco-matlab)
  - [Table of Contents](#table-of-contents)
  - [Recommended - Download This Repository (ZIP)](#recommended---download-this-repository-zip)
  - [Recommended - Run the Project in MATLAB](#recommended---run-the-project-in-matlab)
    - [Method 1 — Set Folder and Run `main.m`](#method-1--set-folder-and-run-mainm)
    - [Method 2 — Add Project Folder to Path (if needed)](#method-2--add-project-folder-to-path-if-needed)
  - [Optional - Prerequisites](#optional---prerequisites)
  - [Optional - Install MATLAB](#optional---install-matlab)
  - [Optional - Install Visual Studio Code (VS Code)](#optional---install-visual-studio-code-vs-code)

---

## Recommended - Download This Repository (ZIP)

The code can be downloaded using GitHub's Download ZIP:

1. Find and click the green **`<> Code`** button.
2. Click **Download ZIP**.
3. Extract/unzip the downloaded file to a folder on your computer.

You should end up with a project folder containing files such as:
- `src/resources/` (resources folder for data)
- `src/main.m` (main file)

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

## Optional - Prerequisites
- Installed MATLAB on your system
- Visual Studio Code (VS Code)
  - Installed MATLAB extension

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

---

## Optional - Install Visual Studio Code (VS Code)

1. Download VS Code:
   - https://code.visualstudio.com/

2. Install VS Code:
   - Run the installer and follow the prompts.

3. Verify installation:
   - Open VS Code.
   - You should see the Welcome page.

4. Go to **Extensions**:
   - Click the Extensions icon on the left sidebar, or press:
     - Windows/Linux: `Ctrl + Shift + X`
     - macOS: `Cmd + Shift + X`

5. Search for `MATLAB` and install it (published by MathWorks).

> After installing, you may need to reload VS Code for the extension to activate.