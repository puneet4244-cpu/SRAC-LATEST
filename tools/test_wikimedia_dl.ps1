$wc = New-Object System.Net.WebClient
$wc.Headers.Add("User-Agent", "VietaStoneImageFetcher/1.0 (contact@shreeramstone.com)")
$url = "https://upload.wikimedia.org/wikipedia/commons/a/a4/Cenotaphs_at_Bada_Bagh%2C_Jaisalmer.jpg"
$out = "tools/staged/test_bada_bagh.jpg"
$wc.DownloadFile($url, $out)
(Get-Item $out).Length
