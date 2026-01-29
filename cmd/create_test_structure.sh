#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo "========================================"
echo "Creating Modular TEST Folder Structure..."
echo "========================================"

cd "$(dirname "$0")/test"

echo ""
echo -e "${BLUE}[1/3] Creating CORE test folders...${NC}"
mkdir -p core/common
mkdir -p core/network
mkdir -p core/database
echo -e "${GREEN}✓ Core test folders created${NC}"

echo ""
echo -e "${BLUE}[2/3] Creating MOVIE test folders...${NC}"
mkdir -p movie/data/models
mkdir -p movie/data/datasources
mkdir -p movie/data/repositories
mkdir -p movie/domain/usecases
mkdir -p movie/presentation/provider
mkdir -p movie/presentation/pages
echo -e "${GREEN}✓ Movie test folders created${NC}"

echo ""
echo -e "${BLUE}[3/3] Creating TV_SERIES test folders...${NC}"
mkdir -p tv_series/data/models
mkdir -p tv_series/data/datasources
mkdir -p tv_series/data/repositories
mkdir -p tv_series/domain/usecases
mkdir -p tv_series/presentation/bloc
echo -e "${GREEN}✓ TV Series test folders created${NC}"

echo ""
echo "========================================"
echo -e "${GREEN}✅ ALL TEST FOLDERS CREATED!${NC}"
echo "========================================"
echo ""
echo "Ready for file migration!"
echo ""
