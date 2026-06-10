# Bioinformatics Tool Packaging — Internship Repo

Working repository for packaging bioinformatics tools using the Nix package manager. Contains reproducible Nix derivations for sequence analysis tools used in metagenomic and repeat-element workflows.

---

## Tools

### Kraken2
Nix derivation for [Kraken2](https://ccb.jhu.edu/software/kraken2/) — a taxonomic sequence classification system developed at Johns Hopkins CCB. Uses exact k-mer matches against a reference database to classify metagenomic reads at high speed and accuracy.

**File:** `kraken2/kraken2.nix`

Packages Kraken2 v2.1.4 from source with the following dependencies: `rsync`, `perl`, `wget`, `gnused`, `findutils`, `libgcc`, `llvmPackages.openmp`, `zlib`.

To build:
```bash
nix-build -A kraken2
```

### RepeatMasker
Working directory for packaging [RepeatMasker](https://www.repeatmasker.org/) — a tool for screening DNA sequences for interspersed repeats and low-complexity regions using the Repbase repeat library.

**Directory:** `RepeatMasker/`

---

## Structure

```
├── kraken2/
│   └── kraken2.nix        # Nix derivation for Kraken2 v2.1.4
├── RepeatMasker/
│   └── README.md          # Working notes
└── trash/
    └── test.nix           # Outdated derivation drafts
```

---

## Requirements

- [Nix package manager](https://nixos.org/download.html)

```bash
# Install Nix (if not already installed)
sh <(curl -L https://nixos.org/nix/install) --daemon
```

---

## Background

Nix derivations provide fully reproducible builds — every dependency is pinned by hash, making these packages portable across Linux environments without manual dependency management. This is particularly useful for bioinformatics pipelines where tool version consistency directly affects result reproducibility.
