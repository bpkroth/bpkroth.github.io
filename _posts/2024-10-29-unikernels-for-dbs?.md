---
layout: post
title:  "Unikernels for DBs?"
date:   2024-10-29 16:23:45 +0000
categories: [Databases, Systems, Virtualization, Security, Performance]
---

## Get out of my way, OS!

I recently ran across this [blog post](https://thenewstack.io/p99conf-how-ebpf-could-make-faster-database-systems/) about a talk by Andy Pavlo for the [P99 conference](https://www.p99conf.io/) (put together by the ScyllaDB folks).

> As an aside, there was a bunch of other cool looking talks at that conference as well, so definitely check it out.

In it they (briefly) discuss the potential for using [eBPF](https://ebpf.io/what-is-ebpf/) to make database systems faster.
If you don't already know, eBPF is basically a way to run small bits of custom code inside the kernel.
They're constrainted in what they can do and sanity checked through a verifier to try and mitigate some of the potential security concerns in this approach (which of course had their own vulnerabilities, but so it goes).

But, the rough idea is to improve performance of the system by avoid hopping between user and kernel space which is expensive, especially in a virtual machine, and in the modern world of side channel attack mitigations.

> A separate use case is to improve observability by hooking into low level details of the kernel events and matching those up with user space events, which is also super powerful, but we'll leave that as an aside.

Specifically, if we can avoid copying data between user and kernel space, we can avoid a lot of the overhead of context switching and unnessary copies and do at least some of the easy/early processing directly in the kernel.

Other techniques like this are zero-copy I/O or usespace bypass (e.g., DPDK and SPDK) which all take some additional engineering effort to get right as well.

But the high level observation, although not really stated this way, is that virtual memory and isolation of the OS is kind of the problem in terms of getting the application to operate at or near hardware speeds.

## Unikernels for DBs?

Viktor Leis, another great systems and database researcher, recently asked a slightly different question in a [talk](https://db.in.tum.de/~leis/cumulus.pdf) at this year's VLDB [Cloud Databases workshop](https://clouddbworkshop.github.io/2024/):

Q: Is the world finally ready for Unikernels, specifically for DBaaS?

The rough idea is the following:

In the cloud, we run everything inside a VM (for security), but each of those VMs only runs a single application (plus maybe some monitoring software).

> In fact, we've leverged this observation in some of my own projects by tuning kernels with our [MLOS](https://github.com/microsoft/MLOS) project specifically for the application that runs on them (e.g., Redis, MySQL, etc.) with some really nice performance improvements (e.g., 65% reduction in tail latency).

While there is some benefit gained from the mostly composable tooling of a well established OS environment like Debian or Ubuntu Linux (e.g., build, package, install, etc.), for really high performance applications like a DB it's really just in the way and adds a lot of overhead.

By building the DB and kernel directly into a single bootable object (e.g., via [OSv](https://osv.io/) or [Unikraft](https://unikraft.org/)) that runs on a more or less "canonical" VM type (e.g., via x86_64, virtio, PCIe, etc.) we can skip things like context switchin between the kernel and userspace, virtual memory overheads, syscalls for IO, and other things that are just in the way.

This is basically further down that spectrum of "get out of my way, OS!", but even further, and more closely resembles a "LibOS" or "Exokernel" style approach (some classic systems papers that are worth reading).

## Interesting Times

I'm not sure yet which direction we'll go, but I think this is an interesting time and space to be in.

Both of these are really amazing performance focused and low level systems researchers that I really respect, so no shade to either one of them.

I think the eBPF route is one of many in that space and has the potential to make a dent in the performance issues, but without "throwing the baby out with the bath water" so to speak.

The Unikernel approach probably can reclaim more performance by being closer to the baremetal, but as I mentioned to Viktor after the talk, there are a lot of things that I'm sure we'd miss out on including the vast amount of experience from many many engineers in the existing spaces, driver support for emerging hardware, and more.

But, at cloud scales, even a small percentage improvement can be a huge win, and large cloud companies have influence over large hardware companies, and more and more are even developing their own, so some of these issues may not matter (to them) as much, so I'm excited to see where this goes.

## See Also

- [P99Conf: How eBPF Could Make Faster Database Systems](https://thenewstack.io/p99conf-how-ebpf-could-make-faster-database-systems/)
- [Co-Designing Cloud-Native Database Systems and Unikernels -  A Story of Radicalization](https://db.in.tum.de/~leis/cumulus.pdf)
- <https://www.cs.cit.tum.de/dis/research/cumulus>
