---
title: Memory safety and C++ Successors - STLab
description: This is the 'Memory safety and C++ Successors whitepaper
---

# Memory safety and C++ successors

## Abstract

Software exploits increasingly harm consumers and threaten national security.
Memory safe programming languages provide substantial protection and some groups
are calling for legislation incentivizing their adoption. Unfortunately, it
isn't clear how companies with large existing C++ codebases can adapt. In an
effort to help answer that question, this paper explores the adoption
feasibility of several memory safe alternatives to C++.

## Introduction

Policy setters are urging software providers to adopt memory safe programming
languages. National Institute of Standards and Technology (NIST)'s October 2021
[Guidelines on Minimum Standards for Developer Verification of
Software](https://www.nist.gov/itl/executive-order-14028-improving-nations-cybersecurity/recommended-minimum-standards-vendor-or)
called for usage of memory safe languages instead of C and C++ "where practical"
because memory access errors can lead to privilege escalation, denial of
service, data corruption, and exfiltration of data. This was amplified in National Security Agency (NSA)'s November 2022 [Software
Memory
Safety](https://media.defense.gov/2022/Nov/10/2003112742/-1/-1/0/CSI_SOFTWARE_MEMORY_SAFETY.PDF)
cybersecurity information sheet which highlighted that a majority of
vulnerabilities in well-known products result from memory safety violations.
Acknowledging that memory safe languages do not eliminate memory
safety issues entirely, the NSA nonetheless recommends organizations shift
towards memory safe languages such as C#, Go, Java, Ruby, Rust, and Swift.
In January 2023, Consumer Reports published [Future of
Memory Safety: Challenges and
Recommendations](https://advocacy.consumerreports.org/wp-content/uploads/2023/01/Memory-Safety-Convening-Report-1-1.pdf),
which reiterated the NSA's claims, adding that regulatory or market incentives
are necessary for organizations to move away from C and C++.
Finally, the White House's March 2023 [National Cybersecurity
Strategy](https://www.whitehouse.gov/wp-content/uploads/2023/03/National-Cybersecurity-Strategy-2023.pdf)
outlined a plan to establish liability for insecure software development
practices and use federal purchasing power as additional leverage.

While the call to transition to memory-safe languages is clear, the path to
doing so is not. Wholesale rewrites of large C++ codebases are cost
prohibitive and incremental migrations are not well supported in
most safe languages. Fortunately, this is an area of active development and
improvements are coming.

This paper surveys memory-safe C++ successor languages with a critical focus on
adoption. We'll take a look at short-term, mid-term (3-5 years), and long-term
(5-10 years) solutions.

## Short term options

### Use dynamic languages where applicable

When high performance isn't required (e.g. user interfaces, business logic
components, and configuration systems), a memory-safe dynamic language such as
JavaScript, [Lua](https://www.lua.org/), or [Python](https://www.python.org/)
can be used. One can embed an interpreter in a C++ application, or expose C++
code to an interpreter. For the former, the main C++ application launches the
interpreter as needed, while providing access to C++ functions and data
structures through bindings. In the latter, the main application is written in
the dynamic language and calls the C++ code as needed. Python is popular in this
setup.

Adopting dynamic languages in a larger C++ system comes with costs proportional
to the size of the interface boundary between the two languages. For every
entity exposed to the dynamic language from C++, a binding must be created.
Libraries like pybind11 can help mitigate this by simplifying the process.
Although most bindings require only a few lines of code, the cost can
accumulate. Additionally, there is increased maintenance cost if the layer
between the languages changes frequently. Debugging can also be
challenging, as most debuggers don't support debugging across language
boundaries. Furthermore, while dynamic languages offer memory safety benefits,
they often lack type-safety. Measures can be taken to improve this, such as
using [TypeScript](https://www.typescriptlang.org/) instead of JavaScript or
adopting a Python type checker like [mypy](https://mypy-lang.org/).

A significant advantage of dynamic language adoption is that developers are
often already familiar with the most popular ones, and even if not, they are
easy to learn and use. Also, developers are generally more productive with
dynamic languages than with C++ due to their simplicity. This has led to the
natural industry-wide adoption of dynamic languages. Another benefit is the
faster feedback loop for development, as a compilation phase is not required.

*References*:

- [v8](https://v8.dev/) is a widely-used JavaScript engine that serves as both
  both as an embedded language and as a consumer of C++ libraries via
  [node.js](https://nodejs.org/en/).
- [pybind11](https://pybind11.readthedocs.io/en/stable/) is a popular library
  for creating bindings between C++ and Python.
  [cppyy](https://cppyy.readthedocs.io/en/latest/) and
  [Cython](https://cython.org/) are notable alternatives.
- [TypeScript](https://www.typescriptlang.org/) is a superset of JavaScript that
  introduces type safety.
- [mypy](https://mypy-lang.org/) is a widely-used type checker for Python.
- [Lua](https://www.lua.org/) is a popular language specifically designed for
  embedding.

### Use Rust with binding layers

Rust has gained recognition as a viable solution to C++'s memory safety
challenges, and for good reason. Engineered with memory safety at its core, Rust
caters to the same use cases as C++ while providing additional benefits. Its
thriving and expanding community demonstrates its success, as highlighted by
earning the "Most Loved Programming Language" award in the [Stack Overflow
developer survey](https://survey.stackoverflow.co/2022/) for seven consecutive
years. This achievement can be partially attributed to the language's leaders
emphasizing inclusion and ergonomics.

Though Rust offers numerous advantages for new projects, it is not a universal
solution for existing C++ systems. Integrating C++ with Rust encounters
challenges akin to those found in dynamic language interoperability, including
the requirement to create and maintain bindings. Moreover, Rust's ecosystem
heavily depends on its Cargo build system, which can introduce complications
when incorporating it into CMake or other prominant C++ build systems. Finally,
Rust's borrow checker can have a daunting learning curve for C++ developers.

Despite these hurdles, Rust stands out as the only memory safe language
delivering performance on par with C++. By additionally providing type and
thread safety, Rust is an enticing choice for those migrating to a
safe language in the short term.

*References*:

- [Rust](https://www.rust-lang.org/) is a memory-safe language with a focus on
  performance and safety.
- [CXX](https://cxx.rs/) is a library for creating bindings between C++ and Rust.

## Medium term options

### Streamlined C++/Rust interop with Crubit

Google's [Crubit](https://github.com/google/crubit) project, anticipated to be
production ready in the medium term, aims to facilitate seamless C++/Rust
interoperability. Crubit's goal is to parse C++ code and automatically generate
high-quality Rust bindings while also providing the capability to perform the
reverse operation. Since C++ code lacks lifetime analysis, Crubit introduces new
annotations to specify lifetimes in C++ objects. Additionally, the project
incorporates a tool to auto-generate these annotations based on heuristics.
Additional, optional annotations further enhance the ergonomics of the generated
code.

Crubit's approach offers several benefits. First, it has a one-time cost for
integrating Rust into an existing C++ codebase; once the build system is in
place, the entire C++ codebase is readily available for Rust code. Second, the
automatic generation of bindings at build time eliminates the necessity of
ongoing binding maintenance.

While Crubit offers a more cost-effective solution compared to creating bindings
manually with CXX, it is not without its drawbacks. It remains uncertain how
ergonomic the automatically generated Rust bindings will be. Moreover, given
Crubit's deep integration with the Bazel build system, its compatibility with
popular build systems like CMake is an open question.

*References*:
- Crubit's [High-level design of C++/Rust
  interop](https://github.com/google/crubit/blob/main/docs/design.md)
  comprehensively outlines the project's objectives, its methodology, and an
  in-depth analysis of alternatives.
- [Autocxx](https://github.com/google/autocxx) is a project with similar goals
  to Crubit, but strives to achieve them by utilizing existing Open Source
  tools like [libclang](https://clang.llvm.org/doxygen/group__CINDEX.html) and
  [bindgen](https://rust-lang.github.io/rust-bindgen/).

### Adopt Circle

[Circle](https://www.circle-lang.org/) is a C++ compiler by Sean Baxter that
offers additional opt-in language features. A feature currently under
development introduces memory safety through a Rust-inspired borrow checker.
While this alone would not make the language memory safe, further development
could lead to that outcome.

While safety features in Circle are still in their early stages, the project's
rapid progress instills confidence in its eventual delivery. The more
significant concern surrounding Circle lies in its long-term viability, as it is
currently a closed-source project maintained by a single developer. If a
large company were to acquire the project and make it open-source, these
concerns would be assuaged.

*References*:
- [New Circle
  notes](https://github.com/seanbaxter/circle/blob/master/new-circle/README.md)
  describes the current state of Circle's development and discusses planned work
  on the "[borrow_checker]" and "[relocate]" features.

### Use Swift where applicable

[Swift](https://swift.org/) is a compiled programming language developed by
Apple that achieves memory safety through a combination of static and dynamic
checks. Although it lags C++ and Rust in performance, it significantly outpaces
dynamic languages, making it a potential alternative in many situations.
Swift/C++ interoperability remains experimental, but, once matured, could become
a viable option for many use cases.

However, adopting Swift in a large existing C++ codebase presents concerns.
Apple's hardware business raises questions about its commitment to supporting
Swift as a first-class citizen on non-Apple platforms. Additionally, it is
uncertain whether C++ interoperability will be prioritized over other planned
Swift features. Lastly, Apple's exclusive control over the Swift language may
create conflicts of interest with the open-source community.

Despite these drawbacks, we believe Swift could emerge as a promising option,
and its C++ interoperability should be monitored as it matures.

*References*:

- Swift's [C++ Interoperability
  Status](https://github.com/apple/swift/blob/main/docs/CppInteroperability/CppInteroperabilityStatus.md)
  document outlines the current state of Swift's experimental support for C++
  interoperability.
- The [Add a C++ Interoperability Vision Document](https://github.com/apple/swift/pull/60501)
  pull request features a document proposing a vision for consuming C++ APIs
  from Swift.
- The [Using Swift from
  C++](https://github.com/apple/swift-evolution/blob/main/visions/using-swift-from-c%2B%2B.md)
  vision document outlines a concept for utilizing Swift APIs within C++ code.

## Long term options

### Adopt Carbon

Google's [Carbon project](https://github.com/carbon-language/carbon-lang) is an
initiative to create a memory-safe programming language and supporting ecosystem
that can seamlessly interoperate with existing C++ codebases while being
easy for experienced C++ engineers to learn. The project emphasizes a welcoming
and inclusive community and touts over 4,000 members on its discord server.

Despite Carbon's commendable objectives and approach, the project's engineering
progress has been slow. Core feature designs were slated for completion in the
[2021
roadmap](https://github.com/carbon-language/carbon-lang/blob/c72c201133ddc7af56a5d5592fff5eb4a31d0e10/docs/project/roadmap.md),
then the [2022
roadmap](https://github.com/carbon-language/carbon-lang/blob/a0a4146bcfd1ac452b10cd5bde4a5da2c0c2a7af/docs/project/roadmap.md),
and now the [2023
roadmap](https://github.com/carbon-language/carbon-lang/blob/9faf87e17142f1afc8fad623d50969401efa9485/docs/project/roadmap.md).
After at least four years of development, there is still no compiler for the
project. The limited tangible progress and Google being the sole company
providing dedicated resources contribute to a significant risk of project
cancellation. Furthermore, memory safety feature designs have been deferred
until at least the 0.2 release, according to the [milestones
definition](https://github.com/carbon-language/carbon-lang/blob/07360e367675ef6baa0c59d6b23d456489e79292/docs/project/milestones.md).
This delay has led some to believe that a substantial number of core features
will need revisiting.

Although Carbon has much to achieve before becoming a viable option, its
long-term vision aligns well with the C++ community's needs for a safe and
easily adoptable language.

### Adopt Safe C++

Various initiatives are underway within WG21, the C++ Standardization Body, to
improve C++'s safety. One proposal would allow source files to opt-in to a
"profile" that enables memory safety features. Furthermore, in his paper
[Lifetime safety: Preventing common
dangling](https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2019/p1179r1.pdf),
Herb Sutter introduces lifetime annotations that, with a static analyzer,
prevent numerous memory-related issues.

While the proposed features enable a painless migration to memory-safety, there
are significant challenges. First, these features will be contentious within
WG21, which has shown reluctance to prioritize addressing C++'s memory safety
problems. Second, it remains unclear whether these features are sufficient to
make C++ a memory-safe language. Finally, C++'s complexity exacerbates the
difficulty of solving this problem, and the refusal to abandon backwards
compatibility with non-safe C++ makes the task even more challenging.

*References*:

- [DG Opinion on Safety for ISO
  C++](https://www.open-std.org/JTC1/SC22/WG21/docs/papers/2023/p2759r0.pdf)
  showcases a safety direction suggested the WG21 Direction Group.
- [Design Alternatives for Type-and-Resource Safe
  C++](https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2022/p2687r0.pdf)
  introduces the idea of safety profiles.
- [Lifetime safety: Preventing common
  dangling](https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2019/p1179r1.pdf)
  proposes a lifetime annotation mechanism for C++.

## Notable alternatives considered

We examined several languages that have been proposed as safe C++ replacements
but ultimately fell short of our requirements. Here is a brief overview of
these.

The first language is the [Zig programming language](https://ziglang.org/). Zig
aims to be a simple, low-level language that includes powerful metaprogramming
capabilities and incorporates some memory safety features. Although Zig does
prevent out-of-bounds array access and includes optional runtime checks, accessing
uninitialized memory and invalid pointer indirection can be easily performed
without safety escapes. Additionally, Zig's use of a C intermediate layer to
interoperate with C++ is cumbersome.

The [Val programming language](https://www.val-lang.dev/) is a part of a
research project that investigates memory safety through mutable value
semantics. Val's primary focus is on research, not addressing practical
considerations like C++ interop. Consequently, we anticipate Val's primary
contribution to be ideas incorporated into other languages.

## Conclusion

This report explores transitioning C++ codebases to memory-safe languages. We
analyzed short, medium, and long-term options. Given the diversity of contexts
and constraints companies face, we anticipate most will employ a combination of
these approaches. Although there is no single solution that works universally,
we encourage continued efforts to refine existing options and to explore new
possibilities. Therefore, we welcome contributions from the broader community to
advance this critical topic.