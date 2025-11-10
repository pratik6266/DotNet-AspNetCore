# Makefile for StudentAPI (.NET)
# Targets: restore, build, test, watch, run, publish, clean, help

SOLUTION = StudentAPI.sln
PROJECT = StudentAPI.csproj
CONFIG = Release
ARTIFACT_DIR = publish

.PHONY: all help restore build test watch run publish clean

all: build

help:
	@echo "Makefile targets (use: make <target>)"
	@echo "  restore   - dotnet restore $(SOLUTION)"
	@echo "  build     - dotnet build $(SOLUTION) -c $(CONFIG)"
	@echo "  test      - run dotnet test for any test projects (skips if none found)"
	@echo "  watch     - dotnet watch run for $(PROJECT)"
	@echo "  run       - dotnet run --project $(PROJECT) -c $(CONFIG)"
	@echo "  publish   - dotnet publish $(PROJECT) -c $(CONFIG) -o $(ARTIFACT_DIR)"
	@echo "  clean     - remove bin/ obj/ and $(ARTIFACT_DIR)"

restore:
	dotnet restore $(SOLUTION)

build: restore
	dotnet build $(SOLUTION) -c $(CONFIG) --no-restore

# Runs tests if any test projects are present. If none are found, this target exits successfully.
test:
	@TESTS=$$(find . -maxdepth 4 -type f -name '*Tests*.csproj' -print 2>/dev/null); \
	if [ -z "$$TESTS" ]; then \
		echo "No test projects found; skipping tests."; \
		exit 0; \
	else \
		echo "Running tests: $$TESTS"; \
		dotnet test $$TESTS -c $(CONFIG) --no-restore; \
	fi

# Use dotnet watch for local development. Requires the SDK's watch tool (included in modern SDKs).
watch:
	dotnet watch --project $(PROJECT) run

run:
	dotnet run --project $(PROJECT) -c $(CONFIG)

publish: build
	dotnet publish $(PROJECT) -c $(CONFIG) -o $(ARTIFACT_DIR) --no-build

clean:
	rm -rf bin obj $(ARTIFACT_DIR)
	@echo "Cleaned bin/, obj/ and $(ARTIFACT_DIR)"
