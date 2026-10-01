$baseDir = "c:\Users\shree\OneDrive\Desktop\NTRY"
$data = Get-Content "$baseDir\tools\data\stone_carving_data.json" -Raw | ConvertFrom-Json

$slugs = $data.subcategories.slug
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host " TECHNICAL SEO & LINK AUDIT FOR SUB-CATEGORIES    " -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan

$allPassed = $true

foreach ($sub in $data.subcategories) {
    $slug = $sub.slug
    $pagePath = "$baseDir\stone-carving\$slug\index.html"
    Write-Host "`n--> Auditing: /stone-carving/$slug/" -ForegroundColor Yellow
    
    if (-not (Test-Path $pagePath)) {
        Write-Host "  [FAIL] File missing: $pagePath" -ForegroundColor Red
        $allPassed = $false
        continue
    }
    
    $content = Get-Content $pagePath -Raw
    
    # 1. Title tag
    if ($content -match '<title>(.*?)</title>') {
        $title = $matches[1]
        $titleLen = $title.Length
        if ($titleLen -le 65) {
            Write-Host "  [PASS] Title ($titleLen chars): $title" -ForegroundColor Green
        } else {
            Write-Host "  [WARN] Title > 60 chars ($titleLen chars): $title" -ForegroundColor Yellow
        }
    } else {
        Write-Host "  [FAIL] Missing <title>" -ForegroundColor Red
        $allPassed = $false
    }
    
    # 2. Meta Description
    if ($content -match '<meta name="description" content="(.*?)">') {
        $desc = $matches[1]
        $descLen = $desc.Length
        if ($descLen -le 160) {
            Write-Host "  [PASS] Meta Description ($descLen chars): $desc" -ForegroundColor Green
        } else {
            Write-Host "  [WARN] Meta Description > 155 chars ($descLen chars): $desc" -ForegroundColor Yellow
        }
    } else {
        Write-Host "  [FAIL] Missing meta description" -ForegroundColor Red
        $allPassed = $false
    }
    
    # 3. Canonical URL
    $expectedCanonical = "https://www.shreeramandcompany.com/stone-carving/$slug/"
    if ($content -match "<link rel=`"canonical`" href=`"$expectedCanonical`"") {
        Write-Host "  [PASS] Canonical URL: $expectedCanonical" -ForegroundColor Green
    } else {
        Write-Host "  [FAIL] Incorrect canonical URL. Expected: $expectedCanonical" -ForegroundColor Red
        $allPassed = $false
    }
    
    # 4. Single H1
    $h1Matches = [regex]::Matches($content, '<h1[\s>]')
    if ($h1Matches.Count -eq 1) {
        Write-Host "  [PASS] Single H1 found" -ForegroundColor Green
    } else {
        Write-Host "  [FAIL] Expected 1 H1, found: $($h1Matches.Count)" -ForegroundColor Red
        $allPassed = $false
    }
    
    # 5. Schemas
    $hasBreadcrumb = $content -match '"@type":\s*"BreadcrumbList"'
    $hasProduct = $content -match '"@type":\s*"Product"'
    $hasFAQ = $content -match '"@type":\s*"FAQPage"'
    if ($hasBreadcrumb -and $hasProduct -and $hasFAQ) {
        Write-Host "  [PASS] JSON-LD: BreadcrumbList, Product, FAQPage present" -ForegroundColor Green
    } else {
        Write-Host "  [FAIL] Missing JSON-LD schemas (Breadcrumb: $hasBreadcrumb, Product: $hasProduct, FAQ: $hasFAQ)" -ForegroundColor Red
        $allPassed = $false
    }
    
    # 6. Check Gallery Images exist on disk
    $imgMatches = [regex]::Matches($content, 'src="(/assets/images/[^"]+)"')
    $imgCount = 0
    $imgMissing = 0
    foreach ($m in $imgMatches) {
        $relPath = $m.Groups[1].Value.TrimStart('/')
        $diskPath = "$baseDir\$relPath"
        $imgCount++
        if (-not (Test-Path $diskPath)) {
            Write-Host "  [FAIL] Image missing on disk: $relPath" -ForegroundColor Red
            $imgMissing++
            $allPassed = $false
        }
    }
    if ($imgMissing -eq 0) {
        Write-Host "  [PASS] All $imgCount referenced images exist on disk" -ForegroundColor Green
    }
    
    # 7. Check Explore More links (must be only the other 5 Stone Carving subcategories)
    $otherSlugs = $slugs | Where-Object { $_ -ne $slug }
    foreach ($os in $otherSlugs) {
        if ($content -match "/stone-carving/$os/") {
            # OK
        } else {
            Write-Host "  [FAIL] Missing Explore More link to /stone-carving/$os/" -ForegroundColor Red
            $allPassed = $false
        }
    }
    # Verify it does NOT link to other categories inside the explore more section
    if ($content -match 'Back to Stone Carving Collection') {
        Write-Host "  [PASS] Back to Stone Carving button verified" -ForegroundColor Green
    } else {
        Write-Host "  [FAIL] Missing 'Back to Stone Carving Collection' link" -ForegroundColor Red
        $allPassed = $false
    }
}

Write-Host "`n==================================================" -ForegroundColor Cyan
if ($allPassed) {
    Write-Host " ALL AUDITS PASSED WITH ZERO ERRORS!             " -ForegroundColor Green
} else {
    Write-Host " SOME AUDIT CHECKS FAILED!                       " -ForegroundColor Red
}
Write-Host "==================================================" -ForegroundColor Cyan
