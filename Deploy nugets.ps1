
function Deploy-Project($project, $apiKey) {
	$files = @()
	if (Test-Path $project\bin\release -PathType Container) {
		$files = Get-ChildItem $project\bin\release\*.nupkg
	} elseif (Test-Path $project\bin\x64\release -PathType Container) {
		$files = Get-ChildItem $project\bin\x64\release\*.nupkg
	}
	foreach ($f in $files) {
		$outputFile = Split-Path $f -leaf
		dotnet nuget push --source "byronGit" --api-key $apiKey --skip-duplicate $f
	}
}

Write-Host "Personal GitHub Access Token (aka Api-Key) " -ForegroundColor Yellow -NoNewline
$apiKey = Read-Host

Deploy-Project ".\BeiderMorse.Encoder" $apiKey

Write-Host "fertig - bitte Taste drücken..."
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
