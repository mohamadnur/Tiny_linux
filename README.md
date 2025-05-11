# Tiny Linux Kernel Project

## Overview

This project is a minimalistic custom Linux system built from scratch, intended for educational purposes to understand how the Linux kernel works and how user-space programs are initialized.

The goal is **not** to build a fully functional Linux distribution, but rather to explore and document the entire bootstrapping process from kernel to shell interaction.

---

## Objectives

- Build a **Tiny Linux kernel** with only the essential features.
- Setup a basic **root filesystem** manually.
- Compile and include **user-space tools** (bash, coreutils, etc.).
- Use **QEMU** for testing the system without risking the host environment.
- Gain a deep understanding of **init, libc, syscalls**, and low-level behavior.

---

## Requirements

Make sure to install the following packages:

```bash
sudo apt install \
bc binutils bison dwarves flex gcc git gnupg2 gzip \
libelf-dev libncurses5-dev libssl-dev make openssl \
pahole perl-base rsync tar xz-utils autoconf gperf \
autopoint texinfo texi2html gettext gawk bzip2 \
qemu-system-x86 libtool
```


> 💡 These packages are essential for compiling the Linux kernel, building userland utilities, and running the system in a virtualized environment.  
> Some tools (like `dwarves`, `pahole`, `autopoint`, `gettext`) are used by build systems such as autotools and makefiles for generating configuration scripts, especially in older projects.

---

## 📚 Build Guide

To make the system functional, you need to build and install essential components manually.  
Each stage is documented in detail:

| Step          | Description                                                              | Link                                 |
|---------------|--------------------------------------------------------------------------|--------------------------------------|
| 📦 Root FS     | Create a minimal root filesystem structure                                | [Setup RootFS](./docs/create-filesystem.md)     |
| 🔧 Kernel      | Configure, compile, and install the Linux kernel                         | [Build the Kernel](./docs/build_kernel.md) |
| 🧱 glibc       | Compile and install GNU C Library (glibc)                                 | [Build glibc](./docs/build-glibc.md)       |
| 🐚 Shell       | Install a basic shell (e.g., dash or bash) to interact with the system    | [Setup Shell](./docs/build_bash.md)       |
| 🔨 Coreutils   | Build basic Unix commands like `ls`, `rm`, `cp`                           | [Build coreutils](./docs/build_coreutils.md) |
| ⚙️ util-linux | Install essential system tools like `mount`, `fdisk`, `chroot`           | [Build util-linux](./docs/build_util_linux.md) |

> 📝 **Note**: Each page includes common build steps, configuration flags, and solutions for known errors.
