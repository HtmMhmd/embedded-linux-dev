#!/bin/bash

set -e

# Create directory structure for Yocto
mkdir -p ~/yocto-dunfell

cd ~/yocto-dunfell

# Clone Poky repository (Dunfell branch)
if [ ! -d "poky" ]; then
    echo "Cloning Poky (Dunfell)..."
    git clone -b dunfell git://git.yoctoproject.org/poky
else
    echo "Poky already exists, skipping clone..."
fi

# Create setup script for easy environment initialization
cat > ~/setup-build-env.sh << 'EOL'
#!/bin/bash
cd ~/yocto-dunfell/poky
source oe-init-build-env $1

# Add commonly used targets
echo "Available machines in Poky:"
echo " - qemuarm"
echo " - qemuarm64"
echo " - qemux86"
echo " - qemux86-64"
echo ""
echo "Example build command:"
echo "bitbake core-image-minimal"
echo ""
echo "Yocto environment initialized!"
EOL

chmod +x ~/setup-build-env.sh

# Create README with instructions
cat > ~/README.md << 'EOL'
# Yocto Dunfell Development Environment

This Codespace is configured for Yocto Dunfell development and cross-compilation.

## Getting Started

1. Initialize the build environment:
   ```
   ~/setup-build-env.sh [build-directory]
   ```

2. Configure your build by editing `conf/local.conf` and `conf/bblayers.conf`

3. Build a target image:
   ```
   bitbake core-image-minimal
   ```

## Cross-compilation

To use the cross-compiler outside the Yocto build:

1. First build the SDK:
   ```
   bitbake -c populate_sdk core-image-minimal
   ```

2. Install the SDK:
   ```
   ./tmp/deploy/sdk/*.sh
   ```

3. Source the environment setup script:
   ```
   source /opt/poky/*/environment-setup-*
   ```

Now you can use the cross-compiler directly with $CC, $CXX, etc.
EOL

echo "Yocto Dunfell development environment setup complete!"
echo "To begin, run: ~/setup-build-env.sh"
