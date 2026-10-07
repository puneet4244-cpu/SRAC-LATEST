$path = 'c:\Users\shree\OneDrive\Desktop\NTRY\cnc-jali-work\index.html'
$content = Get-Content $path -Raw

$content = $content.Replace(
    'industrial multi-axis computerized routing',
    'industrial 3-axis, 4-axis, and 5-axis CNC machinery'
)

$content = $content.Replace(
    'our Jaipur atelier manufactures panels to your exact wall framing or structural aperture dimensions. We supply direct to architects, luxury homeowners, and interior designers across India, complete with pre-drilled hardware channels and custom mounting borders.',
    'our Jaipur factory manufactures panels to your exact wall framing or structural aperture dimensions. We supply direct to architects, luxury homeowners, and interior designers across India and worldwide, complete with pre-drilled hardware channels and custom mounting borders.'
)

$content = $content.Replace(
    '<strong>Nationwide Safe Delivery:</strong> Heavy-duty shockproof crating ensures crisp fretwork edges arrive undamaged anywhere in India.',
    '<strong>Safe Doorstep Delivery:</strong> Wooden pallets and foam or chemical foam safe packing ensure crisp fretwork edges arrive undamaged to your doorstep across India and worldwide.'
)

$content = $content.Replace(
    'ATELIER WORKSHOP LOCATION',
    'FACTORY & WORKSHOP LOCATION'
)

$content = $content.Replace(
    'Contact Atelier',
    'Contact Us'
)

Set-Content $path -Value $content -NoNewline
Write-Host "Updated cnc-jali-work/index.html successfully."
