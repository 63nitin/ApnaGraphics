$files = @("index.html", "services.html", "work.html", "contact.html")
foreach ($file in $files) {
    $content = Get-Content $file -Raw
    $content = $content -replace 'href="#contact"', 'href="contact.html"'
    Set-Content $file -Value $content
}
