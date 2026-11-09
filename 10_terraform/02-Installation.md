# Installing Terraform

Before you can write or run any Terraform code, Terraform must be installed on your computer. Terraform is a single command-line program (called `terraform`) that you run from your terminal.

This guide walks you through installing it on **macOS**, **Linux** and **Windows**, then checking that it works.

> **Tip:** Jump straight to the section for your operating system. You only need to follow one of them.

---

## Table of Contents
- [macOS](#macos)
- [Linux (Ubuntu / Debian)](#linux-ubuntu--debian)
- [Windows](#windows)
- [Verify the Installation](#verify-the-installation)
- [Troubleshooting](#troubleshooting)
- [Optional: VS Code Extension](#optional-vs-code-extension)

---

## macOS

On macOS, the easiest way to install Terraform is with **Homebrew**, a package manager for Mac.

### Step 1: Check that Homebrew is installed
Open the **Terminal** app and run:
```bash
brew --version
```
- If you see a version number (e.g. `Homebrew 4.x.x`), go to Step 2.
- If you see `command not found: brew`, install Homebrew first by following the instructions at [brew.sh](https://brew.sh/), then come back here.

### Step 2: Add the HashiCorp repository
HashiCorp (the company behind Terraform) keeps its own Homebrew "tap" with the official, up-to-date version of Terraform. Add it with:
```bash
brew tap hashicorp/tap
```

### Step 3: Install Terraform
```bash
brew install hashicorp/tap/terraform
```

### Updating Terraform later
```bash
brew update
brew upgrade hashicorp/tap/terraform
```

Now jump to [Verify the Installation](#verify-the-installation).

---

## Linux (Ubuntu / Debian)

On Ubuntu or Debian, you install Terraform from HashiCorp's official package repository using `apt`.

### Step 1: Install the required tools
```bash
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common wget
```

### Step 2: Add HashiCorp's GPG key
This key lets your system confirm that the Terraform package really comes from HashiCorp.
```bash
wget -O- https://apt.releases.hashicorp.com/gpg | \
  gpg --dearmor | \
  sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
```

### Step 3: Add the HashiCorp repository
```bash
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
  sudo tee /etc/apt/sources.list.d/hashicorp.list
```

### Step 4: Install Terraform
```bash
sudo apt-get update && sudo apt-get install -y terraform
```

> **Using another Linux distribution** (Fedora, CentOS, Amazon Linux, etc.)? Follow the instructions for your distribution on the [official install page](https://developer.hashicorp.com/terraform/install).

Now jump to [Verify the Installation](#verify-the-installation).

---

## Windows

Choose **one** of the options below. Option A is the quickest.

### Option A: Install with winget (recommended)
`winget` comes pre-installed on Windows 10 (recent versions) and Windows 11.

1. Open **PowerShell** or **Command Prompt**.
2. Run:
   ```powershell
   winget install --exact --id Hashicorp.Terraform
   ```
3. **Close and reopen** your terminal so it picks up the new program.

### Option B: Install with Chocolatey
If you already use [Chocolatey](https://chocolatey.org/install):
1. Open **PowerShell as Administrator** (right-click PowerShell → *Run as administrator*).
2. Run:
   ```powershell
   choco install terraform
   ```
3. Close and reopen your terminal.

### Option C: Manual installation
Use this if you can't use winget or Chocolatey.

1. Go to the [Terraform download page](https://developer.hashicorp.com/terraform/install) and, under **Windows**, download the **AMD64** zip file (most PCs). Choose **386** only if you have an old 32-bit machine.
2. Create a folder for Terraform, for example `C:\terraform`.
3. Unzip the downloaded file and move `terraform.exe` into `C:\terraform`.
4. Add that folder to your **PATH** so Windows can find `terraform` from any terminal:
   1. Press the **Windows key**, search for **"Edit the system environment variables"** and open it.
   2. Click **Environment Variables...**
   3. Under **User variables**, select **Path** and click **Edit...**
   4. Click **New** and enter `C:\terraform`.
   5. Click **OK** on every window to save.
5. Close and reopen your terminal.

Now continue to [Verify the Installation](#verify-the-installation).

---

## Verify the Installation

On any operating system, open a **new** terminal window and run:
```bash
terraform --version
```

If Terraform is installed correctly, you'll see something like this (your version number may be different):
```
Terraform v1.x.x
on darwin_arm64
```

You can also run `terraform -help` to see the list of available commands.

**That's it, Terraform is installed and you're ready to move on to the next lesson.**

---

## Troubleshooting

| Problem | Likely cause | Fix |
|---|---|---|
| `terraform: command not found` (macOS/Linux) | The terminal session started before the install, or the install failed. | Open a new terminal window. If it still fails, re-run the install commands and check them for errors. |
| `'terraform' is not recognized as an internal or external command` (Windows) | The folder holding `terraform.exe` is not on your PATH, or the terminal wasn't restarted. | Close and reopen the terminal. For a manual install, recheck Step 4 of Option C. |
| `command not found: brew` (macOS) | Homebrew isn't installed. | Install it from [brew.sh](https://brew.sh/). |
| Permission denied errors (Linux) | The command needs admin rights. | Make sure the command starts with `sudo`. |

---

## Optional: VS Code Extension

If you write code in **Visual Studio Code**, install the official **HashiCorp Terraform** extension. It adds syntax highlighting, auto-completion and formatting for `.tf` files.

1. Open VS Code and go to the **Extensions** panel (`Ctrl+Shift+X` on Windows/Linux, `Cmd+Shift+X` on Mac).
2. Search for **HashiCorp Terraform**.
3. Click **Install**.

---

## Official Resources
- [Terraform install page](https://developer.hashicorp.com/terraform/install)
- [Install Terraform tutorial](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
