#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo "========================================"
echo "Creating Modular Folder Structure..."
echo "========================================"

cd "$(dirname "$0")/lib"

echo ""
echo -e "${BLUE}[1/3] Creating CORE module folders...${NC}"
mkdir -p core/common
mkdir -p core/network
mkdir -p core/database
mkdir -p core/di
echo -e "${GREEN}✓ Core module folders created${NC}"

echo ""
echo -e "${BLUE}[2/3] Creating MOVIE module folders...${NC}"
mkdir -p movie/data/models
mkdir -p movie/data/datasources
mkdir -p movie/data/repositories
mkdir -p movie/domain/entities
mkdir -p movie/domain/repositories
mkdir -p movie/domain/usecases
mkdir -p movie/presentation/pages
mkdir -p movie/presentation/provider
mkdir -p movie/presentation/widgets
echo -e "${GREEN}✓ Movie module folders created${NC}"

echo ""
echo -e "${BLUE}[3/3] Creating TV_SERIES module folders...${NC}"
mkdir -p tv_series/data/models
mkdir -p tv_series/data/datasources
mkdir -p tv_series/data/repositories
mkdir -p tv_series/domain/entities
mkdir -p tv_series/domain/repositories
mkdir -p tv_series/domain/usecases
mkdir -p tv_series/presentation/pages
mkdir -p tv_series/presentation/bloc
mkdir -p tv_series/presentation/widgets
echo -e "${GREEN}✓ TV Series module folders created${NC}"

echo ""
echo "========================================"
echo -e "${GREEN}✅ ALL FOLDERS CREATED SUCCESSFULLY!${NC}"
echo "========================================"
echo ""
echo "Next step: Run 'create_test_structure.sh' to create test folders"
echo "Or notify me to start moving files!"
echo ""
