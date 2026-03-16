#!/bin/bash
# Post-create: install a mock "openclaw" so the setup script passes pre-flight checks.
set -e

# Mock openclaw binary (simulates real CLI responses)
sudo tee /usr/local/bin/openclaw > /dev/null <<'EOF'
#!/bin/sh
case "$1" in
  --version) echo "openclaw 2026.3.8-codespace" ;;
  gateway)   echo "gateway ${2:-status}: ok (mock)" ;;
  onboard)   echo "onboard: ok (mock)" ;;
  models)    echo "models: ok (mock)" ;;
  *)         echo "openclaw mock: $*" ;;
esac
EOF
sudo chmod +x /usr/local/bin/openclaw

# Create ~/.openclaw dir (normally created by onboarding)
mkdir -p "$HOME/.openclaw"

echo ""
echo "✅ Dev environment ready!"
echo ""
echo "Usage examples:"
echo "  bash tools/setup_cometapi.sh                          # interactive (will prompt for key)"
echo "  bash tools/setup_cometapi.sh --key sk-yourkey         # non-interactive"
echo "  bash tools/setup_cometapi.sh --key sk-yourkey --dry-run"
echo "  bash tools/test_setup_cometapi.sh                      # run full automated test suite"
echo ""
