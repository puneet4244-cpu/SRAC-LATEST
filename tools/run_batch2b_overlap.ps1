$b2bPages = @(
    'stone-art-murals/radhe-krishna-stone-art-mural/index.html',
    'stone-art-murals/buddha-stone-art-mural/index.html',
    'stone-art-murals/durga-mata-ji-stone-art-mural/index.html',
    'stone-art-murals/ganesh-ji-stone-art-mural/index.html',
    'stone-art-murals/hanuman-ji-stone-art-mural/index.html',
    'stone-art-murals/laxmi-ji-stone-art-mural/index.html',
    'stone-art-murals/ram-darbar-stone-art-mural/index.html',
    'stone-art-murals/shiv-ji-stone-art-mural/index.html',
    'stone-art-murals/shreenath-ji-stone-art-mural/index.html',
    'stone-art-murals/swaminarayan-ji-stone-art-mural/index.html',
    'stone-art-murals/floral-stone-art/index.html',
    'stone-art-murals/village-stone-art-mural/index.html'
)

& "$PSScriptRoot\validate_shingle_overlap.ps1" -Pages $b2bPages -Threshold 0.30
