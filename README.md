## PSP Survival Programming Kit

A small experimental project to preserve a simple and lightweight way to compile C code for the PSP hardware. Built with minimal dependencies to provide control over the development environment and keep it transparent over time.

Before using this kit and compile the sample codes, make sure the required build and packaging tools are installed and available in your `PATH`:
- `mipsel-linux-gnu-*`
- `psp-prxgen`
- `pack-pbp`
- python3

Noting that this project is free of Newlib and relies on native system APIs with additional custom processing for the platform.

# Installation
```
sudo apt update
sudo apt install gcc-mipsel-linux-gnu binutils-mipsel-linux-gnu
```

```
./build.sh
echo "export SPKIT_ROOT=\"$(pwd)\"" >> ~/.bashrc
tail -1 ~/.bashrc
source ~/.bashrc
```

## Contribution Guidelines

### AI-assisted development

AI tools may be used as development aids. However, the following rules apply strictly:

* All commits must be authored by a human contributor (pseudonyms are perfectly acceptable).
* The commit history must not contain any AI attribution as author or co-author.
* Contributors must fully review, understand, and validate all submitted code before opening a pull request.
* Contributors are expected to be able to explain and justify their changes during reviews.
* The contributor is responsible for ensuring that their code or changes do not break existing functionality, integrations, dependencies, documentation consistency, APIs, build processes, tests, or the overall behavior and technical integrity of the project.
*In short: AI can assist, but humans must retain full ownership of the work.*

Pull requests that include AI attribution in commits, or that are not clearly understood and validated by the contributor, will be rejected.

### License compatibility

All code submitted to this repository must be compatible with the MIT License. Dependencies or code snippets under more restrictive licenses (e.g. GPL, LGPL, proprietary) are not accepted. Contributors are responsible for verifying that any third-party code they include is under a permissive license granting at least the same level of freedom as MIT.

## Disclamer
This project is provided for educational and research purposes only. This project and code are provided as-is without warranty. Users assume full responsibility for any implementation or consequences. Use at your own discretion and risk

*m-c/d*
