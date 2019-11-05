# Measurements for GHC #15842

## Structure

The `ghc-.*_dumps` folders contain GHC dump log files. `result.txt` shows the
measurement output.

## Requirements

- `nix`

## Usage

Adjust `Makefile` to point to your locally built GHC and execute:

```
make
```
