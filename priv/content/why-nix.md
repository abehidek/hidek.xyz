---
title: "Why Nix"
description: "Just hype or is there something"
publish_date: "2024-06-28"
tags: ["linux", "nixos", "nix", "proxmox", "lxc", "homelab", "homeserver"]
cover: ""
public: false
---

## Intro

NixOS declarative approach to things certanly solves many problems that a normal sysadmins faces (and even have nightmares), Linux brought many advantages for managing from simple to complex systems, however it's well know that either: 

1. Have a bleeding-edge distro with newer packages and recent updates but high maintanability due to breaking changes (happens a lot on Arch-based ditros)
2. Use a stable distro such as Debian, with curated packages to avoid big breaking changes but with the trade-off of having old versions of packages.

Desktop wise, the first options is preferred by many. For servers of course, the industry appears to prefer the latter. 

NixOS offers a way to combine the two advantages by offering the capability of declaring your entire system in one rule-all configuration that once built, create a new "checkpoint" of your system and being able to rollback to previous "checkpoints" (NixOS calls it generations instead).

Of course, NixOS have a set of advantages and disavantages. this article is not supposed to go to ever advantage NixOS has in comparison to other distros (probably I will write something about it in the future), but to being able to use this distro in LXC (or Linux Containers)

The usage of NixOS in Desktop is possible but I'm afraid to tell that it isn't to everybody. However for servers it's advantages outweights the disanvatages:

- Being able to easily reproduce the configuration to another machine
- These replicas are literally the same (same packages, same version, same dependencies), without having to resort to docker, or virtual machines, since each Nix builds each package in isolation.
- Servers doesn't change too often, however when they change, most probably you will need a documentation to see how it was setup iniatilly (if it even exists), on NixOS however, the code **is** the documentation.
- Need to perform a change?, no problem change the configuration, rebuild it and if it fails it will not switch to it, but if it builds succesfully but you wan't to rollback to previous configuration, no problem, just rollback.