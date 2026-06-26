# List just recipes
default:
    @just --list

# Build NixOS configuration
build:
    nh os build .

# Check code-quality and validate flake evaluation
check:
    statix check . --ignore ".direnv,result,result-*"
    nix flake check

# Diff current system profile against last build generation
diff:
    @echo "--- Comparing current system with build result ---"
    nvd diff /run/current-system result/

# Format all Nix files
fmt:
    nix fmt

# Switch to new NixOS configuration
switch:
    nh os switch .

# Test NixOS configuration
test:
    nh os test .

# Update all flake inputs and test evaluation
update:
    nix flake update
    just check
