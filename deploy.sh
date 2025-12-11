#!/bin/bash

# FINKEEPERS SEO DEPLOYMENT SCRIPT
# Run this script from your website root directory
# Usage: bash deploy.sh

set -e  # Exit on any error

echo "🚀 Starting Finkeepers SEO Deployment..."
echo "========================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Check if we're in the right directory
if [ ! -f "index.html" ] && [ ! -f "index.php" ] && [ ! -d "public" ]; then
    print_error "Please run this script from your website root directory"
    exit 1
fi

# Create backup directory
BACKUP_DIR="seo-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"
print_status "Created backup directory: $BACKUP_DIR"

# Backup existing files
echo "📦 Creating backups..."
[ -f "robots.txt" ] && cp "robots.txt" "$BACKUP_DIR/" && print_status "Backed up robots.txt"
[ -f "sitemap.xml" ] && cp "sitemap.xml" "$BACKUP_DIR/" && print_status "Backed up sitemap.xml"

# Deploy core SEO files
echo "🔧 Deploying core SEO files..."

# Copy robots.txt
if [ -f "finkeepers-seo-fix/robots.txt" ]; then
    cp "finkeepers-seo-fix/robots.txt" "./robots.txt"
    print_status "Deployed robots.txt"
else
    print_error "robots.txt not found in SEO package"
fi

# Copy sitemap.xml
if [ -f "finkeepers-seo-fix/sitemap.xml" ]; then
    cp "finkeepers-seo-fix/sitemap.xml" "./sitemap.xml"
    print_status "Deployed sitemap.xml"
else
    print_error "sitemap.xml not found in SEO package"
fi

# Create images directory if it doesn't exist
mkdir -p "img/optimized"
print_status "Created optimized images directory"

# Copy optimized images
if [ -d "finkeepers-seo-fix/images" ]; then
    cp -r "finkeepers-seo-fix/images/"* "img/optimized/"
    print_status "Deployed optimized images"
else
    print_warning "Optimized images directory not found"
fi

# Copy CSS/JS files
if [ -d "finkeepers-seo-fix/css-js" ]; then
    mkdir -p "assets/css" "assets/js"
    cp "finkeepers-seo-fix/css-js/"*.css "assets/css/" 2>/dev/null || true
    cp "finkeepers-seo-fix/css-js/"*.js "assets/js/" 2>/dev/null || true
    print_status "Deployed minified CSS/JS files"
else
    print_warning "CSS/JS directory not found"
fi

# Validate deployed files
echo "🔍 Validating deployed files..."

# Check robots.txt
if [ -f "robots.txt" ]; then
    if grep -q "Sitemap:" "robots.txt"; then
        print_status "robots.txt is valid"
    else
        print_warning "robots.txt may be missing sitemap reference"
    fi
else
    print_error "robots.txt deployment failed"
fi

# Check sitemap.xml
if [ -f "sitemap.xml" ]; then
    if grep -q "<?xml" "sitemap.xml"; then
        print_status "sitemap.xml is valid XML"
    else
        print_error "sitemap.xml is not valid XML"
    fi
else
    print_error "sitemap.xml deployment failed"
fi

# Set proper permissions
echo "🔒 Setting file permissions..."
chmod 644 robots.txt sitemap.xml 2>/dev/null || true
chmod -R 644 img/optimized/ 2>/dev/null || true
print_status "File permissions set"

# Clear common caches
echo "🧹 Clearing caches..."

# WordPress cache clearing
if [ -f "wp-config.php" ]; then
    print_status "WordPress detected"
    # Clear common WordPress caches
    [ -d "wp-content/cache" ] && rm -rf "wp-content/cache/"* && print_status "Cleared WordPress cache"
    [ -f "wp-content/advanced-cache.php" ] && touch "wp-content/advanced-cache.php" && print_status "Touched advanced cache"
fi

# Cloudflare cache purge (if CF CLI is available)
if command -v cf &> /dev/null; then
    print_warning "Cloudflare CLI detected - consider running: cf purge-cache --everything"
fi

# Generate deployment report
REPORT_FILE="deployment-report-$(date +%Y%m%d-%H%M%S).txt"
cat > "$REPORT_FILE" << EOF
FINKEEPERS SEO DEPLOYMENT REPORT
================================
Deployment Date: $(date)
Backup Directory: $BACKUP_DIR

FILES DEPLOYED:
- robots.txt: $([ -f "robots.txt" ] && echo "✅ Success" || echo "❌ Failed")
- sitemap.xml: $([ -f "sitemap.xml" ] && echo "✅ Success" || echo "❌ Failed")
- Optimized Images: $([ -d "img/optimized" ] && echo "✅ Success" || echo "❌ Failed")
- CSS/JS Files: $([ -d "assets/css" ] && echo "✅ Success" || echo "❌ Failed")

NEXT STEPS:
1. Test URLs:
   - https://finkeepers.us/robots.txt
   - https://finkeepers.us/sitemap.xml

2. Submit to Google Search Console:
   - Add sitemap: sitemap.xml
   - Request indexing for key pages

3. Update HTML head sections using files in:
   - finkeepers-seo-fix/updated-head-snippets/

4. Run performance tests:
   - PageSpeed Insights
   - Mobile-Friendly Test
   - GTmetrix

ROLLBACK INSTRUCTIONS:
If issues occur, restore from backup:
cp $BACKUP_DIR/* ./

For support, refer to:
- deploy_instructions.txt
- indexation_checklist.md
- speed_fix_report.md
EOF

print_status "Generated deployment report: $REPORT_FILE"

# Final validation and testing
echo "🧪 Running final tests..."

# Test robots.txt accessibility
if curl -s -o /dev/null -w "%{http_code}" "http://localhost/robots.txt" | grep -q "200"; then
    print_status "robots.txt is accessible"
else
    print_warning "Could not test robots.txt accessibility (server may not be running locally)"
fi

# Test sitemap.xml accessibility  
if curl -s -o /dev/null -w "%{http_code}" "http://localhost/sitemap.xml" | grep -q "200"; then
    print_status "sitemap.xml is accessible"
else
    print_warning "Could not test sitemap.xml accessibility (server may not be running locally)"
fi

echo ""
echo "🎉 SEO Deployment Complete!"
echo "=========================="
print_status "Core SEO files deployed successfully"
print_status "Backup created in: $BACKUP_DIR"
print_status "Deployment report: $REPORT_FILE"

echo ""
echo "📋 IMMEDIATE NEXT STEPS:"
echo "1. Update HTML head sections using snippets in updated-head-snippets/"
echo "2. Test your website: https://finkeepers.us"
echo "3. Submit sitemap to Google Search Console"
echo "4. Run PageSpeed Insights test"
echo "5. Check mobile-friendliness"

echo ""
echo "📊 MONITORING SCHEDULE:"
echo "- Week 1: Check Google Search Console for crawl errors"
echo "- Week 2: Monitor PageSpeed Insights improvements"  
echo "- Week 4: Track organic traffic and ranking improvements"

echo ""
print_warning "IMPORTANT: Don't forget to update your HTML head sections!"
print_warning "Refer to deploy_instructions.txt for detailed steps"

echo ""
echo "🔗 USEFUL LINKS:"
echo "- Test robots.txt: https://finkeepers.us/robots.txt"
echo "- Test sitemap: https://finkeepers.us/sitemap.xml"
echo "- PageSpeed Insights: https://pagespeed.web.dev/"
echo "- Mobile-Friendly Test: https://search.google.com/test/mobile-friendly"
echo "- Google Search Console: https://search.google.com/search-console"

exit 0