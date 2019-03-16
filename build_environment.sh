ENV="$1"

if [ -z "$1" ]; then
  echo "No environment selected; using default"
  ENV="default"
fi
echo "Building for environment $ENV"


rm -rf deployment || true

vortex --template templates --output deployment -varpath ./environments/$ENV.yaml
