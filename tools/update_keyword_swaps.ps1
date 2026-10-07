$mapPath = "c:\Users\shree\OneDrive\Desktop\NTRY\SEO_KEYWORD_MAP.md"
$content = [System.IO.File]::ReadAllText($mapPath, [System.Text.Encoding]::UTF8)

# 1. Update CNC Jali Work pillar page primary keyword
$oldCncBlock = @'
#### CNC JALI WORK (pillar page)
- **Primary:** cnc jali — 3,600/mo, KD 33
- **Secondary:** cnc jali design (12,100) · modern jali design (4,400)
'@
$newCncBlock = @'
#### CNC JALI WORK (pillar page)
- **Primary:** cnc jali design — 12,100/mo, KD 37
- **Secondary:** cnc jali (3,600) · modern cnc design (9,900)
'@
$content = $content.Replace($oldCncBlock, $newCncBlock)

# 2. Update Stone Jali primary keyword
$oldStoneJaliBlock = @'
#### Stone Jali
- **Primary:** stone jali — 590/mo, KD 14
- **Secondary:** stone jail art (–)
'@
$newStoneJaliBlock = @'
#### Stone Jali
- **Primary:** stone jali design — 480/mo, KD 19
- **Secondary:** stone jali (590) · stone jail art (–)
'@
$content = $content.Replace($oldStoneJaliBlock, $newStoneJaliBlock)

# 3. Update Blog #4
$oldBlog4 = '| 4 | 1 | CNC Jali Design Ideas for Doors, Windows, Balconies & Partitions | cnc jali design (12,100) |'
$newBlog4 = '| 4 | 1 | Modern Jali Design Ideas for Doors, Windows, Balconies & Partitions | modern jali design (4,400) |'
$content = $content.Replace($oldBlog4, $newBlog4)

# 4. Update Blog #17
$oldBlog17 = '| 17 | 3 | Stone Jali Design: Types, Uses & Ideas | stone jali design (480) |'
$newBlog17 = '| 17 | 3 | Stone Lattice Screens & Jali Work: Heritage Types, Uses & Design Ideas | stone lattice (390) |'
$content = $content.Replace($oldBlog17, $newBlog17)

# 5. Update Coverage Tracker rows
$oldRowCnc = '| cnc jali | 3,600 | 33 | Commercial | CNC JALI WORK | PAGE |  |'
$newRowCnc = '| cnc jali | 3,600 | 33 | Commercial | CNC JALI WORK | PAGE (Secondary) |  |'
$content = $content.Replace($oldRowCnc, $newRowCnc)

$oldRowCncDes = '| cnc jali design | 12,100 | 37 | Informational | CNC JALI WORK | PAGE |  |'
$newRowCncDes = '| cnc jali design | 12,100 | 37 | Informational, Commercial | CNC JALI WORK | PAGE (Primary) |  |'
$content = $content.Replace($oldRowCncDes, $newRowCncDes)

$oldRowModJali = '| modern jali design | 4,400 | 30 | Informational, Commercial | CNC JALI WORK | PAGE |  |'
$newRowModJali = '| modern jali design | 4,400 | 30 | Informational | Blog #4 (Modern Jali Design Ideas) | BLOG (Primary) |  |'
$content = $content.Replace($oldRowModJali, $newRowModJali)

$oldRowStJali = '| stone jali | 590 | 14 | Informational | CNC JALI WORK | PAGE |  |'
$newRowStJali = '| stone jali | 590 | 14 | Informational | Stone Jali | PAGE (Secondary) |  |'
$content = $content.Replace($oldRowStJali, $newRowStJali)

$oldRowStJaliDes = '| stone jali design | 480 | 19 | Informational | CNC JALI WORK | PAGE |  |'
$newRowStJaliDes = '| stone jali design | 480 | 19 | Informational, Commercial | Stone Jali | PAGE (Primary) |  |'
$content = $content.Replace($oldRowStJaliDes, $newRowStJaliDes)

$oldRowStLat = '| stone lattice | 390 | 23 | Informational | CNC JALI WORK | PAGE |  |'
$newRowStLat = '| stone lattice | 390 | 23 | Informational | Blog #17 (Stone Lattice Screens) | BLOG (Primary) |  |'
$content = $content.Replace($oldRowStLat, $newRowStLat)

[System.IO.File]::WriteAllText($mapPath, $content, [System.Text.Encoding]::UTF8)
Write-Output "Successfully updated SEO_KEYWORD_MAP.md"
