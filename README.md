# ctf-box

arch-based ctf environment.
`ghcr.io/rw-r-r-0644/ctf-box`

## flavors
`base`, `pwn`, `rev`, `crypto`, `web`, `osint`, `full`

## usage

```bash
# with sysbox (best)
docker run --runtime=sysbox-runc -it --rm ghcr.io/rw-r-r-0644/ctf-box:full

# without sysbox
docker run -it --rm ghcr.io/rw-r-r-0644/ctf-box:full
```

## tools

<details>
<summary>base (everywhere)</summary>

* base-devel, yay, git, sudo, docker, catatonit
* vim, nano, tmux, openssh, wget, curl, jq, unrar, upx
* gdb, strace, ltrace, binwalk, exiftool, nasm, patchelf
* socat, gnu-netcat
* pwntools, ipython
</details>

<details>
<summary>pwn</summary>

* radare2, ropper, rr, qemu-user, qemu-user-static
* pwndbg, checksec, pwninit, one_gadget, seccomp-tools
* angr
</details>

<details>
<summary>rev</summary>

* ghidra, rizin, r2ghidra, radare2, jdk-openjdk
* jadx, android-apktool
* frida-tools, angr, lief, z3-solver
</details>

<details>
<summary>crypto</summary>

* sagemath, z3, numpy, hashcat, john
* pycryptodome
</details>

<details>
<summary>web</summary>

* nmap, sqlmap, nikto
* metasploit, gobuster, mitmproxy
</details>

<details>
<summary>osint</summary>

* sherlock-project, socialscan, theHarvester, holehe
</details>

## hooks
mount stuff to `/etc/entrypoint.d/` to run it at start.

---
last build: N/A

---
Last build: 20260118
